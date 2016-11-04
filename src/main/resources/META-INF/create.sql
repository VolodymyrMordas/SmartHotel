--
-- PostgreSQL database dump
--

-- Dumped from database version 9.4.4
-- Dumped by pg_dump version 9.4.0
-- Started on 2016-10-29 13:29:59 EEST

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 200 (class 3079 OID 12123)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner:
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2424 (class 0 OID 0)
-- Dependencies: 200
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner:
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--SET search_path = public, pg_catalog;
SET search_path = public, pg_catalog;
SET default_tablespace = '';
SET default_with_oids = false;

--
-- TOC entry 191 (class 1259 OID 91972)
-- Name: k_admin_group; Type: TABLE; Schema: public; Owner: volodymyrmordas; Tablespace:
--

CREATE TABLE k_admin_group (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    description character varying(255),
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);

CREATE SEQUENCE k_admin_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE k_admin_group_id_seq OWNED BY k_admin_group.id;

--
-- TOC entry 190 (class 1259 OID 91956)
-- Name: k_admin_user; Type: TABLE; Schema: public; Owner: volodymyrmordas; Tablespace:
--

CREATE TABLE k_admin_user (
    id integer NOT NULL,
    first_name character varying(50),
    last_name character varying(50),
    email character varying(50) NOT NULL,
    password character varying(100) NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);

CREATE SEQUENCE k_admin_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE k_admin_user_id_seq OWNED BY k_admin_user.id;

--
-- TOC entry 192 (class 1259 OID 91979)
-- Name: k_admin_user_group; Type: TABLE; Schema: public; Owner: volodymyrmordas; Tablespace:
--

CREATE TABLE k_admin_user_group (
    admin_user_id integer NOT NULL,
    admin_group_id integer NOT NULL
);

--
-- TOC entry 178 (class 1259 OID 88184)
-- Name: k_apartment; Type: TABLE; Schema: public; Owner: volodymyrmordas; Tablespace:
--

CREATE TABLE k_apartment (
    id bigint NOT NULL,
    building_id bigint NOT NULL,
    title character varying(100),
    type smallint DEFAULT 0 NOT NULL,
    status smallint DEFAULT 0 NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    description character varying(100),
    number character varying(10)
);

CREATE SEQUENCE k_apartment_building_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE k_apartment_building_id_seq OWNED BY k_apartment.building_id;

CREATE SEQUENCE k_apartment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE k_apartment_id_seq OWNED BY k_apartment.id;


CREATE TABLE k_apartment_media (
    id bigint NOT NULL,
    apartment_id bigint NOT NULL,
    filename character varying(100) NOT NULL,
    type smallint DEFAULT 0 NOT NULL,
    status smallint DEFAULT 0 NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);

CREATE SEQUENCE k_apartment_media_apartment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE k_apartment_media_apartment_id_seq OWNED BY k_apartment_media.apartment_id;

CREATE SEQUENCE k_apartment_media_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE k_apartment_media_id_seq OWNED BY k_apartment_media.id;

CREATE TABLE k_apartment_price (
    id bigint NOT NULL,
    apartment_id bigint NOT NULL,
    price numeric(10,2) DEFAULT 0 NOT NULL,
    start_at timestamp without time zone NOT NULL,
    type smallint DEFAULT 0 NOT NULL,
    status smallint DEFAULT 0 NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);

CREATE SEQUENCE k_apartment_price_apartment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE k_apartment_price_apartment_id_seq OWNED BY k_apartment_price.apartment_id;

CREATE SEQUENCE k_apartment_price_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE k_apartment_price_id_seq OWNED BY k_apartment_price.id;

CREATE TABLE k_billing (
    id bigint NOT NULL,
    order_id bigint NOT NULL,
    amount numeric DEFAULT 0 NOT NULL,
    currency_code smallint NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    payment_date timestamp without time zone DEFAULT now() NOT NULL
);


CREATE SEQUENCE k_billing_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE k_billing_id_seq OWNED BY k_billing.id;

CREATE SEQUENCE k_billing_order_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE k_billing_order_id_seq OWNED BY k_billing.order_id;

