--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: author; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE author (
    author_id integer NOT NULL,
    name text NOT NULL
);


--
-- Name: author_author_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE author_author_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: author_author_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE author_author_id_seq OWNED BY author.author_id;


--
-- Name: book; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE book (
    book_id integer NOT NULL,
    isbn text NOT NULL,
    location text NOT NULL,
    kind text NOT NULL,
    label text NOT NULL,
    status text NOT NULL,
    register_date date DEFAULT now() NOT NULL,
    purchase_date date
);


--
-- Name: book_book_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE book_book_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: book_book_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE book_book_id_seq OWNED BY book.book_id;


--
-- Name: entry; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE entry (
    isbn text NOT NULL,
    title text NOT NULL,
    publish_year integer NOT NULL,
    publisher_id integer NOT NULL
);


--
-- Name: history; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE history (
    book_id integer NOT NULL,
    user_id integer NOT NULL,
    start_date date NOT NULL,
    return_date date NOT NULL
);


--
-- Name: member; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE member (
    user_id integer NOT NULL,
    account text NOT NULL,
    password bytea NOT NULL,
    session_expiration timestamp with time zone,
    session_id text
);


--
-- Name: lab8_user_user_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE lab8_user_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lab8_user_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE lab8_user_user_id_seq OWNED BY member.user_id;


--
-- Name: label_suffix_id_sequence; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE label_suffix_id_sequence
    START WITH 0
    INCREMENT BY 1
    NO MAXVALUE
    MINVALUE 0
    CACHE 1;


--
-- Name: label_year_sequence; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE label_year_sequence
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lending; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE lending (
    book_id integer NOT NULL,
    user_id integer NOT NULL,
    start_date date NOT NULL,
    due_date date NOT NULL
);


--
-- Name: publisher; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE publisher (
    publisher_id integer NOT NULL,
    name text NOT NULL
);


--
-- Name: publisher_publisher_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE publisher_publisher_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: publisher_publisher_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE publisher_publisher_id_seq OWNED BY publisher.publisher_id;


--
-- Name: rel_entry_authors; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE rel_entry_authors (
    isbn text NOT NULL,
    author_id integer NOT NULL
);


--
-- Name: reservation; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE reservation (
    book_id integer NOT NULL,
    user_id integer NOT NULL,
    reservation_date date DEFAULT now() NOT NULL
);


--
-- Name: wish_book; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE wish_book (
    book_id integer NOT NULL,
    user_id integer NOT NULL
);


--
-- Name: author_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY author ALTER COLUMN author_id SET DEFAULT nextval('author_author_id_seq'::regclass);


--
-- Name: book_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY book ALTER COLUMN book_id SET DEFAULT nextval('book_book_id_seq'::regclass);


--
-- Name: user_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY member ALTER COLUMN user_id SET DEFAULT nextval('lab8_user_user_id_seq'::regclass);


--
-- Name: publisher_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY publisher ALTER COLUMN publisher_id SET DEFAULT nextval('publisher_publisher_id_seq'::regclass);


--
-- Name: author_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY author
    ADD CONSTRAINT author_pkey PRIMARY KEY (author_id);


--
-- Name: book_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY book
    ADD CONSTRAINT book_pkey PRIMARY KEY (book_id);


--
-- Name: entry_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY entry
    ADD CONSTRAINT entry_pkey PRIMARY KEY (isbn);


--
-- Name: lab8_user_account_key; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY member
    ADD CONSTRAINT lab8_user_account_key UNIQUE (account);


--
-- Name: lab8_user_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY member
    ADD CONSTRAINT lab8_user_pkey PRIMARY KEY (user_id);


--
-- Name: lending_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lending
    ADD CONSTRAINT lending_pkey PRIMARY KEY (book_id);


--
-- Name: publisher_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY publisher
    ADD CONSTRAINT publisher_pkey PRIMARY KEY (publisher_id);


--
-- Name: rel_entry_authors_isbn_key; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY rel_entry_authors
    ADD CONSTRAINT rel_entry_authors_isbn_key UNIQUE (isbn, author_id);


--
-- Name: wish_book_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY wish_book
    ADD CONSTRAINT wish_book_pkey PRIMARY KEY (book_id);


--
-- Name: author_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX author_name ON author USING btree (name);


--
-- Name: book_isbn; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX book_isbn ON book USING btree (isbn);


--
-- Name: lending_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX lending_user_id ON lending USING btree (user_id);


--
-- Name: publisher_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX publisher_name ON publisher USING btree (name);


--
-- Name: rel_entry_authors_isbn; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX rel_entry_authors_isbn ON rel_entry_authors USING btree (isbn);


--
-- Name: reservation_book_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX reservation_book_id ON reservation USING btree (book_id);


--
-- Name: reservation_book_id_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX reservation_book_id_user_id ON reservation USING btree (book_id, user_id);


--
-- Name: reservation_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX reservation_user_id ON reservation USING btree (user_id);


--
-- Name: public; Type: ACL; Schema: -; Owner: -
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

