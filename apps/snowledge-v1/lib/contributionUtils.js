export function checkContributionStatus(reviews, contributorsCount) {
  try {
    const totalReviews = reviews.length;
    const approvalCount = reviews.filter((r) => r.status === "APPROVED").length;
    const rejectionCount = reviews.filter(
      (r) => r.status === "REJECTED"
    ).length;

    // Déterminer si le nombre de contributeurs est pair
    const isEven = contributorsCount % 2 === 0;

    // Calculer le seuil requis pour une décision
    const requiredVotes = isEven
      ? contributorsCount / 2 + 1 // Majorité stricte si pair
      : Math.ceil(contributorsCount / 2); // Moitié arrondie au supérieur si impair

    // Déterminer si un statut doit être mis à jour
    if (approvalCount >= requiredVotes) {
      console.log("approvalCount >= requiredVotes");
      return { shouldUpdate: true, newStatus: "APPROVED" };
    } else if (rejectionCount >= requiredVotes) {
      console.log("rejectionCount >= requiredVotes");
      return { shouldUpdate: true, newStatus: "REJECTED" };
    } else if (totalReviews === contributorsCount) {
      // Si tous les contributeurs ont voté mais pas de majorité claire, on rejette la contribution
      console.log("totalReviews === contributorsCount");
      return { shouldUpdate: true, newStatus: "REJECTED" };
    }

    console.log("approvalCount", approvalCount);
    console.log("rejectionCount", rejectionCount);
    console.log("totalReviews", totalReviews);
    console.log("contributorsCount", contributorsCount);
    console.log("requiredVotes", requiredVotes);

    return { shouldUpdate: false, newStatus: "PENDING" };
  } catch (error) {
    console.error(
      "Erreur lors de la vérification du statut de la contribution:",
      error
    );
    return { shouldUpdate: false, newStatus: "PENDING" };
  }
}