CREATE TABLE k_building (
    id bigint NOT NULL,
    title character varying(200),
    lat numeric(15,10),
    lng numeric(15,10),
    type smallint DEFAULT 0 NOT NULL,
    status smallint DEFAULT 0 NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    description character varying(1024)
);

CREATE SEQUENCE k_building_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE k_building_id_seq OWNED BY k_building.id;

CREATE TABLE k_order (
    id bigint NOT NULL,
    building_id bigint NOT NULL,
    apartment_id bigint,
    title character varying(200),
    start_at timestamp without time zone NOT NULL,
    end_at timestamp without time zone NOT NULL,
    type smallint DEFAULT 0 NOT NULL,
    status smallint DEFAULT 0 NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    user_id bigint NOT NULL
);

CREATE SEQUENCE k_order_apartment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE k_order_apartment_id_seq OWNED BY k_order.apartment_id;

CREATE SEQUENCE k_order_building_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE k_order_building_id_seq OWNED BY k_order.building_id;

CREATE SEQUENCE k_order_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE k_order_id_seq OWNED BY k_order.id;

CREATE SEQUENCE k_order_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE k_order_user_id_seq OWNED BY k_order.user_id;

CREATE TABLE k_user (
    id bigint NOT NULL,
    first_name character varying(50),
    last_name character varying(50),
    phone character varying(15) NOT NULL,
    email character varying(50),
    type smallint DEFAULT 0 NOT NULL,
    status smallint DEFAULT 0 NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    phone_verified boolean DEFAULT false NOT NULL,
    email_verified boolean DEFAULT false NOT NULL
);

CREATE SEQUENCE k_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE k_user_id_seq OWNED BY k_user.id;

CREATE TABLE k_verification (
    id bigint NOT NULL,
    code smallint NOT NULL,
    user_id bigint NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    type smallint NOT NULL
);

CREATE SEQUENCE k_verification_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE k_verification_id_seq OWNED BY k_verification.id;

CREATE SEQUENCE k_verification_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE k_verification_user_id_seq OWNED BY k_verification.user_id;

CREATE VIEW v_admin_user_group AS
 SELECT au.id,
    au.email,
    au.password,
    ag.name AS admin_user_group
   FROM k_admin_group ag,
    k_admin_user au,
    k_admin_user_group aug
  WHERE ((au.id = aug.admin_user_id) AND (ag.id = aug.admin_group_id));

ALTER TABLE ONLY k_apartment ALTER COLUMN id SET DEFAULT nextval('k_apartment_id_seq'::regclass);

ALTER TABLE ONLY k_apartment ALTER COLUMN building_id SET DEFAULT nextval('k_apartment_building_id_seq'::regclass);

ALTER TABLE ONLY k_apartment_media ALTER COLUMN id SET DEFAULT nextval('k_apartment_media_id_seq'::regclass);

ALTER TABLE ONLY k_apartment_media ALTER COLUMN apartment_id SET DEFAULT nextval('k_apartment_media_apartment_id_seq'::regclass);

ALTER TABLE ONLY k_apartment_price ALTER COLUMN id SET DEFAULT nextval('k_apartment_price_id_seq'::regclass);

ALTER TABLE ONLY k_apartment_price ALTER COLUMN apartment_id SET DEFAULT nextval('k_apartment_price_apartment_id_seq'::regclass);

ALTER TABLE ONLY k_billing ALTER COLUMN id SET DEFAULT nextval('k_billing_id_seq'::regclass);

ALTER TABLE ONLY k_billing ALTER COLUMN order_id SET DEFAULT nextval('k_billing_order_id_seq'::regclass);

ALTER TABLE ONLY k_building ALTER COLUMN id SET DEFAULT nextval('k_building_id_seq'::regclass);

ALTER TABLE ONLY k_order ALTER COLUMN id SET DEFAULT nextval('k_order_id_seq'::regclass);

ALTER TABLE ONLY k_order ALTER COLUMN building_id SET DEFAULT nextval('k_order_building_id_seq'::regclass);

ALTER TABLE ONLY k_order ALTER COLUMN apartment_id SET DEFAULT nextval('k_order_apartment_id_seq'::regclass);

ALTER TABLE ONLY k_order ALTER COLUMN user_id SET DEFAULT nextval('k_order_user_id_seq'::regclass);

