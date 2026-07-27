BEGIN;


CREATE TABLE IF NOT EXISTS production.hist_user_login
(
    id_history uuid NOT NULL,
    user_session character varying(10) COLLATE pg_catalog."default",
    client_ip inet,
    date_added date NOT NULL DEFAULT CURRENT_DATE,
    CONSTRAINT hist_user_login_pkey PRIMARY KEY (id_history)
);

CREATE TABLE IF NOT EXISTS production.mst_book_category
(
    id_category character varying(10) COLLATE pg_catalog."default" NOT NULL DEFAULT ('GC'::text || (nextval('production.seq_category_book'::regclass))::text),
    name_category character varying(100) COLLATE pg_catalog."default" NOT NULL,
    date_added date NOT NULL DEFAULT CURRENT_DATE,
    flag_active character varying COLLATE pg_catalog."default" NOT NULL DEFAULT 'Y'::character varying,
    desc_category text COLLATE pg_catalog."default",
    CONSTRAINT mst_book_category_pkey PRIMARY KEY (id_category)
);

CREATE TABLE IF NOT EXISTS production.mst_book_detail
(
    id_book character varying(10) COLLATE pg_catalog."default" NOT NULL DEFAULT ('BK'::text || (nextval('production.seq_book_id'::regclass))::text),
    id_category character varying(10) COLLATE pg_catalog."default" NOT NULL,
    book_title character varying(100) COLLATE pg_catalog."default" NOT NULL,
    synopsis text COLLATE pg_catalog."default",
    author character varying(100) COLLATE pg_catalog."default",
    publisher character varying(100) COLLATE pg_catalog."default",
    publication_year character varying(4) COLLATE pg_catalog."default",
    stock integer NOT NULL DEFAULT 0,
    CONSTRAINT mst_book_detail_pkey PRIMARY KEY (id_book)
);

CREATE TABLE IF NOT EXISTS production.mst_user
(
    npm integer NOT NULL,
    name character varying(50) COLLATE pg_catalog."default" NOT NULL,
    email character varying(50) COLLATE pg_catalog."default",
    phone character varying(13) COLLATE pg_catalog."default",
    date_added date NOT NULL DEFAULT CURRENT_DATE,
    date_update date,
    flag_active character varying(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'Y'::character varying,
    CONSTRAINT mst_user_pkey PRIMARY KEY (npm)
);

CREATE TABLE IF NOT EXISTS production.mst_user_login
(
    id_user character varying(5) COLLATE pg_catalog."default" NOT NULL,
    npm integer NOT NULL,
    username character varying(10) COLLATE pg_catalog."default",
    password text COLLATE pg_catalog."default" NOT NULL,
    is_admin boolean NOT NULL DEFAULT false,
    flag_active character varying(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'Y'::character varying,
    date_added date NOT NULL DEFAULT CURRENT_DATE,
    date_update date,
    CONSTRAINT mst_user_login_pkey PRIMARY KEY (id_user)
);

CREATE TABLE IF NOT EXISTS production.trn_borrower_detail
(
    id_borrower uuid NOT NULL DEFAULT gen_random_uuid(),
    id_category character varying(10) COLLATE pg_catalog."default" NOT NULL,
    id_book character varying(10) COLLATE pg_catalog."default" NOT NULL,
    npm integer NOT NULL,
    date_borrower date NOT NULL DEFAULT CURRENT_DATE,
    date_due_return date NOT NULL,
    duration integer NOT NULL DEFAULT 0,
    numbers_of integer NOT NULL DEFAULT 0,
    date_return date,
    flag_return character varying(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'N'::character varying,
    flag_overdue character varying(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'N'::character varying,
    CONSTRAINT trn_borrower_detail_pkey PRIMARY KEY (id_borrower)
);

CREATE TABLE IF NOT EXISTS production.trn_penalty
(
    id_penalty uuid NOT NULL DEFAULT gen_random_uuid(),
    id_borrower uuid NOT NULL,
    id_category character varying(10) COLLATE pg_catalog."default" NOT NULL,
    id_book character varying(10) COLLATE pg_catalog."default" NOT NULL,
    npm integer NOT NULL,
    overdue integer NOT NULL DEFAULT 0,
    penalty_overdue character varying(6) COLLATE pg_catalog."default",
    flag_loss character varying COLLATE pg_catalog."default" NOT NULL DEFAULT 'N'::character varying,
    penalty_loss character varying(6) COLLATE pg_catalog."default",
    CONSTRAINT trn_penalty_pkey PRIMARY KEY (id_penalty, id_borrower),
    CONSTRAINT unique_id_borrower UNIQUE (id_borrower)
);

ALTER TABLE IF EXISTS production.mst_book_detail
    ADD CONSTRAINT fk_id_category_mst_book_category FOREIGN KEY (id_category)
    REFERENCES production.mst_book_category (id_category) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS production.mst_user_login
    ADD CONSTRAINT fk_npm_mst_user FOREIGN KEY (npm)
    REFERENCES production.mst_user (npm) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS production.trn_borrower_detail
    ADD CONSTRAINT fk_idbook_mst_book_detail FOREIGN KEY (id_book)
    REFERENCES production.mst_book_detail (id_book) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS production.trn_borrower_detail
    ADD CONSTRAINT fk_idcategory_mst_book_category FOREIGN KEY (id_category)
    REFERENCES production.mst_book_category (id_category) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS production.trn_borrower_detail
    ADD CONSTRAINT fk_npm_mst_user FOREIGN KEY (npm)
    REFERENCES production.mst_user (npm) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS production.trn_penalty
    ADD CONSTRAINT fk_idbook_mst_book_detail FOREIGN KEY (id_book)
    REFERENCES production.mst_book_detail (id_book) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS production.trn_penalty
    ADD CONSTRAINT fk_idborrower_trn_borrower_detail FOREIGN KEY (id_borrower)
    REFERENCES production.trn_borrower_detail (id_borrower) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE;
CREATE INDEX IF NOT EXISTS unique_id_borrower
    ON production.trn_penalty(id_borrower);


ALTER TABLE IF EXISTS production.trn_penalty
    ADD CONSTRAINT fk_idcategory_mst_book_category FOREIGN KEY (id_category)
    REFERENCES production.mst_book_category (id_category) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS production.trn_penalty
    ADD CONSTRAINT fk_npm_mst_user FOREIGN KEY (npm)
    REFERENCES production.mst_user (npm) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE;

END;