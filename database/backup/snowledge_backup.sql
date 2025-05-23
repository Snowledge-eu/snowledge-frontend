PGDMP  &    ;                }        	   defaultdb    16.8    16.9 (Homebrew) _    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16441 	   defaultdb    DATABASE     u   CREATE DATABASE defaultdb WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.UTF-8';
    DROP DATABASE defaultdb;
                avnadmin    false            �           0    0    SCHEMA public    COMMENT         COMMENT ON SCHEMA public IS '';
                   pg_database_owner    false    5            �            1255    16918    create_default_channels()    FUNCTION     $  CREATE FUNCTION public.create_default_channels() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Insertion des canaux par défaut pour chaque nouvelle communauté
    INSERT INTO community_channels (community_id, name, description, icon) VALUES
    (NEW.id, 'Chat général', 'Canal principal pour les discussions générales', '💬'),
    (NEW.id, 'Bienvenue', 'Canal dédié aux présentations des nouveaux membres', '👋'),
    (NEW.id, 'Annonces', 'Canal pour les informations importantes', '📢');
    
    RETURN NEW;
END;
$$;
 0   DROP FUNCTION public.create_default_channels();
       public          avnadmin    false            �            1255    16919    create_default_community_tags()    FUNCTION     �  CREATE FUNCTION public.create_default_community_tags() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO community_posts_category (community_id, name, label) VALUES
        (NEW.id, 'analyse-technique', 'Analyse Technique'),
        (NEW.id, 'analyse-macro', 'Analyse Macro'),
        (NEW.id, 'defi', 'DeFi'),
        (NEW.id, 'news', 'News'),
        (NEW.id, 'education', 'Éducation'),
        (NEW.id, 'trading', 'Trading');
    RETURN NEW;