ALTER TABLE ONLY k_user ALTER COLUMN id SET DEFAULT nextval('k_user_id_seq'::regclass);

ALTER TABLE ONLY k_admin_group ALTER COLUMN id SET DEFAULT nextval('k_admin_group_id_seq'::regclass);

ALTER TABLE ONLY k_admin_user ALTER COLUMN id SET DEFAULT nextval('k_admin_user_id_seq'::regclass);

ALTER TABLE ONLY k_verification ALTER COLUMN id SET DEFAULT nextval('k_verification_id_seq'::regclass);

ALTER TABLE ONLY k_verification ALTER COLUMN user_id SET DEFAULT nextval('k_verification_user_id_seq'::regclass);

ALTER TABLE ONLY k_admin_group ADD CONSTRAINT admin_groups_id_pkey PRIMARY KEY (id);

ALTER TABLE ONLY k_admin_user
    ADD CONSTRAINT admin_user_admin_pkey PRIMARY KEY (id);

ALTER TABLE ONLY k_admin_group
    ADD CONSTRAINT admin_group_pkey PRIMARY KEY (id);

ALTER TABLE ONLY k_admin_user
    ADD CONSTRAINT admin_user_unique_email UNIQUE (email);

ALTER TABLE ONLY k_apartment
    ADD CONSTRAINT apartment_id_pkey PRIMARY KEY (id);

ALTER TABLE ONLY k_apartment_media
    ADD CONSTRAINT apartment_media_id_pkey PRIMARY KEY (id);

ALTER TABLE ONLY k_apartment_price
    ADD CONSTRAINT apartment_price_id_pkey PRIMARY KEY (id);

ALTER TABLE ONLY k_billing
    ADD CONSTRAINT billing_id_pkey PRIMARY KEY (id);

ALTER TABLE ONLY k_building
    ADD CONSTRAINT building_id_pkey PRIMARY KEY (id);

ALTER TABLE ONLY k_order
    ADD CONSTRAINT order_id_pkey PRIMARY KEY (id);

ALTER TABLE ONLY k_user
    ADD CONSTRAINT user_id_pkey PRIMARY KEY (id);

ALTER TABLE ONLY k_verification
    ADD CONSTRAINT verification_id_pkey PRIMARY KEY (id);

ALTER TABLE ONLY k_verification
    ADD CONSTRAINT verification_unique UNIQUE (user_id, type);

ALTER TABLE ONLY k_admin_user_group
    ADD CONSTRAINT admin_user_group_group_fkey FOREIGN KEY (admin_group_id) REFERENCES k_admin_group(id);

ALTER TABLE ONLY k_admin_user_group
    ADD CONSTRAINT admin_user_group_user_fkey FOREIGN KEY (admin_user_id) REFERENCES k_admin_user(id);

ALTER TABLE ONLY k_apartment
    ADD CONSTRAINT apartment_building_id_fkey FOREIGN KEY (building_id) REFERENCES k_building(id);

ALTER TABLE ONLY k_apartment_media
    ADD CONSTRAINT apartment_media_fkey FOREIGN KEY (apartment_id) REFERENCES k_apartment(id);

ALTER TABLE ONLY k_apartment_price
    ADD CONSTRAINT apartment_price_apartment_fkey FOREIGN KEY (apartment_id) REFERENCES k_apartment(id);

ALTER TABLE ONLY k_billing
    ADD CONSTRAINT billing_order_id_fkey FOREIGN KEY (order_id) REFERENCES k_order(id);

ALTER TABLE ONLY k_order
    ADD CONSTRAINT order_apartment_id_fkey FOREIGN KEY (apartment_id) REFERENCES k_apartment(id);

ALTER TABLE ONLY k_order
    ADD CONSTRAINT order_building_id_fkey FOREIGN KEY (building_id) REFERENCES k_building(id);

ALTER TABLE ONLY k_order
    ADD CONSTRAINT order_user_id_fkey FOREIGN KEY (user_id) REFERENCES k_user(id);

ALTER TABLE ONLY k_verification
    ADD CONSTRAINT verification_user_id_fkey FOREIGN KEY (user_id) REFERENCES k_user(id);