import { prisma } from "@/lib/prisma";
import { NextResponse } from "next/server";
import { getServerSession } from "next-auth";
import { authOptions } from "@/lib/auth";
import { createBulkNotifications } from "@/lib/notifications";
import { NotificationType } from "@/types/notification";

// Récupérer tous les posts en attente d'une communauté
export async function GET(request, { params }) {
  try {
    const session = await getServerSession(authOptions);
    if (!session?.user?.id) {
      return NextResponse.json({ error: "Non autorisé" }, { status: 401 });
    }
    const { id: communityId } = await params;

    const user_id = session.user.id;

    // Récupérer les review de l'utilisateur
    const postReviews = await prisma.community_posts_reviews.findMany({
      where: {
        reviewer_id: parseInt(user_id),
      },
    });

    const pendingPosts = await prisma.community_posts.findMany({
      where: {
        community_id: parseInt(communityId),
        status: "PENDING",
        AND: {
          id: {
            notIn: postReviews.map((review) => review.post_id),
          },
          author_id: {
            not: parseInt(user_id),
          },
        },
      },
      include: {
        user: {
          select: {
            id: true,
            fullName: true,
            profilePicture: true,
          },
        },
        community_posts_reviews: {
          include: {
            user: {
              select: {
                id: true,
                fullName: true,
                profilePicture: true,
              },
            },
          },
        },
      },
    });

    return NextResponse.json(pendingPosts);
  } catch (error) {
    console.log("Erreur:", error.stack);
    return NextResponse.json(
      { error: "Erreur lors de la récupération des posts" },
      { status: 500 }
    );
  }
}

// Créer un nouveau post en attente
export async function POST(request, { params }) {
  try {
    const session = await getServerSession(authOptions);
    if (!session) {
      return NextResponse.json({ error: "Non autorisé" }, { status: 401 });
    }

    const { id: communityId } = await params;
    const { title, content, cover_image_url, tag, accept_contributions } =
      await request.json();

    // Vérifier que l'utilisateur est contributeur
    const isContributor = await prisma.community_contributors.findUnique({
      where: {
        community_id_contributor_id: {
          community_id: parseInt(communityId),
          contributor_id: parseInt(session.user.id),
        },
      },
    });

    if (!isContributor) {
      return NextResponse.json({ error: "Non autorisé" }, { status: 403 });
    }

    const post = await prisma.community_posts.create({
      data: {
        community_id: parseInt(communityId),
        author_id: parseInt(session.user.id),
        title,
        content,
        cover_image_url,
        tag: parseInt(tag),
        accept_contributions,
        status: "PENDING",
      },
    });


    const contributors = await prisma.community_contributors.findMany({
      where: {
        community_id: parseInt(communityId),
      },
      include: {
        user: {
          select: {
            id: true,
            fullName: true,
            userName: true,
            profilePicture: true,
          },
        },
      },
    });

    const formattedContributors = contributors.map((contributor) => ({
      id: contributor.user.id,
      fullName: contributor.user.fullName,
      userName: contributor.user.userName,
      profilePicture: contributor.user.profilePicture,
      joinedAt: contributor.added_at,
    }));

    //Extraire les IDs des membres (sauf le créateur qui a publié le post)
    const contributorsFiltered = formattedContributors.filter(
      (contributor) => contributor.id !== parseInt(session.user.id)
    );

    if (contributorsFiltered.length === 0) return NextResponse.json(post); // Pas de membres à notifier

    // Créer des notifications pour tous les membres en une seule opération
    await createBulkNotifications({
      userIds: contributorsFiltered.map((contributor) => contributor.id),
      title: "Nouveau post en attente de validation",
      message: `Un nouveau post "${post.title}" a été publié dans votre communauté et est en attente de validation`,
      type: NotificationType.NEW_POST_PENDING,
      link: `/community/${communityId}/posts/${post.id}/review`,
      metadata: {
        communityId,
        postId: post.id,
        creatorId: post.author_id,
      },
    });

    return NextResponse.json(post);
  } catch (error) {
    console.log("Erreur:", error.stack);
    return NextResponse.json(
      { error: "Erreur lors de la création du post" },
      { status: 500 }
    );
  }
}