END;
$$;
 6   DROP FUNCTION public.create_default_community_tags();
       public          avnadmin    false            �            1255    16920    update_updated_at_column()    FUNCTION     �   CREATE FUNCTION public.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$;
 1   DROP FUNCTION public.update_updated_at_column();
       public          avnadmin    false            �            1259    16921    user    TABLE     �  CREATE TABLE public."user" (
    id integer NOT NULL,
    "fullName" character varying(255) NOT NULL,
    "userName" character varying(50) NOT NULL,
    "profilePicture" text NOT NULL,
    email character varying(255) NOT NULL,
    password text NOT NULL,
    "accountAddress" character varying(65) NOT NULL,
    "publicKey" character varying(65) NOT NULL,
    "privateKey" character varying(160) NOT NULL,
    salt character varying(32) NOT NULL,
    iv character varying(32) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);
    DROP TABLE public."user";
       public         heap    avnadmin    false            �            1259    16928    User_id_seq    SEQUENCE     �   CREATE SEQUENCE public."User_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public."User_id_seq";
       public          avnadmin    false    215            �           0    0    User_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public."User_id_seq" OWNED BY public."user".id;
          public          avnadmin    false    216            �            1259    16929    _prisma_migrations    TABLE     �  CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);
 &   DROP TABLE public._prisma_migrations;
       public         heap    avnadmin    false            �            1259    16936    community_category    TABLE     �   CREATE TABLE public.community_category (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    label character varying(255) NOT NULL
);
 &   DROP TABLE public.community_category;
       public         heap    avnadmin    false            �            1259    16941    category_id_seq    SEQUENCE     �   CREATE SEQUENCE public.category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.category_id_seq;
       public          avnadmin    false    218            �           0    0    category_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.category_id_seq OWNED BY public.community_category.id;
          public          avnadmin    false    219            �            1259    16942 	   community    TABLE     �  CREATE TABLE public.community (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    creator_id integer NOT NULL,
    description text DEFAULT ''::text NOT NULL,
    image_url character varying(255),
    category_id integer NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.community;
       public         heap    avnadmin    false            �            1259    16950    community_bans    TABLE     �   CREATE TABLE public.community_bans (
    id integer NOT NULL,
    community_id integer NOT NULL,
    user_id integer NOT NULL,
    reason text NOT NULL,
    banned_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);
 "   DROP TABLE public.community_bans;
       public         heap    avnadmin    false            �            1259    16956    community_bans_id_seq    SEQUENCE     �   CREATE SEQUENCE public.community_bans_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.community_bans_id_seq;
       public          avnadmin    false    221            �           0    0    community_bans_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.community_bans_id_seq OWNED BY public.community_bans.id;
          public          avnadmin    false    222            �            1259    16964    community_contributors    TABLE     �   CREATE TABLE public.community_contributors (
    community_id integer NOT NULL,
    contributor_id integer NOT NULL,
    added_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
 *   DROP TABLE public.community_contributors;
       public         heap    avnadmin    false            �            1259    16968    community_contributors_requests    TABLE     �  CREATE TABLE public.community_contributors_requests (
    id integer NOT NULL,
    community_id integer NOT NULL,
    requester_id integer NOT NULL,
    justification text NOT NULL,
    expertise_domain character varying(255) NOT NULL,
    status character varying(50) DEFAULT 'PENDING'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    rejection_reason text
);
 3   DROP TABLE public.community_contributors_requests;
       public         heap    avnadmin    false            �            1259    16976 &   community_contributors_requests_id_seq    SEQUENCE     �   CREATE SEQUENCE public.community_contributors_requests_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 =   DROP SEQUENCE public.community_contributors_requests_id_seq;
       public          avnadmin    false    224            �           0    0 &   community_contributors_requests_id_seq    SEQUENCE OWNED BY     q   ALTER SEQUENCE public.community_contributors_requests_id_seq OWNED BY public.community_contributors_requests.id;
          public          avnadmin    false    225            �            1259    16977    community_id_seq    SEQUENCE     �   CREATE SEQUENCE public.community_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.community_id_seq;
       public          avnadmin    false    220            �           0    0    community_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.community_id_seq OWNED BY public.community.id;
          public          avnadmin    false    226            �            1259    16978    community_learners    TABLE     �   CREATE TABLE public.community_learners (
    community_id integer NOT NULL,
    learner_id integer NOT NULL,
    joined_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
 &   DROP TABLE public.community_learners;
       public         heap    avnadmin    false            �            1259    17048    community_proposal_votes    TABLE     �   CREATE TABLE public.community_proposal_votes (
    id integer NOT NULL,
    proposal_id integer NOT NULL,
    voter_id integer NOT NULL,
    vote character varying(50) NOT NULL,
    created_at timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP
);
 ,   DROP TABLE public.community_proposal_votes;
       public         heap    avnadmin    false            �            1259    17052    community_proposal_votes_id_seq    SEQUENCE     �   CREATE SEQUENCE public.community_proposal_votes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE public.community_proposal_votes_id_seq;
       public          avnadmin    false    228            �           0    0    community_proposal_votes_id_seq    SEQUENCE OWNED BY     c   ALTER SEQUENCE public.community_proposal_votes_id_seq OWNED BY public.community_proposal_votes.id;
          public          avnadmin    false    229            �            1259    17053    community_proposals    TABLE     �  CREATE TABLE public.community_proposals (
    id integer NOT NULL,
    community_id integer NOT NULL,
    author_id integer NOT NULL,
    title character varying(255) NOT NULL,
    description text NOT NULL,
    status character varying(50) DEFAULT 'PENDING'::character varying NOT NULL,
    possible_contributors text,
    created_at timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP
);
 '   DROP TABLE public.community_proposals;
       public         heap    avnadmin    false            �            1259    17061    community_proposals_id_seq    SEQUENCE     �   CREATE SEQUENCE public.community_proposals_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.community_proposals_id_seq;
       public          avnadmin    false    230            �           0    0    community_proposals_id_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.community_proposals_id_seq OWNED BY public.community_proposals.id;
          public          avnadmin    false    231            �           2604    17088    community id    DEFAULT     l   ALTER TABLE ONLY public.community ALTER COLUMN id SET DEFAULT nextval('public.community_id_seq'::regclass);
 ;   ALTER TABLE public.community ALTER COLUMN id DROP DEFAULT;
       public          avnadmin    false    226    220            �           2604    17089    community_bans id    DEFAULT     v   ALTER TABLE ONLY public.community_bans ALTER COLUMN id SET DEFAULT nextval('public.community_bans_id_seq'::regclass);
 @   ALTER TABLE public.community_bans ALTER COLUMN id DROP DEFAULT;
       public          avnadmin    false    222    221            �           2604    17090    community_category id    DEFAULT     t   ALTER TABLE ONLY public.community_category ALTER COLUMN id SET DEFAULT nextval('public.category_id_seq'::regclass);
 D   ALTER TABLE public.community_category ALTER COLUMN id DROP DEFAULT;
       public          avnadmin    false    219    218            �           2604    17092 "   community_contributors_requests id    DEFAULT     �   ALTER TABLE ONLY public.community_contributors_requests ALTER COLUMN id SET DEFAULT nextval('public.community_contributors_requests_id_seq'::regclass);
 Q   ALTER TABLE public.community_contributors_requests ALTER COLUMN id DROP DEFAULT;
       public          avnadmin    false    225    224            �           2604    17101    community_proposal_votes id    DEFAULT     �   ALTER TABLE ONLY public.community_proposal_votes ALTER COLUMN id SET DEFAULT nextval('public.community_proposal_votes_id_seq'::regclass);
 J   ALTER TABLE public.community_proposal_votes ALTER COLUMN id DROP DEFAULT;
       public          avnadmin    false    229    228            �           2604    17102    community_proposals id    DEFAULT     �   ALTER TABLE ONLY public.community_proposals ALTER COLUMN id SET DEFAULT nextval('public.community_proposals_id_seq'::regclass);
 E   ALTER TABLE public.community_proposals ALTER COLUMN id DROP DEFAULT;
       public          avnadmin    false    231    230            �           2604    17105    user id    DEFAULT     f   ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public."User_id_seq"'::regclass);
 8   ALTER TABLE public."user" ALTER COLUMN id DROP DEFAULT;
       public          avnadmin    false    216    215            �          0    16929    _prisma_migrations 
   TABLE DATA           �   COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
    public          avnadmin    false    217   }�       �          0    16942 	   community 
   TABLE DATA           v   COPY public.community (id, name, creator_id, description, image_url, category_id, created_at, updated_at) FROM stdin;
    public          avnadmin    false    220   ˇ       �          0    16950    community_bans 
   TABLE DATA           V   COPY public.community_bans (id, community_id, user_id, reason, banned_at) FROM stdin;
    public          avnadmin    false    221   �       �          0    16936    community_category 
   TABLE DATA           =   COPY public.community_category (id, name, label) FROM stdin;
    public          avnadmin    false    218   ��       �          0    16964    community_contributors 
   TABLE DATA           X   COPY public.community_contributors (community_id, contributor_id, added_at) FROM stdin;
    public          avnadmin    false    223   ��       �          0    16968    community_contributors_requests 
   TABLE DATA           �   COPY public.community_contributors_requests (id, community_id, requester_id, justification, expertise_domain, status, created_at, updated_at, rejection_reason) FROM stdin;
    public          avnadmin    false    224   ~�       �          0    16978    community_learners 
   TABLE DATA           Q   COPY public.community_learners (community_id, learner_id, joined_at) FROM stdin;
    public          avnadmin    false    227   �       �          0    17048    community_proposal_votes 
   TABLE DATA           _   COPY public.community_proposal_votes (id, proposal_id, voter_id, vote, created_at) FROM stdin;
    public          avnadmin    false    228   �       �          0    17053    community_proposals 
   TABLE DATA           �   COPY public.community_proposals (id, community_id, author_id, title, description, status, possible_contributors, created_at, updated_at) FROM stdin;
    public          avnadmin    false    230   u�       �          0    16921    user 
   TABLE DATA           �   COPY public."user" (id, "fullName", "userName", "profilePicture", email, password, "accountAddress", "publicKey", "privateKey", salt, iv, created_at, updated_at) FROM stdin;
    public          avnadmin    false    215   �       �           0    0    User_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public."User_id_seq"', 239, true);
          public          avnadmin    false    216            �           0    0    category_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.category_id_seq', 16, true);
          public          avnadmin    false    219            �           0    0    community_bans_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.community_bans_id_seq', 12, true);
          public          avnadmin    false    222            �           0    0 &   community_contributors_requests_id_seq    SEQUENCE SET     U   SELECT pg_catalog.setval('public.community_contributors_requests_id_seq', 46, true);
          public          avnadmin    false    225            �           0    0    community_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.community_id_seq', 116, true);
          public          avnadmin    false    226            �           0    0    community_proposal_votes_id_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.community_proposal_votes_id_seq', 5, true);
          public          avnadmin    false    229            �           0    0    community_proposals_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.community_proposals_id_seq', 4, true);
          public          avnadmin    false    231            �           2606    17126    user User_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public."user"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (id);
 <   ALTER TABLE ONLY public."user" DROP CONSTRAINT "User_pkey";
       public            avnadmin    false    215            �           2606    17128 *   _prisma_migrations _prisma_migrations_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public._prisma_migrations DROP CONSTRAINT _prisma_migrations_pkey;
       public            avnadmin    false    217            �           2606    17130     community_category category_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.community_category
    ADD CONSTRAINT category_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.community_category DROP CONSTRAINT category_pkey;
       public            avnadmin    false    218                        2606    17132 "   community_bans community_bans_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.community_bans
    ADD CONSTRAINT community_bans_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.community_bans DROP CONSTRAINT community_bans_pkey;
       public            avnadmin    false    221                       2606    17136 2   community_contributors community_contributors_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.community_contributors
    ADD CONSTRAINT community_contributors_pkey PRIMARY KEY (community_id, contributor_id);
 \   ALTER TABLE ONLY public.community_contributors DROP CONSTRAINT community_contributors_pkey;
       public            avnadmin    false    223    223                       2606    17138 _   community_contributors_requests community_contributors_requests_community_id_contributor_id_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.community_contributors_requests
    ADD CONSTRAINT community_contributors_requests_community_id_contributor_id_key UNIQUE (community_id, requester_id);
 �   ALTER TABLE ONLY public.community_contributors_requests DROP CONSTRAINT community_contributors_requests_community_id_contributor_id_key;
       public            avnadmin    false    224    224            
           2606    17140 D   community_contributors_requests community_contributors_requests_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.community_contributors_requests
    ADD CONSTRAINT community_contributors_requests_pkey PRIMARY KEY (id);
 n   ALTER TABLE ONLY public.community_contributors_requests DROP CONSTRAINT community_contributors_requests_pkey;
       public            avnadmin    false    224                       2606    17142 *   community_learners community_learners_pkey 
   CONSTRAINT     ~   ALTER TABLE ONLY public.community_learners
    ADD CONSTRAINT community_learners_pkey PRIMARY KEY (community_id, learner_id);
 T   ALTER TABLE ONLY public.community_learners DROP CONSTRAINT community_learners_pkey;
       public            avnadmin    false    227    227            �           2606    17144    community community_name_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.community
    ADD CONSTRAINT community_name_key UNIQUE (name);
 F   ALTER TABLE ONLY public.community DROP CONSTRAINT community_name_key;
       public            avnadmin    false    220            �           2606    17146    community community_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.community
    ADD CONSTRAINT community_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.community DROP CONSTRAINT community_pkey;
       public            avnadmin    false    220                       2606    17168 6   community_proposal_votes community_proposal_votes_pkey 
   CONSTRAINT     t   ALTER TABLE ONLY public.community_proposal_votes
    ADD CONSTRAINT community_proposal_votes_pkey PRIMARY KEY (id);
 `   ALTER TABLE ONLY public.community_proposal_votes DROP CONSTRAINT community_proposal_votes_pkey;
       public            avnadmin    false    228                       2606    17170 ,   community_proposals community_proposals_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.community_proposals
    ADD CONSTRAINT community_proposals_pkey PRIMARY KEY (id);
 V   ALTER TABLE ONLY public.community_proposals DROP CONSTRAINT community_proposals_pkey;
       public            avnadmin    false    230            �           2606    17176    user email_unique 
   CONSTRAINT     O   ALTER TABLE ONLY public."user"
    ADD CONSTRAINT email_unique UNIQUE (email);
 =   ALTER TABLE ONLY public."user" DROP CONSTRAINT email_unique;
       public            avnadmin    false    215                       2606    17180 (   community_bans unique_community_user_ban 
   CONSTRAINT     t   ALTER TABLE ONLY public.community_bans
    ADD CONSTRAINT unique_community_user_ban UNIQUE (community_id, user_id);
 R   ALTER TABLE ONLY public.community_bans DROP CONSTRAINT unique_community_user_ban;
       public            avnadmin    false    221    221            �           2606    17184    user username_unique 
   CONSTRAINT     W   ALTER TABLE ONLY public."user"
    ADD CONSTRAINT username_unique UNIQUE ("userName");
 @   ALTER TABLE ONLY public."user" DROP CONSTRAINT username_unique;
       public            avnadmin    false    215                       1259    17188    idx_community_bans_community_id    INDEX     b   CREATE INDEX idx_community_bans_community_id ON public.community_bans USING btree (community_id);
 3   DROP INDEX public.idx_community_bans_community_id;
       public            avnadmin    false    221                       1259    17189    idx_community_bans_user_id    INDEX     X   CREATE INDEX idx_community_bans_user_id ON public.community_bans USING btree (user_id);
 .   DROP INDEX public.idx_community_bans_user_id;
       public            avnadmin    false    221                       1259    17195    idx_proposal_author    INDEX     X   CREATE INDEX idx_proposal_author ON public.community_proposals USING btree (author_id);
 '   DROP INDEX public.idx_proposal_author;
       public            avnadmin    false    230                       1259    17196    idx_proposal_community    INDEX     ^   CREATE INDEX idx_proposal_community ON public.community_proposals USING btree (community_id);
 *   DROP INDEX public.idx_proposal_community;
       public            avnadmin    false    230                       1259    17197    idx_proposal_status    INDEX     U   CREATE INDEX idx_proposal_status ON public.community_proposals USING btree (status);
 '   DROP INDEX public.idx_proposal_status;
       public            avnadmin    false    230                       1259    17198    idx_proposal_votes_proposal    INDEX     g   CREATE INDEX idx_proposal_votes_proposal ON public.community_proposal_votes USING btree (proposal_id);
 /   DROP INDEX public.idx_proposal_votes_proposal;
       public            avnadmin    false    228                       1259    17199    idx_proposal_votes_voter    INDEX     a   CREATE INDEX idx_proposal_votes_voter ON public.community_proposal_votes USING btree (voter_id);
 ,   DROP INDEX public.idx_proposal_votes_voter;
       public            avnadmin    false    228                       1259    17211    unique_proposal_voter    INDEX     r   CREATE UNIQUE INDEX unique_proposal_voter ON public.community_proposal_votes USING btree (proposal_id, voter_id);
 )   DROP INDEX public.unique_proposal_voter;
       public            avnadmin    false    228    228            $           2620    17212 )   community trigger_create_default_channels    TRIGGER     �   CREATE TRIGGER trigger_create_default_channels AFTER INSERT ON public.community FOR EACH ROW EXECUTE FUNCTION public.create_default_channels();
 B   DROP TRIGGER trigger_create_default_channels ON public.community;
       public          avnadmin    false    220    243            %           2620    17213 /   community trigger_create_default_community_tags    TRIGGER     �   CREATE TRIGGER trigger_create_default_community_tags AFTER INSERT ON public.community FOR EACH ROW EXECUTE FUNCTION public.create_default_community_tags();
 H   DROP TRIGGER trigger_create_default_community_tags ON public.community;
       public          avnadmin    false    244    220            &           2620    17214 %   community update_community_updated_at    TRIGGER     �   CREATE TRIGGER update_community_updated_at BEFORE UPDATE ON public.community FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();
 >   DROP TRIGGER update_community_updated_at ON public.community;
       public          avnadmin    false    245    220                       2606    17225 ?   community_contributors community_contributors_community_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.community_contributors
    ADD CONSTRAINT community_contributors_community_id_fkey FOREIGN KEY (community_id) REFERENCES public.community(id) ON DELETE CASCADE;
 i   ALTER TABLE ONLY public.community_contributors DROP CONSTRAINT community_contributors_community_id_fkey;
       public          avnadmin    false    223    4350    220                       2606    17230 Q   community_contributors_requests community_contributors_requests_community_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.community_contributors_requests
    ADD CONSTRAINT community_contributors_requests_community_id_fkey FOREIGN KEY (community_id) REFERENCES public.community(id) ON DELETE CASCADE;
 {   ALTER TABLE ONLY public.community_contributors_requests DROP CONSTRAINT community_contributors_requests_community_id_fkey;
       public          avnadmin    false    224    220    4350                       2606    17235 :   community_contributors community_contributors_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.community_contributors
    ADD CONSTRAINT community_contributors_user_id_fkey FOREIGN KEY (contributor_id) REFERENCES public."user"(id) NOT VALID;
 d   ALTER TABLE ONLY public.community_contributors DROP CONSTRAINT community_contributors_user_id_fkey;
       public          avnadmin    false    223    215    4338                       2606    17240 7   community_learners community_learners_community_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.community_learners
    ADD CONSTRAINT community_learners_community_id_fkey FOREIGN KEY (community_id) REFERENCES public.community(id) ON DELETE CASCADE;
 a   ALTER TABLE ONLY public.community_learners DROP CONSTRAINT community_learners_community_id_fkey;
       public          avnadmin    false    220    227    4350                       2606    17245 2   community_learners community_learners_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.community_learners
    ADD CONSTRAINT community_learners_user_id_fkey FOREIGN KEY (learner_id) REFERENCES public."user"(id) NOT VALID;
 \   ALTER TABLE ONLY public.community_learners DROP CONSTRAINT community_learners_user_id_fkey;
       public          avnadmin    false    215    4338    227                        2606    17265 B   community_proposal_votes community_proposal_votes_proposal_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.community_proposal_votes
    ADD CONSTRAINT community_proposal_votes_proposal_id_fkey FOREIGN KEY (proposal_id) REFERENCES public.community_proposals(id) ON DELETE CASCADE;
 l   ALTER TABLE ONLY public.community_proposal_votes DROP CONSTRAINT community_proposal_votes_proposal_id_fkey;
       public          avnadmin    false    228    230    4371            !           2606    17270 ?   community_proposal_votes community_proposal_votes_voter_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.community_proposal_votes
    ADD CONSTRAINT community_proposal_votes_voter_id_fkey FOREIGN KEY (voter_id) REFERENCES public."user"(id);
 i   ALTER TABLE ONLY public.community_proposal_votes DROP CONSTRAINT community_proposal_votes_voter_id_fkey;
       public          avnadmin    false    228    215    4338            "           2606    17275 6   community_proposals community_proposals_author_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.community_proposals
    ADD CONSTRAINT community_proposals_author_id_fkey FOREIGN KEY (author_id) REFERENCES public."user"(id);
 `   ALTER TABLE ONLY public.community_proposals DROP CONSTRAINT community_proposals_author_id_fkey;
       public          avnadmin    false    230    4338    215            #           2606    17280 9   community_proposals community_proposals_community_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.community_proposals
    ADD CONSTRAINT community_proposals_community_id_fkey FOREIGN KEY (community_id) REFERENCES public.community(id) ON DELETE CASCADE;
 c   ALTER TABLE ONLY public.community_proposals DROP CONSTRAINT community_proposals_community_id_fkey;
       public          avnadmin    false    220    4350    230                       2606    17320 *   community_bans fk_community_bans_community    FK CONSTRAINT     �   ALTER TABLE ONLY public.community_bans
    ADD CONSTRAINT fk_community_bans_community FOREIGN KEY (community_id) REFERENCES public.community(id) ON DELETE CASCADE;
 T   ALTER TABLE ONLY public.community_bans DROP CONSTRAINT fk_community_bans_community;
       public          avnadmin    false    221    4350    220                       2606    17325 %   community_bans fk_community_bans_user    FK CONSTRAINT     �   ALTER TABLE ONLY public.community_bans
    ADD CONSTRAINT fk_community_bans_user FOREIGN KEY (user_id) REFERENCES public."user"(id);
 O   ALTER TABLE ONLY public.community_bans DROP CONSTRAINT fk_community_bans_user;
       public          avnadmin    false    215    221    4338                       2606    17330    community fk_community_category    FK CONSTRAINT     �   ALTER TABLE ONLY public.community
    ADD CONSTRAINT fk_community_category FOREIGN KEY (category_id) REFERENCES public.community_category(id);
 I   ALTER TABLE ONLY public.community DROP CONSTRAINT fk_community_category;
       public          avnadmin    false    4346    220    218                       2606    17335    community fk_community_creator    FK CONSTRAINT     �   ALTER TABLE ONLY public.community
    ADD CONSTRAINT fk_community_creator FOREIGN KEY (creator_id) REFERENCES public."user"(id) NOT VALID;
 H   ALTER TABLE ONLY public.community DROP CONSTRAINT fk_community_creator;
       public          avnadmin    false    215    220    4338            �   >  x����n�7�;W��������0$��dI���N�&�:0��_��9���ht�R���foE��b�) T�����n^�uNdt�},p���E;�Z��[�	�� j�t�����	��x�p�W��� p����q8|��W����b�2�ziHRF#.JU)����F�F�;�L�l͘��1T����0w����F��'X����.�DtT!�vq=���Dt�痸���0���Z �`{����VSi)-J�1����0�5u���PS����sp�n��Q�;9ߛ>GP����&��͆s��o����؅��V:{<�K���3r�7��ar^Z�j�4j+�\:́>Sl��#bk����̢U��h��1,ܮ2cO��@l�:i�⿺�l�����#�m�ݐ?��'��	���q�|�[e��� He�6�7X>ͽS*��8L�q�gw"�"?�H��}��l���X����ҷ\��H��^9������Ƴ�����'��о��Qf�brP8z#�6�U׼��H,�:2�)x
O]�82L3��*-�h#ϧ�\#��_���ގ ��G_�A����ׯ�q��?=��ۛ;�W��-֏���Ys��۴���,9ڵ4��#�V4��V��{s��\Gƒ[!���6��3��2�Ɏ��x���y�����	��R\9f�r}��A�6��/W��xO��Ľ�я��Z,�QV�D._�2���`���I���z��W��r���P����㪴��K�\TKr�s�7���ӝ�AJ,��$�ӹSt������/q~�/���x���P��1~������?��A      �   	  x��Xˎ�]���Y�ҥ�DJ�����4t��(��DJ|ؖV��d�M�l�M�
R���,�0�#���\R�W� @�
U�I����>���j,��-��VS��*����ˈ��䈩�w�:{�A�$i/F�Qu��������PGQ-dx��V�N�����k��7N
c��h��%��ƼB�4pm�1�w'T9�[^b��E��WV����d��=G5=(-G�����JI� ����ePF�H�^
)ՁZ�**��Z��`xm#�o<��Y�� �:�x���;8�Z~з�rp�1�E�)���桌N �\K�=<�Ni03����?���A�VV1�-��Ѓ�p�K�,�O�TPȿ����d@�KU�:�);�����?!��Հ-��{�J�t,c���X��4�/���K�D
}1����J�J4�U��UϹ�S{UQ?p�҈u�U߈�6ߔ��k.X�5�A�-�U�3�w�1]	\ɒ�M��*����"�|L����8ͮb|��Q��&�6ɢ5N�t��8�߻/���>8��%�Wi�W߃�|�/+߯��Kp��d��-I����/[d��ɋur�?[�/�/)����J.h՞ʣ�U�5?1����i.��N��2xQ�e�:[��f�j_lq���_o�,���ɢ}�z��F�D�#z�:ԇ�w�����:❝K�øl��X0��N�')R5�UI��4;Vd��\��Z�'	��1y�!l����,%�b�Fsj�F� �U?�+(k�l���3qW� �C(ܲ(z^ �xb���Su��-�	g��Z��:���� �����X����H�����6�D�&��x��o3�yN.Q�īk��khepӛ����rA�kQ�PgP	���U%���As� d���'W)F^�f'Q���m%i���bɢX��E��Jqz	,�t{*� �[��6��`�M�(&I�EP�z%V�fnv��ҳP�h���ee7ka��xb�a$���Ɣ�*?t��d��;ݲ���8��L�8ɣ��g!�� ����y~��|�y7�?B�O��mvBbNYݐI�e6��Lv��et7�V�|���աw�N��/JH��-n��MȾ�z�1���f����߳����2�r��j[�>`�Ni&���znk��jb��]tOɃ����5�6^G�x�h<�z�������2h�W���~�<��N����mG��lǒP;��|y��,o�f�	ٍ8�D���4�fhNǬ�Gzl�4��<b�Y����K���7׾��"J
��7o���ꃥz/���݇K�����YHJ6w��9���:��c|,'�f�<�c5��,1��nT�>�K�5�
����s+l��
f/]a�8�_��7a��z0I�q���(��_8w�JSh�P��"'`xx4 sB(M6;M�ٳ2���I�|����*�דNu'ǣ����L��f7��t0'���šGfI��SLi�-U�1�,� MO�Y&��~4�Dh���t�z�p��p��	�V��!-�~���4����W[��9�s��.��ks#�sSt9X;����ˑ��0�v��Gs�e�k�5'�ˬz�]�|����>ߘ��K�YG�z�eK��x�����.�=�ҷ+O���>L�܆�[���y2$$�b��0���0�g��=��2�|bl�F�̰*���i�;i���9�Ş�V�]��=��"�J�[�8v��`�o.#�@:|��_*p �Y���z���?��B��
	���Q~��P
�)%�S��d���/��_3�
�8: �6G����씐�ORI�	���g=���|���j֞o^��JV�ӟ��8��e����Vt�(x�����4y�`9k���ůo��16 �iu�E{���21_��G�!Z�� "�{����v>n$~4Uâ�2���[ a%@�<Pg��|�#�@_�Oy���@�;*�i�];4�\��\��8 ��)�W���>`q�ֵ�SCt��Cʟ�dLءϟ���W�t�üǹ� <���JÌ��O(�-�aЕ��!��;�J�����HZ��������* ����5��R���^�:QBb��BWah��n�Ý���"����ʛ������ ���&��W��p�����i��eA|y���𵆯��:d r=���W�ܻ��~��ASpg/��#�#"<�y���i[�y�(vy�\��le��8��lhs��q��*`d��g��vs�f�=j�����@]�2:}�^�x�_����      �   �   x�e��R�0Ek�+�Q0�H~�-CC%�	&�M a�'���Xf��s4WW1)Yb������i�֯O&P�e��a��� ]"v�ڳ����>>��s^�) 0[�k��e��4��ۖ�}�`��0�u��4�	��B.�)�m�b�ic�1���F�»�K6�0���+xNQP����\=m�>H�jt�֑��Ϝ�W�K�|��0�5�C���of�\RP�[�;v��I���n��9b}��w]�"�b�      �   �   x�E�1
�@E�Sleg`M,%�`�U��&n&2�̆�A��b�œh������o����fe.t+qێ�M&���p\�)�H�XAG=Á��W8�Ɛ�:y� 	m	#�<wZ����cô��8��>�q��n��z����O��u(�Z ��m>�      �   �   x�e�ۑ!��6
h��C�X&�8{v�{j��;�T9�v��,'�'<��Ś�e=�:"YS-�'�<;F�H(	��5?�Xi�&�͂�a�^���Isɛ��dI[d�mEq�l�#��40�}tXJ�Vh�s�W�H3������s��R��Q���y�{EP�,���꭮�ǵѿ�:��)҃جʫu���ބ���~ �iP/      �   �  x��W�v�6]�_��76�7A���Ok��j�����	E* �$��,�.��� I�D)�M�Cr��w�\#�3}�k��������u�
q��%�La&�
&�1�@�i��L�z{{ƳdS�w���p�� d!a��u�9���	�Lh��|�+k�F�=S�!814?��GT��2�˓�,�s�[�����9���}����D	#T�
L���F/��C;x\�w�����;|o�������Puxhp�.p�6���C��4�vV5�.�+�k�]_BƸ8ŐLJa�`�P�
���LLDϕD7`��۪wx�˶��.��F� ����6%\�l"�g��V��.�z�ۦO7����l��]��>���"x�)�z��Gp�5�d�U�)*�%*�9��L�UD��~�}{��v�zo���]}? ����]���>��.]�kׄ��_�]����7:*<����1�sC��Z�bc*�;��v�!�}��Hf�ٷ���b��a@�����yx�m�^�-^�*]�);�Y�B�1K6��F�^��@ߜ�
O��vX���/ ��J8�>-�����a�j�b^C���C�p�o\����D�b'��+���A���(��|5�b���6��
��ff��!P�ʰ����pm��UY��#o,1T���0>KC�Ԋ��71����6q���^����wW��3UyAy �L�C� ���D"����r9]NQ8��X��,+p��T�\'+#Xd
!{e��f�`�����㬤���\�\�m�MHd� X�glk�	
��!��}�^m��
��@���!�T�Cy̡�1���0R���~?[Gb�_8p'"�{���}N&7c�rN��5l<[���;t��k�������9vU�`Dfb,�fc����٧�A��[B�MK���̈�n�G�<݇�m\��]�͡TS�]��H�� FYL|���e��'ե�b	�|,��1<"#��M�&�kr\%�K�ŰAX6�C�s����r�ٮ�oa_w}l����6}`�7�&[V���rӑ��7ĳ�QG�e�bM1W�P����q�l�M�H�YձS�����}�����"A��t(7uB�s��Q�ӧ��'4���.΀��E�3uR�	 Kc 'P �tོdS�I0D�nN�>	����<Xo�Ƭ�;��Lj�Om���������a�R0+E��\"Uʀ�{c֏������������W�M�tPA�ٟC�x�𮱾�}h��z�B��U9����w��޾�Ѡ���f� = ��C�#�n�ó���m�_�iݖK ��V^r�i���J���(�!������zբI;�����0���0�Pw�[rvv�$���      �   �  x�m�ۑ�0D��Q8�Q�F"����h��*���6������^�'A I��x����B�����"���}aܸ�!��I�怜������'jh�����n؂,s�e�����<�Wo�&��	#��X�>��H$_(_�0o�'z�s�漴�o����^��k�>6��|�1�mB��<��P#��[@>�>J�8��Ź�6g5mۤU�#P纳u��
dh��@����l�\O�}kk���}��|m�.�ڒ�;y�'��7��%|rN��"o������:�g��d8қ�b�x��
)��]~���	Y^�i݋�/>���_���\Á�v�s�_C/u��1|8�	��^�-s��7���=��R���T�ƻ\7��M��f�s7�ms�Gm���,�o���=7�k�����C�T.��������*�����8#��      �   z   x�}�;
1��Z>���B���$�.[�����K`ʏ�!=���߯'�hl�P��Z�3��D�N��/�U e�)�]��rګ�V)=#ؼ-���vn6xZ$��c�X��×�p)�p�+�      �   �   x�}�;N1E��U��(#3wA 
ti���,�y�Y�ƘI�?P�JW��<�2�����7_�����ξu�~��ws�[���:�:Y����� ^��ݣy��N�R9di�e�/�X�P�OExgPn��'�.d\{�&�n�����)/��	;˘߷��v�^�_8Ō�PZ��R�g :%��5-�R\�u8���Q�l���L%?�]UD�r���{؇���B^N+-����/ԓ��
B���}�      �      x�ĽYWI�,|��}�u��G�<����&�1`n��#�$� �ן�����~}�>�lcS��J���#2w�ތ����_#~�?�����ݫ��ɬN.������f��imy�������y1���4.��C]�,��ZN�z�&�����u{���^������C�F]��C��Ӌ�ż^�U���w��jq�<zi��ۗ�F����H�?�>.��m�y�<����8���ǳ�g!N���O�k'�/�w�����<���F����֔dUrQ���RI�5Ҩ�Bo�D�#9��M׭�`r�gP�j�R�5����iق+����T�e�ve���kCh*T�|�aBn�jcD��G�A{u��7ٺSQ� ���B�Um*��ڞ]V&w�\��'�׏8�1��T.�%��w.e�BY�S̽:�m��k�j��5�p_��~�J"+��7X��R�l|p�Ki�.U8�|�ōd��e����z�Uw<�음N�.���#��ҽ�����폎�"}��m��?�r?�L�&�==�E�x�~9���>�6mu�����F�M���si7�}���o߀��QN76/w�ǳ�'�G�W���3{�z7;<}~����߶���G��]i��M(�'R�e%�&uPZ�*�ń�d� ��X'�0�	��3d<\��6x�9v�j�=�����Z��M�ZY]�=
�P:�+j��! }�;%]�(i
gR��&�$\z����|IFe�%�ĥ�iB�djQ�������R��jL	�������@{T��U8k�%+ �[c]Fo���E����d�B�3���|O]5�.7
�g�ٶ��/9Q�5*)���|"%^��ʈq��G��A�RJ�ÿ~���]^�\̓��������V�l��MV+s����\�z������zQo�^7��x�� {��m�?�v��f�n}.��|�>�*�>.������������p[��[r����ѽ� �7G��X��Z��4���bJ���䂐5����0x5]Z�]1���g0V���Ժ�^� tݫ��1բ�-�B��E��t�V#@ J�l�D��jR3�Y�B�j�R�Rņ~�\�!Wn�[Q�)rJ�J�q+I�҃��Ԁ�N��S˸�ֺ6���U��$g�F�Q����"h7�bW�-�!}��>W1��"$��@�:Vg�u�{����U�WB��f,�^z4������ ���������`+������f���/y��4~��7�;�a��:�=s���[#�f����[o +RO6����S ^:Q�C�U�$EW dN��*��*d��VbK�Ƶ�b��� � ��HH��m��h{Tg�x�+��p`�X[���mU!(��L�5��
h�׎�w=�	H�qM��������mb t=� �u
�?�q�R��[�Bh�b� 6C�	Is�tS+Āirl�qR)�Q��X2����	D^�Kߌ�R���󫩂����r����?:���_÷�_?�Z���sq��Z��l��V�œ�N����a2iN���Z���h��������K��9<_�p�f�O�˲�2>�[K���E�T[ǟ�;]����~:�� !�"%�L�R�"�ųV����ZGH��.b
�hsG�BxAB�EZU�h) �FU
���hoѱ#n]�*PFZZ�5��!�UF�=/���C�
���qI*�38?bU�
��~F�������AYA�iiZ
Pat�5�Q,�j���l�#[�GC��ǆ�v	�D���� *����J�>�U�� �H��O�V�3��m
���r]M���r��̤�`ɼ��1��80fG��?~��/_?���2{ԓ��ż<>�Z/o�۲���|gl��z�x{�P���ϗ�fD����7~�n�2��k�?��o��׎��O�ũ<���;�o?Lg���|z���NIH.A�tk�@D �O&�)��lU�\
Ē��q��^wC^�I0� ��-&��V��v��\h�ޝU:A�7���6�`գ�4���8J(�7�"<J�h����s���i>�� ({��)�*pJ�� 26�T�>�> *�MDK�q�-�G�*����	��Ǩ!$+bv������1ۂۢ�]G��������A��� �6���!@X�f������C���8��F�_�~���ߧ�������w�2����g�v�!���������'�9�|���L튓Zo�Ӈ��6@&U-$G�9S�>kJi��
�� m��|��G�������P%|Z���f��dӣ}�vhxo����b�A�ӫ��r��*��Ѹ���|5��/��tp�b.M�
�!��e�6ZO���]�찱�D}��	���yl�$@�O�B]5��Չ�L�}
�,h�dv���$�� ��;��<��{�wR�Q��a[��(x<>:<�@�Sx�)�8D��� ��__��?�u�ᢿ�~�;�[�o��S���*���Y<�8�ߦ�W7��=]ܨY�����a������=RCI�~+(��EkAA儖�H�`�h��$�?�N��Ӱχ��.�p�N�;Es�Y��}.&-�R�Q�Q�a��鑱?�T<��0_@�	a/��N�i�RF�NՀ4A��0���v��O@�{�D�a������ ,Wы�K�/� *��5&#�D4��49���@05���J�f��S�+G%ES<�0T [(:�-^�q�~&�_I76�{��q�X���tr�~��L&����{���eq%��\/n����<�#�-�/&/�����b������,�oW�����m6���6.�ߑ�s~k��nG����Ι��Ύ;�Kޝl�܍�/��o����]�Z����)���B�"̗�V��`6�lm�C�Z��S�s
m���
���i��Ux6Q� �CcOnP�!+4�/M`�B����0�U;myb4��>���W���ѕ�WS�B��k�p-&�ts$:\]8'9jf���d �Qf�J���'+�|p�3D�K����  >!��"G�Eǈ��(U*�2t\%:B�!�� ��՚�I���4`^�2M������(�%82��+k��:��q ͍޶�t���|9�_�������?Wi�\��\~���|�t}q��t��7w�׏��Y��׻|�<]65]�Yz�=��%/�ۊ7�-�&��N���|l�ޛ���ܮ�7o��������z��up7����%�ޞ��1|*0̠��`9�l�7hЕB|J� <uk���@�$W��3��w�M$�%�2\Ĝ�. �"Xѩl ��g��I+�
%O`��,u����#�7�p���@�jq.Tܭ�T��5�!�U���{�\9�@��*X8B�LO�|��T	�o�(-�0IǜE�+9��IHE��, 8�1h�[���x<#��ȁl �P��8`��������~���e_Y7��r��8�g�O����_?�:�!b>g�&+�Tg��Ww�~6y\���a�W��&O��z��)�Ό��m�W|=|j������S���}N�q� �������y���;�ew�4�'�Oq����9�ė��*92�4�3$`��b��M���ш����!)�D��@�补�A��Z���9�$A0@B��նn����P�A�jCZ���ű��r���l9��;��GI�rN@2ր�"jt�C]6@�>/�6��=#0&B�6���t��."�
w����B���iJ�u$!�,GaD�
�ۄʑA��R�e����o�ѝꨋ@(�P������2�ݷS=|�ч��d�X���|:���<�5��˕ww�v�gڦ���.��tQn�������ų�7�u3Z\N�\�i���vq�&�o	��N2[��5q�7s>l}�ko���������[9�|~��7~��t���٥VC�����=Bh+���$��Rd	Q���"����4����?���!�����P�L���ײ	��LA�E4�I0�MUg)�Gƶ��*G]A
�
�p��    zbD0!�V�1�(����Ŵ I��J!4�	J�HS��0� 0U#n��̱�x��|�p�H���� _��tX�Hv}o���d�&(5�F�����<�(�^�ε�2�;`i�J�1�㏎#�����f���������?LxM��̵����W�j�J/7��������a�_��]-g/���Z�ۖR�ݻµ�pm��y�q ������m��+�.���ǣ������Z���ݣۍ�o7[�9\���nN�?ҁB�#^���Đ����`�`�
�|E����Ʉ�K�M�`"N� 姨�C� (<<%"45tH5'h��K�ا����8^_�!_���?dnh�
Y9���p��%�2C�A߻�#�C��O�jRJ�7��I��E=�R��&} ����2�à�
>.�T.ʀN�L$ÊJ	��)!�x�4�9%�(�j���"�}k�+L:g7:��4{����@���P��+c��?8ąQ��}�}�~���_.�ۗ˿��g}�u��������|�Wk������h���t��q�������C=ݼ?��vg 6�����5��%t���PU&!<Ab!���*41�	"Xn���\p^[���:*��j�hx>4�r �C(rQl 9׬B���r-7�q	����$���
��]�c��|���z�;�,W���9		O��LH��@4��<t�al���7���@������b|o�:�<�&�(�>A|���t�Sm� ߎ�:�E�=X� ���A�Ãl���R�$0#_)5vJ��8`G����˷��mw�Ϗ�;hQ5�z�^=���B���_�ۋ|�����n��x���>����6\�+��Vy����s��,^�6��|nk�����ч����˗êz�����n���2������p�L���	�+�*�Jr�ơ]�����F�	TB�VC@8���p�K�
�
��5,����Q����	:AItV�bm�0%���_	��!|z}o��!�:�A.�'(>ʪ�N��	�� Q]�C5��u���~���� � �!�U�	r���;t$�B�+p�[P��Jt���@!$����*5e2#�}��ft�\Z4��#�g�4��1������^���/��A�߾~�\�\������rBÁ��}z��<�&j��c���dW�\���'0��W�=��rs�ͺ>|ۏ�G��ǃ�az8~�6�gu�%�޻�:I��fOG~��؆���3/����~�lL�5$�tXQ�r�D��c.�B��-!NJ0�@�EdhP���Y�H�攼��d6&ke��!Ǆ�h���Fz�R��F�|��;� �&s��vS�x���n�¬Z���p� �
�t�jZE#{�o��j�&*I��cgq^�`���XBGj[��+	N�z�� 2�$_�l��1l�X��80��� V3:��k�_����c�2��
L�_E|e�+�pi�$���?��i/�7^�+�6o���7�o���ى����m�M6��M�ܹ}zz��7�bNe<>�vw��J�&5�$<�E�&	W�(�J

v�#���NF1�J�Q*` �%;dqJo�d�XfI`����R��K�l�I%Z��Hr��[Sa���:/;�\ؐ��Z蜫p�
1QB�	:t����+
ٺ�F*��lh�.��������!����Vm0�9/�����`&H���*�'|��	�=>�?�)�4�J���#�8Z�����W��N���������t�Gǁ05h��bҖ��S�u�2�&7suwe��b�����BOo���e�ڴ�[;{�y�X��rc�����=��8O���ݛ�ݭٓ�����úx7s=ʫӏ�h�S|^|���P�A�D������N<e4(-��Dd�y�
�� h���z��ma�$���V��	��nS���T8̡�y�@��,G���E��ImGX,�� � 3�
6��1�����K�ǚE�1�wA#
`�q9G��]g\O�֙L�:@T(���P�8J0B[��BB@�B�F:<!�]�!���c>f�" z�N��4�Sp�����&3�}3�$U�	���U?:��/sw�0�����zs�~���qS���'��[q~�y{���3���Xm��6�N?�9x89=}�9�46�j���ӻ��pE������6N
{���Ys�6I%#Jr�v/(��� lqm @�BՏƍIˊy���ޙZ��I
c �L�E(m$K��� ���Z�n6�qT�/��ZY���D��]p���g­s�U+ͱ�VL��QuS�:�#\5�L��3���[՜Kj��hMq\YZ��P8T+ �ŀ]U�]�5	ɇ�"��	y� aA���ù�m���&ܫ�&q�K�����tx���/i�w��������No����Z��[�{C�v*���n������~���|�eO���[�i�a�i\O��rT]�������Y<Xk����P�0�a��b�D���U����va]�0���Lщ0��$5�/j1Ǧjx�]��T n@NA@�e�&)�4�����C�:S�ƕH��� :GQЇ�P� 3�jF�dn zI�i)�C2�g���}��P�)e��\��\s �(@�þ*�{�M�۠6���	�Q*�~J�L$���?3Pm���(2���	��8��F�����o?e,o_&�y6�Z��xqq[WW�����&�7�Wɭ����2ݼ�{�Ы��KXK|�c@V�����{~�7{��]=}(�p�M����K'~����������:>�H�r-�!��p�G�����|F��9�E0��K@��������9d.u1��Y�M�V��Iȁ��V2�jՌ��1|�XBd�*�Ȋ�:H����e�,�|vRCBBO�UkL�O#�g ��.���s��|r��:BkA�	������TR���\P���&�,8X�r��{�bv� �O`M)�L��f�1� ���`h���W!Jw��ؖ�>�?:x��������㵪/��!����Ņ�x��~�W�˔/�6��|�,f��u�|��k����%�V�Ww�+�8�:=8Q7���:<_��x|��ή�N�}x��o6_�[��9d��l�/�J,g�e7i�{G��$~xM���}���1*���`�~dil%!L�303������ȝ܈h����4(Ѷ�Z� h|N_#�� �<���B�E5�̥@1$�L	�	��8�`*��3@��ќ�d8�'�b&���`a\
\*�2
4�p_>"�;��	����j�kW�2t�B؍	�+D��[���d8t����.2T^�������^	1����8�`_#��?���
&^�w;�ikv�������ǫ��c����t;�'��a|8�|
*�/o_���a|qA�ouR�yPH�C��o{e��5,z��
@�����Bx��oà�O�^�Y� �@����΁�
��h��]��z�u1��w_�(�@�K�8�9�nf���Yj�"�t�d����9�:Z&��BXcb^��\�d�U@U!�(|�EȄ=Є@ �L��\t0�qX�%"� �z�	2�9��
�in��2��X8�;��I��#0)W�h�}�;q�
�;�͵ ��PL��c�ԏ���P2L��Y�����J�._~2���w1^w�+��r�W�������������r�1��n;���Z����v}j�W�My:���xR����0�T*�98�L�GrI8E�~Nr�
Ҕ,�*�@k �"4�	h5���!�@1m��F@P��X�3�M"�9�AP�I֬��"���,BT.I"6s,
�	I�T:s���f�]`=���D���L����VO���=�$�f�Z�w�<��a��^�L���U�: �*�W�@�֎�v�L�� O"��\-�kv9��j�ôBJW��X
����5�dYi)�E��a P������$��M01��'v������/��.g����U}�����    �z_����h��ow�Η��ey�O�/^S�ӏg8-���;l��6ėF�BSK���%�X����s�B<c4��Z	�8���U�&��q���9�Ω,@�F����\T]���B�V��R1�����F��F��G@9;]d�>A����T]߹�A7op���?HS���Е��CI!W��nb,(NX�h(4D�aV�@@�:B|N�y� �u��tEA�¨DQ� �M ���#�v�ً��0�Wֽ�ql�����'�����󇇇�B���dy�2��U��ˋ�����:s�����z�Pˇɢ���ڮ��lj��s�+�]ߜm,ί��8;\�N����rw~~�6?�=�aw5{
��z�����ӞY{"$l���냠#'�8�,i�!Xy��T@��!���MqH��-B`��d�X�.�h���5!o|f�K�F�b>�Q�s���#.tB#����)^k�9w.�2 &�UCW-��jM,�3C����S �VS�����
�m ����`}!ѹ��k2�g^'�$��"0i�W#�JmT�����iu���ӥ�[�:������:͋�=YoR�;��Mf|e�3a2�~f���l� �-o���W����k�q�c!�V�>����]r�;��Y�p���_]���|�3;���P��D��MHW!#�橕JA[F�	(ē֝WJ@�H*����0�K�%Ur%�U�B��R9�=��e�Q\U8\�c�@,Z@���@�Hsm�����L�I�a�c�0�E ̕��L��UhrJ`vk��2pB*�wA�G��mx�&��3*Yr����|��i��!�FUt�� 	(�=�ܴn9ޝ�� ����B_�a�����s�0���Z�'�3s,� j��ТzS��cH��,��������r6���Os�����.<��z��ۺwW>��?o<������c^7>��n������z���ɹ�o����ұ,rP��p4�5`�X���`-H��k�Y�Ɓ\B�X��9���Q6h�"�3hC�Ip
,W�� �ǂg��y���:�Qh�ù.@��,@�� ����@��C	\[��}�%~̌���T�q�
��"�	3n=�DѩK!S�	�Ӫ<׌�G�����$��2,oۢ�N�>������PB�� k��(#��%0�G�Z#V�����b�^J��a���q��}�3x(���_��WH��\�O��Ӈ�w��?~<�*w}>'��7�>���|x�}�r}�xI����ݫ���/����x��.���`��'Pq�%3AH�Im��E��(�m��q���S���ѹYz�@ؔ��X!�r�:S��:�w�ϥK*�j�`a�ȥ˺@�CU#�J����A�eh�6�/��@`M�mf
�@t��sm�H�,2W;gR�X�3���3Z���=p�Uv��5*�uN�@�ڀf���ԭ#�k�	8�aR��hÙ�����L�Ҹ% (@e�l}�;gd�W�q.*j�����}&#ݺI��6}��G���Q���2'n\<ϫ��K���v��z���́��^��g�q��ब�],���G��v����jX�T9�*�&�\��@��.C��"�XqԐ���z�㲎'&rA�9�2��J9@�y;���&L�79e�E����3�9J���0��o����RDQI4��d� �͂��}k��F$�K��d���p|	�[a|[-Yz( �`ǘ,�)3e��u�DzJ��$4�֐%�`�%t����%���.���n'0�pN5���d����q}`gb�d����#��{���8��[�F��sC��hM�p�߾��;�^zl���Û���R��k�ħ�����g��rl�S#�����[��ոl�񻛡�ׄC��*<��V����eu�r��Ղ����s�UX����B���1s$ ������@ ����A�D��@������#����Cy.fK��nI	�D�zF �����2]�%����S���r��L�-M�-h-2ٜ���NhK���?�ћy� �;|`�����#`���k�`�4���A�V\���jQ�sh5��Q�~*s�|�'�̯�D��t�?:�š��0�����jB�C+��ͫ�;���y�z�N���Zl�ߏ߼xsw��}�S����"^�����4&�J]�5A�NI<j����}���4��.r��⺢�
�6@�U�z�,�
B��y��}v�yb���+���E�=.U#�1)b��O	�k��V�(��#���ҹ�C�;M�2"2_�p���W��� ������Z^���|U@3���� ̈́����t���0�Cj����C������i��Y�x8�Q�!62�=���5^�e��0��q�Zs��_0�^�6�A��E�Fo&SȲ�L�p����s+=����r�W�nvi�1O�y�n�纺ۻ|�����}�O��?��Ͽ�Ǘ��{��_<�|^I�/�\���<�}�}������xk~���SxW��O�b�����I�ZlE�
S$��E�V �=�Ϙ'�"L>��W0F���r�JQ�Jp�P!��"����t�-��m4X(zG��&��!��d b��k���T�8y� �W�2 {���.e��Qqgt�hr.#�|��A��P�	��8��$J�i�u���1z&��S:\��aN�k�%>1>h�@�����Fŉz��aq6��I�{�Q�G�P�I-���|~W�?�e��4���o��_ur�;�]���m��ǲ}^>���9䙿�r�ǅ��_��V����~�4_M�r~��4wˇ���'��h:��i���P��������U�>=->��//߼ې��z2Ϋ�������wk�i_� ����i�>�ϕ�RZ�Tt:�6�y&<}�F���ȑ�鸽{�,����S�.�����6ꡄ�P��YO� �)������l\�i�H]*�PiZq ɕ�E�����;Q�#�L\)K`��pN��)��g=��*������2G�*��I��9�X�z^h��qߜB��r� P 0���4�\��!�R��2��V�`��N�T}���.�����Ձ�2A��8��F���~����O�N�Ӆr�3�|�����p���\^��������>_�����wp���|�9Y�7�W���n���p�&���O[�k�>L�f�k���?�϶��rX��|�
rj�Ě0�F��ָ��T-�`��ΙmH�$�v)E���lW�����"�zd�b�WE��%2�l�e�A�r�P����@P����ZL,a��
�	AQ"�� ��Ζ84�]� �Ie��̜���J��8O�2�"�S�:"���DdF�=<h��VM p��,�v�xA4��K�`<��u��*���*��:�j�4K/,� �^	X��*�W�W6py���G�.=ڙ_χo���ϭ��G�կ�^��H�l�����<�ܼ?���o��{>���_=���U�5>�ܛ|����}��f���Dm�F��n�JǪ;�Yp���Y�,i%q�
҆u5�H�=�I�!���2�Y�����E=�9�`�I[�I�
E,��Y+���/������W�2r�o"!�TP`��������"6�nU�+����������<�'Y ���X�8�I��,l��hC�Ʃ 6�[X|�>J�c1�W`��3�������!^%ױ���y��5:�uQ�}e�+��N�����}k���M������Jq��7�l�&�2}��;�{q��{���rv�O�wS1~�|��.���s��{R�C?@���n�	4c2T�U�'D%��M�Ȭ�2���X�*SF�䝵y��1��!,e*0a�,x�ɪ�`��!U��r�`��5鬍�C;�:^��؂V�����-����<�B��Sy@���,&^6��u��M\���@���J��s�$��Pg���Q@T&�����s��,��jХ�#l�r}�-�p! ��\V��3�    ͼe��Q]-DkxL���ʪWҌ�	?:��ɗ����n�_�󣟽<�X�|3�W}��]�,{�W�O���-�]�/7�Be�e4���X��������wk�]ln�s{3vk;����?�ݛ�݋���݆���A �g�\4�0^' �B� `њIַ����h�,�4�U!@�+�f��a5'$Z�&r�',]wZ;�SF�a}��Z�rA1�(��1��# ��T����O,�����v|w�:J.Â��m80M���)�v�9��Hs�S4\�
�dkp^�Hz�IQ�x��-���`���d���^�>�$��oੇ���( �� 7�F0߈�4��f.�J�i]W�8�B�!2",j.G7�,����/,�<�f�����>"�{}�?�#��w���q_��X�8ߖ�O[{w�t��?��y��]m��̗�g~T�<V�A7A᱆��I�&.�����*V4��H&,�q���p�˨�c	�!��7x�5"���̿EOG�Cd̖����xّɠφ�� O\��ߕ�"9'$�P(Ŗ�X��\Z��f2p�Vq�!Vɕ�C�R	��pg,娘-�;r��\�s1Xg����CV�P����.�'��kF��l���Suq�Mq	_d-��-$�2G];W�6fA�d����Q$���'����к�k����9�9�������������j�q����Tn�?<�䗟͉�O�_����}�<�j�w�7C�$���ˌ�0�,j����
��r����H@'FLtt�W�j˝�D�.2mp��t�L��g�5 <ǡ��q���8b�D�\�R$��ѢN�p��(u����e��0���A����&/�#~�Y�. �@��Lq̘c�F�2�;����,fc�.k�C@<�x
�s�W�w�at�Fi�R՜l�f��À�5�U���@	$��1�J|,ϔHi܏��V˶}�K��1�5�[|mʛ�t�u%|���ӹ�>�[������tvo'7�pgg�8�>{��}�J�#vQ��	Xɋ	��j��-�L��|�{(9K5��,ȟ�3@Mg��}4���k�Y6��P5�oꬊQ�H�m��)� �t\މ�-��a����)�0'eH��޷ 8 �A���v��\���Y��n�c���y9�MWZr9*�xq�BՁ����m�3��^8�1N�o��X�H����O%�j�42(�*�@MKa��Jf#�]�̊�89g**����M?:|�Q�ï��������g����f~2�rqp��O�gj|\&���m�����^���e���uaZ?nC�����"�Y!�٭]_�E���",jl@kPs��@@4d?>���@K�LF0���;B��`ub�
��"��P&<7���e�5����� ��F �$.Z֞U�jlm3@�R���p���V���B�Y�i"���3�P���L�Q���J&�QT�l��<n��O�~DQ��������a�1|2�~J���ٹ=��n%�qWd)*����JȿD�����X�7��z��M=�޹�������I��y���?���x3��}q�����|.���A�-$T��`Yhڢ������՗��%!b9��ɹHmHspL�Pe�	X�Vʐ�M�>2�R�i �����h��b�ȳ;� in-�p����{�����d���L�8���@������c(�`<����$$��'�&�����DQP��0׬[U�Sg@�	����m�{ �l �����*��Gu�^ �ä4�h�D�rb��U���B��!I+±���8���*���~z��?I��:�����k;���Şx�����l�˛���7G�㕾	�� ������ן�����j��ٰ �n�6p�
7$�8��@QY�b���& 3�,X���x��3׬�y�G3�k.�a�6K��ʱqD� ��\oZ�^,��.�.M �b���6�ļ	��a�0�(o�' �Z'��@3M���uv1�3	Ѐ~d9ԢA�����u��X�jC)�8�s�.VV��� �(E�rE����0 ܾ��3���<������:*Ll�;�\��p�9.��������^O�����:����}��:�����
�������.���;�'���o�Ƴ�w�ܾ��^�~z2�q�i^�v�����Pױ�Ϙ�� �9m�՚\Ρ*k�p��#�D���k�kƅ1C�m`���д�>�xD�Jl4n��a�A_��i�)%��'� � A�!L��X�S�%�ƚD��[��a��p�Z>��	l� �`7]E���^����ZW^���` ���5҈j�Ł�~C�ܼD��r�O[�$!��YA�%��A�����J,~�����n���✕\�X+�S�ͰLW7�{i,'�D�?:��?r1~�T��Q��������}-fG�o�w���o͵?������+om��o�<ŝ�EJS���89��p5R9吽D�Mp�>
$]�r'6D�%n��ђ���X�+�Π�؊����3�\-&��JK��O���*hr<~&� ,%$�/0���q�~U��Ԇ����i,�g��!� 6�R��)��]�4�����vK�
j�"��'!��[X ��XH2�����j���
�U(9�[9beKN�rP���d�+�șŖ���9�|��B3! 3
}�i�J~��WFp�����cq
��n���zԯ��uo�K��GX�_��7|�#uQo�]l\�=��n��v�N>o���	����->���Ǉ�w���i�n]OŻ5������`��8�)��hf L�a4�y0�-�C����&�Ɇ��eX�8�ɂ� pH��ѱ����T��|��.��Dju��m�J\�n�fK]�l��J����F�S7(��-���C��i��v��!�=k:�Ω��c�;8R��fEn�����MAy1׈� �9��;�8˅$�3����� 8��KS,�>FdrEl�nD� �aw�* �����-h!}�(�J����/��/,�^�?9���p�����ȿ��gr�������lN�w��>[��7�oo6���ޮ�Q�b�e��~_>��h��`ÄcV �gF�BC�>R�̱���@p�5������wq��a҆�DS0,�0�Ű�J����'$�&����G���k T�]�Q�Rqy�,d��� B�
Z����@�U��q|Ͳ�A/5DaW�������sD�5:B��b%�$K�Z�(XI�"� je�.�غ�<���R�쪷��v۰཰j8Ύ����x/�}���r�a��:�=�"~C{����]������?L��u��;��?	��n�`��o\H���ܽxx}����������i|y���zrd���7㍷~g8��vJB+����u���>+�$k�@,	͝�
�	��Bu�%�͔���)C(4���`�k0��:HNxD?�Ӄb������h��Z�Vrp��p^��g:)bH;�<p�v
ް�g҅�YR9�ڒ;}-,�v`�Ƒd�g1�H�|����q�
��`;$�ro�ɶ��Ah}���71L>8N�G�Hn�r�!	V��q��ka��3�Z�T�g��5�������� ��L�/���/���W����c��l��ͅW������yx�_����ӎ�����λ�70g���t�C���_R\!ح�/	��4��?��R!��JW'$�X�\��f=j���'�E�TA��v��B�x*�e1�ԺD�B��9��ۨ2��sJ�늆� �êd��\����Z�r��3E斬�L�׸���e'���-7[m�`��A�p�e�B�a�����+���>%�.�B�+���6jöa�vLH%�ψ��kW8-T�QQ���q�����������A��H�����8�G�bl"#���h�}Sr�������ӹ����:9�t�2��	��l}��Y<������������$ƙ]Xu�$�#@Y��Z��K���    <I��4�c�P(pe|���e$&Se!Pō���Y���jX|����f]
e���Z*�6ɣ ��
Ƃ���׊�;�l��DiVP0-�d%+)�8:I�J�J*���h{�VȈ�:;mrc*h��X��3�v���e��V���b[�.�
t�K�:Β���Ai����x̀��<j�0erk�L�-�$֞����|��JǱ7ߋ�?�bf���G���8���n���|�t��1�:��(�Ųn�=,�������im�p��޺�>�����x3���u�	��t��E`1h9<��-錀����"	ր�jC�L��Ň�Y�H��K�'PO����xP��F��;�H5j��q�w�,��u�������P��tb�f�=�!�s��&��:��05����YX���8ԧ3�z��Xrg'���ɲ��I��9芸��a�q�m�P[ˈ��1��<�J��%�J�W��ϝ�xD��<���
 �Jn�B���_��^���t�\.a+�+���rT�N����x�o�������j�y�����Yx<ٻ��޿�O�o_���vu�:�����6�V��>�����w\�lHmȽ��;�{4���#�O�ʈM���1m� �9�}́VL�b�_���h���sZ�QqÊ^�xb����킉W qg&Dg�i8e9쾅���
��A�����>9=r�ސ��x<^�}��:	�_HL��En�ō�=䘆����O41���I
�0�#�X�^�z�:�(�K��K0��h�f��甒�.
�i����G�0�T77/7�@ؿ/\t�X�YHo!��>���5��x������t����l�>����j��3�_���zw�z�&'�!6B��яY?��j�	.7e�C�D.P6�l����bI11;ġ�u�}Aj<�T�x�븝��L�A�T�L���I�7A@��M#�A|+�ao�^�!9�CaM�D�W"4'�DN��ј������)r���(�T��'�Nt����
�e..�<���\�����=	��ϽWT����>`�]&��7����A,����n��8��ig���/\��U�Iþ�J������/b��w$~��o�_����Ӗ���'�㭳�7v����xӮs������8�;�ͻ�>+�[�f�-�.��?cCԖ=�f��[%Uiܥ���:�6��2��a=@'���܀2g�h����1[	7n������������ɞ�s�`42'#�r�v���-^pOa���J�2c�d�,�rl��	��t� J��I�A�]0u���-���5p��#���dѭ2��^�kF��6'ͲȾ�س��n�����+G ���ˣ�wp"���J���Y���_�	���n2������j�^�/�v��o��/�W_�`��N�,��7u�������m������L����io9}>=#�ŧ{ny9lO�Sv�5QX�'��(q7��j@C��4�@ˊ`��@��q�VHP�@)�S�0��s6�@%��m��Hgt������G�ѸV�=+��<���D��JCqWd������َ�6�Z���2�D$9Y�~�!If%Y������knP�,S�ᦶК��T��b,��9r!Kig���F=T�P0�F����{{P�\�F�ǉN�U�M4��*+%3���;�)��ȱ������C�o�_7��kVei���ϥ�?��]}�-�����F_ػr溜jW��|�4������Ճj��^/���h����*��!�8�w�T�]{���ts�m�=�tsdώ���|s�.Z���OngC,�oo��Zk�,/�$�&|�ց+/(��� �4�
�;�x��ш�H�Ț9/n��ס	��f�2C "bAtR�Q���e��d�# 5�=!%�YqT�2��.-�&�p�T�*�
,�B|��I�{ÍF�3�|�>{��9fX�H,�2�B��7�f�I�M̮0�d�8ܘ��N�0=�����U��wX8CүX�*�}�� �J�r�ʍ,8�nV|)m�3�ꏎ���(nk�;g����׿Ol���o���W���\����MO������u����qx}/��V�w's!�������^����v�8{�%J3����ƽ `!��>I	F����],t]9&�4	Z����Pr21�
�ì2F/�#>Y�DXݒ� Y�ݎ�Q�@Y,娬���`=t閬O��.���r���2�6��q!�j�� n���T�����[��1
��'Of������E����>���%��`�%ɝ����gj�#+��5�0�6A��*�l���=�:�Rv,������@���rl��?���?^,���w�;j~�����,^N�����ɋ9����O��AY�����;�ù��w��Z���0�x�D�\?���t�f� � uJ��'p�������T�W���9�=!�^�����<��bkx\E	Vr79`J��׈[!!�q��Y⎛�+*Bp5\wa�	aY���t������n�j�X��Սqn;暑�%���fYժ!`u�I�u*@!S{��g؊��})����G�g��9tc��ی8z#H�]5�W���kOf�B�]��f��Q��8��ny�����|r�;�,/~_-/�����Z�^"�_��r�w�m}^_��>�=��ş^|Z܍�'�̉�룝��[ܕ-W�%���+���g�z��!$����Y�o���qO(�*���l����HнW���8�oԫ��L^4Gz�V^��U鴓��>�u1<2ST޹: ��iE�UD6�5�چg��S&Ѫ�,�6�]�{�m���Z+��v蠍�
=��� D�,i6�S�8hU�����	A���hGw�O��,�El$� ��7�V�t�j�x'j��:"�6\�s�Vl�3D|�Rl�s,"ت���4�sn��F����sH*"p+� 2���S�%>X�HV���R$|X�@%V�3Z�01�M�{���l�|���[�߅E��u^�3@���n�'�e��G���IcT����I��볣���O7�'y�4u����/����ۻǣ4�Z�� �xԃ@���j#;kT���CCI3e��jp���$��堻�W#Z�NF��Ȭp�8 {d@D��[��]\ERd`&�
^ ߚ\N�R*Y�]���,�|z� ��ki]g[Eo�@�b,j9e7�4q��c<@9*�oR���l,���ٮB�e+���7`�4��k��/P`%i�D�Pـ�&�����<{�q5cl�H����-9�ء@��\g\�Ϙ�<=�k��:bQU��o.�\^<V��?�?���������Ǐ����]Io{�材g�w���i��ٜ���/G������z��}q����Ë��UZ�8N��P���3�@u�+�uG�`Z)�h%�{(/BPw�}��@NJ��+���Od��R7[�m�5Ȯl���M�ʳ�)�M�aDC�X���ޚku<5���#�p�5�^�̑H�� �m�@�ņn��k�D����Q�3�)���.
J�h~A���y| ��pD��m�J���ȑr��,�S���j�t��ۊ˞Htt��ܾ�QM7����Ϥ�5��(���4M���~]����>��}�WB��g�7 ��Ǉ����������_'{��~:z��!m����O����#B�s�j]B�`O�#܍Q<�d�����R�>o�j� Tkc(I׵Y�tsjK,��5<#���z�r!K�¦�?BK�<P�p���
!eL#����~;�Q�΀����6�����y�
ܹP��� ���/4���7��w׍Ai�kɱ�1�ҵ�Ћ���ɵ@ �.d+�A�Nj���p�!��Ӎ�R��VY�.T��Ϡ!��	�)+M݂�'�D���GcI�����3��!��z�����_�gZ%_߻�����f�|��"��x��_�w��J]����K��v����J�f �]��)���    :=t�h��(�z�:E�͂�G�;D�}K��nE
$?�� �@ِ��!�	����9����ųK"g;��@� }�Y`�<�yY(����@@�j�(��q��-�CJt�E~~]Y�6�@X<�(�;���饭�1��[��RAD�t ]�K�R��P]�^�c��8� I}�@i:�"��<W��z&r�EW���kɉQ�C��%�ghd�����Q���uD��>8�ӗ�9�V+��m]��ٿ��݉��p��֋���������M~���mW�b}q�L/_]��ٽ98]d8N�']JRK=v3B\��^���ښ�:�Cr^�PQ�|���o-�,;�<�}C�2e�Rhe�8���Ws:���l@��iv�肈����i@.��V��`ʲ�k��wn�sp^Z�X�̱I���7��g.��ɸ�[u����*��$�� M0�����n7��U�N�V5H�)�+��[:y�TP�"�%խ4)>��L�ʂXQ�O�a��`D(��TOr��c#mu�檫�t5ț�ˣ�x�[�����P��ί�l���p�[=�o˫Cq�C9LO�ǫO�Wf7}V����7��-���uga!)+��y�OT~/-�uy޲l���4AS/Ga:��Z����"����@8�nN�Cw�nӀ99��&Iͽ��J!A�
�j��Y��Rp6��dZJɢP�4��j� �5n8���I�e�)�AHb:��|8P��p!?f.?���t�HK�ĉ)�pP׀�Ǟ-�H
��V�*��C�`�m��\��;�h�Yd���	~p2���e����& ^֖�AA��������:���ˏ�z������������?�n�QO��F���ZEO����PNAG���PaS�9�_��?���f=ykƋյVo㣙<���нsg{���=ٜ�>\����gs���;ښ4�x(���h=��u�Znx+-���z�K��*��;�2���uʹP����Q��y�at�2(6�w�m�hui+Wn�#�թE,��������(��&9Í��HDx���*R#���/���4	�N�rK-n�-�
�L�SD$*�!�>��kc��=f����@u/�ȗ�8�
	$A&�X�آң2��ǖf�3ΉЕ!��M��v\`�����(�շ>H�_��#	e	��U��~a��+p��\��B�棭ڧ�l8��᪷ߩ��6_-�����n\�[��i?�+w<l��w�A_��g���p��|^��Q����]~������ԑ�&ڄв�TP%�,Xn�8R;�*$:�<�U�su�V�> ZǮ���h 4�N� �d�e�2c�E`$�6xriن@�t��^T2$Or�QE:�5�Sl1��e@Z�>z��RF�C�H�4PD`ը�(�T��a�� �D��8c�K�����U@�K9YS0K�{�1Ҕ�d��s7�DJ�*�k4�h}�DQ�iV."e�ƃi���>c��.�Xk;�&$:�L���H{`���$9^�� 
����oe1/Fi�2�^�a�������n��/6[T��f�=��f�Y��B�*OF�'�7a��3���������r6Iw��d�x���ǋ���ى2�����rT�z0��_�z������Wc��-j��i�<<�C�2 ��S� u���N�P�v�M���ŠN! 
Xe�L
�_%�(����s�k�8�-=���S�2�{�{�|�Q����+*����Dh�Nrt/'H���i�uD��7�,�%�ƌ�P��I�b�&.�҃�Ú)\F@صA�X���*�h"4@~`ZS%`=<�`��Q���^8��f$[�G�E�ޖ�m?��1Ά��?���:"LT�}�,�zyUux�[a�`;�o6r;]�0.J���|��ϓ᰷���p����e��b�{���g*`��}>{�T��{�^oޕ�|�����l��d���9��0���/j/��u���)"����	y<�26�=#����t1T�mbr\�,ThRg�����?�LZY�u,����p�|�"��C\
������B�K�!%�5A�8�S�<uR�[Ȥl<>d���֠�7��A��2�Bp*w�fuL�gk��#R0�~2ڨ"x�˪�h�!rGB�K8��n�־�I|������^MtҶ��c7ѝ}�2zi GP�e	q�ԥ�u<5E�eQ� ws L���2�]���Wa��)�������h���0
�,�����15U&l��i�g��_�0����|�_	rֽ����՗�w)������D�=�>�=�����;��WW���iz�?�v��GG�$
ǵ�Z&�Rj@�H�Q��~➢0l��tJ�T2�F���B��t~p�>��D��'�	OyƢ�<�A#XA�P�A��>� (C@B?.��Jl	�-D��`7���o���'u���
�P�V$ۢ"���2��ͨP�x`P��t-���6~KהRţ
2���#+��D�(�@��A�\s��	e��9�2N��d՚nM����
A%-}���}��:�M}��m����z��F.�z�x��Z�vև��7��!�s���?�������!����g��t>������ڿ����{Q|�=�����'O��H;OܟFp�h��ۮe:ē��R:�)��)�Rj �" p`q��'ͺU��Tm�n���S�K

<r텛|55kXp�����5e�"u�eH���a�[r���4��^{*Gķi֔�e+�.5�N{�VOkp빼O��(��@�P����2��bH����iL��f6PU���QEQ
Л�P��H��+~/�|k����:���;�5����/��o�ǿ��w~�z8�1�n�<����rx�����j�>�6�Կ����f��:4���a{�<=���M�����"�hjc�A�h��0D��S�Gsi*�x������f�bT[Tc�9��=�tlC� ��k�n$wP%ݓM�a��I�`w��
ae@QJ*�9>�!,�7Xz�{�9�-��.Z��Ȗ^:ψ��p�RSk^�E�i᠞0%vbz�T�����Hp<%ewQ� �)��մ�	|i��1��g����i[�h]J�膞ߪ�����HԚ���ёZ��I��F��C�a~��?���!�_��'��اٲ��g^��f�|��^͟�n��a����e��L��_���	��h���^(4�j�w�	�=ޝ�	U�^mz�7C�:|����|��Pn?��ޗ�����u~|t`&�=���m�8"8J�l��b�J���B2 �
�i � ӸO�K����,�p��	�5��u��
��Rٌ�Ѩ-%< �"�F] �A�Ar��)o����3���X�_� �"r��pۘ0��m�:�@�xT�b����P�=��|�,"Pc�p!����tT _Q4W�btH �H�\"k�ci���mK��M�,d�H]@."*ЀVG�������b�P�?2��Ö�_M�!5��O@�_]G���� ��~��(�}�r5Ņ8۬���/���m�v��oG�<X��2=��6�e�4)��v�<�sd��~6���~�������ɛ����n�a{��;8�~
o������-ި��I����7ǹ߻�M�cc9�<��N���;�$.�GA���%�v�N���;�򶛴�-�%�$ʖw4|���-ʴ������ԋ�d���js��d�Њř��&*d ژ4I 7�Y�G�и��s#ErE�o�q�+�6�4��A��5��;T:dG��
�c<��;���i�:����@�m����\��=�T�����-B�ˡg	� č2'ߐٹ���V�䉿�K�Ւ�c�{����;�U���QO�x<��O��p�-�F��փU0�0�%L��}zZ�|	b�wϳ�p��v�^�=�t���s��_?�A���u�'9(ߏ��F�����ps.W����w��M�x|{���a1��CW���fi~|{x�<�w�����z nl."�Bit�E��[S \�D�LW{pL*��J �  ʕ�L���b��1 �&�M�,�K���ud����m����Ue�B��� ��3��f��s��,\"�E��%P�®Lv��R#<KK���@:;�R�����:;��sK�I�Ls�
i�j�(�-�@�����{!@��ѕC��\=�9j���qA8�P��K���`�g�c��L?p��/L�H���� I�W�_YWi3�M��~+��,��T��:��i�㉟��r.����f���ß	��n)�J+��`�؟�ݸ�,�Cq�NM����=~�x0^�����o�jc�d{�������>��B���5nuM�dA�Zn�l�|z5��P@ ���vcY�Qr�m�ၼ4�5���rT?��Z:J��Қ�/T`����J�����y��0ܛA��5�Y��j�.��=�C�\0o1"-cI�����@yY��NS�+sy�2���9B��8 ���D9+���!�yɘ(%�V����s�2>��
M���@0*����u�PH��q��m��W��zN%���п��Pk����, ��<�s��z��:���S��e�Og�כE3^���-z��k ��Q^O�j?A����o�z9˳��;��|�W���z�>�J~�'��,��O>~�4���9��>l�Gy8��)��(�ٜ���H�;�ĕ��Tj�9�)�029`�\:a#�����ȳˈ������9�jf i�Ej�0�D`��+D]�W(u��H1�i��+��T��\S(�OEr~$J�C���B�[{��r;�Q�2�Ys�8h�D�?���:4��m����S_%��.
(��{�hT���J�̳+V�Zs\�"�5޷��D��
>��'���R&KP垓����fٚ����Q�O�_�ӛb����Q����i���f��O�g��};�LN�{*�?���r�S�^4���e��ԴG���t�&�����5�ё�M��d�O�ihjY)�� ��T��W�4�@!% �ڦ��*��2��%"U���(Q�y�e��Pe&>��5��.17��(��FPx���)p�bAMjU���HN�0�Ѳ6Z���� ����\7��z�0�xP�m��Р�E�v���,�Uu~��ٓ�NQI� ��}�N�,�㝭�gYZ��)�BM*!*��NO�\�TL�*Kfa�~q�������vw��i���^[d5Rj�<N�y���m��<��I�;F4N�J{-�h?(��2l*��<��a��%�������/n=��^g ��f�v�����!_�F(��_�h4����O������^�;�T�x�����p��X��f���_��F�NC�~:;$�͊b@Ζ�/�:�j�4�NI�#P���yz%e����BRD{"p�T��G�5-��l�C��Q���4UM%�qA$A\r&-Au-��	�Z�ϊ@�� "O່[6�a$Q���t|�@D�S��r
���� �5��h��GM��jNV�����t!*j�!J΄����t�I'���#��Z,���eD��N�~�_^�Ѫ?|��o�[��qy�l�=%����.�vø���ZO��.-f��r6����l�U�o�S{d���]����n &�.޼Y��?�����I]�c9�����|���
��\_���P�(s���X#'Ե���<�	�J��%6�d�h7�XP�nO��p��R�
Y��=%����G�ă.���Tr%�U;t��^7^ x�:�"�S���ƣ����"'6s�"8�h/��!�D�(.���3Uf�����k�ѿPK:�. ��z�UNit�&Qȉ'�g��xn��g�����<��\�
l��*� �*bl�%&�):���_�^r�[����u���>��j���������T̟�VO�`	@�+Sb�B]�<�|o��]��vk������������b����^N�û�{�p��+��xx�}|r����՛���!����x�Y��刍'�k��J�t��\k�^�1�)�N=��\[��T �Q7���'rV�hŉ���-�|M�x�)�%;��,J)�bO��d�� �5Ss�?sxHY�'� ����*�DԴB9gA!��3�S��25�������3E�"�({ti�]��]���������L���qg�+���g����l�-�n$�x�[�`B(J���O�\T��%!b�М���G}`�/.���N7���o&����-'P ��f����p;���y3��4�ӕ���tmG��:���7,GC����ؗ٦���˖��o��#���O��L淛��G{!n�_�����\_mO�M�Ǉ�K��Mg
Į8]rgU|g�RgD}"�2fI�A�o�>e�@)N#L��@'ؖZ�d���DZ�����H�'׭G�tuKϟ��Bp��׉sj�� uɖ�}��܈q����%��DO�vI/!*�Sp��k�6G��	�����zZ	�
_�t���A^�}���27����%��3�/u
I���U�0�ƣ5R��g2&�����6(�pq^�
�FR�A�W�_�ռlh����m~u��T������߉��|�4���Z�z��Fsȹ\�A;�r���G���/QG�;��3�߳Rq�ǯ���z6�gčԹpo?�h�����q��^���}���r\v���V/w�Շ����ͲYǮ�tHV�!H�����(��)��&\e� �*��p�=���1��ז[���Z�wK���s��T�(�4s���.(Э��KҮ�T��~�{�k�X	$���,.��@�T��`P���B���Q)@J�b$ÐY�-�6�E6�A��ͱ��rO!��"4���v���7�ws��A/�aä��o����M�.����|��P`�8�r�5-a�dQn���u�v�_�e;���6xFug���d����4���EX���"��8<��<�۰-���j�ǃ�p;\�a��QJU�E�����We�Ck���ݟ���淯����]�o����ۣ��O�o���|9����9>����RwAg	����x�����{�6�3�((�u�]'s�,a����J�Dd-�X��q�"�OSs9<���Pi9D�(�J �Q>a�b	�H��C���L�DvH��²h��I�B4HT2�6;�����c~�S��F��y�J]�����A�9�Dͥh�a ~DZjI�n �PYu{�;dʡ��:|1r&R�Ϋ|�u��\h�f؀5x�xHR�P���Hu��Xc�~�檡_ͦ�n�U�����j;�+=]M��]���|4��Oa�z��Q0O;��-�Gc?��j�/*�֯ǃm�!Ȧ������ٛ��L�c��g˓�öY�6͸��p '��j��4M��~�u���SOǹNTY�>uK%�˖ �Ƴ��жl�g��k)�Н@45�����弆G]���́����.mT`v��J"�E*^�źJ�AIr���%�CK�m�p�.������}W�A�����t��t�f6�Ju�oUݤP'�t��KM� A��g�Xe����E��}�V�:���(��,�je����U�J�~# \������'`���Dh@ܣD��?�8��i���#�����|�Y�_�W>��i<�Q���	�o�c���כ(֛��ʛ�����l�����H�(ZӘQ<��d|�8ڟ̖���o���]/����ٕ�?��~�~Y��U�GҬ�WO�xk��+:~@�Ŋ���8!���JB�CV�15�\��_�`��6Wܚ�T�jXl3�@�,lx!��uob��D�mAx��I?�Fj�,��ο�;�4[��Ec���#V���<ڭS�Wѯ��0re@#TrZ��{|���HGFӾ[��B'x�,�4͸�%ge3% 2��i�W@=ʞ�'0	���l�$�� �œCװ��(��c�x���U�LO���dy�.`(��
7]�5�����u��ŋ��Z�     