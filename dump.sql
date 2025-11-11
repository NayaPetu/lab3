--
-- PostgreSQL database dump
--

-- Dumped from database version 16.10 (Ubuntu 16.10-0ubuntu0.24.04.1)
-- Dumped by pg_dump version 17.0

-- Started on 2025-11-11 16:43:04

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 16 (class 2615 OID 25656)
-- Name: Peturova; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA "Peturova";


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 267 (class 1259 OID 25812)
-- Name: approval; Type: TABLE; Schema: Peturova; Owner: -
--

CREATE TABLE "Peturova".approval (
    id integer NOT NULL,
    document_id integer,
    employee_id integer,
    approval_date timestamp without time zone,
    comment character varying(255)
);


--
-- TOC entry 266 (class 1259 OID 25811)
-- Name: approval_id_seq; Type: SEQUENCE; Schema: Peturova; Owner: -
--

CREATE SEQUENCE "Peturova".approval_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3730 (class 0 OID 0)
-- Dependencies: 266
-- Name: approval_id_seq; Type: SEQUENCE OWNED BY; Schema: Peturova; Owner: -
--

ALTER SEQUENCE "Peturova".approval_id_seq OWNED BY "Peturova".approval.id;


--
-- TOC entry 255 (class 1259 OID 25723)
-- Name: department; Type: TABLE; Schema: Peturova; Owner: -
--

CREATE TABLE "Peturova".department (
    id integer NOT NULL,
    name character varying(200) NOT NULL,
    head_id integer
);


--
-- TOC entry 254 (class 1259 OID 25722)
-- Name: department_id_seq; Type: SEQUENCE; Schema: Peturova; Owner: -
--

CREATE SEQUENCE "Peturova".department_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3731 (class 0 OID 0)
-- Dependencies: 254
-- Name: department_id_seq; Type: SEQUENCE OWNED BY; Schema: Peturova; Owner: -
--

ALTER SEQUENCE "Peturova".department_id_seq OWNED BY "Peturova".department.id;


--
-- TOC entry 263 (class 1259 OID 25766)
-- Name: document; Type: TABLE; Schema: Peturova; Owner: -
--

CREATE TABLE "Peturova".document (
    id integer NOT NULL,
    number character varying(100) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    type_id integer,
    status_id integer,
    author_id integer,
    storage_period integer
);


--
-- TOC entry 262 (class 1259 OID 25765)
-- Name: document_id_seq; Type: SEQUENCE; Schema: Peturova; Owner: -
--

CREATE SEQUENCE "Peturova".document_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3732 (class 0 OID 0)
-- Dependencies: 262
-- Name: document_id_seq; Type: SEQUENCE OWNED BY; Schema: Peturova; Owner: -
--

ALTER SEQUENCE "Peturova".document_id_seq OWNED BY "Peturova".document.id;


--
-- TOC entry 265 (class 1259 OID 25789)
-- Name: documentflow; Type: TABLE; Schema: Peturova; Owner: -
--

CREATE TABLE "Peturova".documentflow (
    id integer NOT NULL,
    document_id integer,
    sender_id integer,
    receiver_id integer,
    sent_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    status character varying(100)
);


--
-- TOC entry 264 (class 1259 OID 25788)
-- Name: documentflow_id_seq; Type: SEQUENCE; Schema: Peturova; Owner: -
--

CREATE SEQUENCE "Peturova".documentflow_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3733 (class 0 OID 0)
-- Dependencies: 264
-- Name: documentflow_id_seq; Type: SEQUENCE OWNED BY; Schema: Peturova; Owner: -
--

ALTER SEQUENCE "Peturova".documentflow_id_seq OWNED BY "Peturova".documentflow.id;


--
-- TOC entry 261 (class 1259 OID 25759)
-- Name: dstatus; Type: TABLE; Schema: Peturova; Owner: -
--

CREATE TABLE "Peturova".dstatus (
    id integer NOT NULL,
    name character varying(100) NOT NULL
);


--
-- TOC entry 260 (class 1259 OID 25758)
-- Name: dstatus_id_seq; Type: SEQUENCE; Schema: Peturova; Owner: -
--

CREATE SEQUENCE "Peturova".dstatus_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3734 (class 0 OID 0)
-- Dependencies: 260
-- Name: dstatus_id_seq; Type: SEQUENCE OWNED BY; Schema: Peturova; Owner: -
--

ALTER SEQUENCE "Peturova".dstatus_id_seq OWNED BY "Peturova".dstatus.id;


--
-- TOC entry 259 (class 1259 OID 25752)
-- Name: dtype; Type: TABLE; Schema: Peturova; Owner: -
--

CREATE TABLE "Peturova".dtype (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    description character varying(255)
);


--
-- TOC entry 258 (class 1259 OID 25751)
-- Name: dtype_id_seq; Type: SEQUENCE; Schema: Peturova; Owner: -
--

CREATE SEQUENCE "Peturova".dtype_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3735 (class 0 OID 0)
-- Dependencies: 258
-- Name: dtype_id_seq; Type: SEQUENCE OWNED BY; Schema: Peturova; Owner: -
--

ALTER SEQUENCE "Peturova".dtype_id_seq OWNED BY "Peturova".dtype.id;


--
-- TOC entry 257 (class 1259 OID 25730)
-- Name: employee; Type: TABLE; Schema: Peturova; Owner: -
--

CREATE TABLE "Peturova".employee (
    id integer NOT NULL,
    full_name character varying(200) NOT NULL,
    role_id integer,
    department_id integer,
    contact_info character varying(255)
);


--
-- TOC entry 256 (class 1259 OID 25729)
-- Name: employee_id_seq; Type: SEQUENCE; Schema: Peturova; Owner: -
--

CREATE SEQUENCE "Peturova".employee_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3736 (class 0 OID 0)
-- Dependencies: 256
-- Name: employee_id_seq; Type: SEQUENCE OWNED BY; Schema: Peturova; Owner: -
--

ALTER SEQUENCE "Peturova".employee_id_seq OWNED BY "Peturova".employee.id;


--
-- TOC entry 253 (class 1259 OID 25716)
-- Name: role; Type: TABLE; Schema: Peturova; Owner: -
--

CREATE TABLE "Peturova".role (
    id integer NOT NULL,
    name character varying(100) NOT NULL
);


--
-- TOC entry 252 (class 1259 OID 25715)
-- Name: role_id_seq; Type: SEQUENCE; Schema: Peturova; Owner: -
--

CREATE SEQUENCE "Peturova".role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3737 (class 0 OID 0)
-- Dependencies: 252
-- Name: role_id_seq; Type: SEQUENCE OWNED BY; Schema: Peturova; Owner: -
--

ALTER SEQUENCE "Peturova".role_id_seq OWNED BY "Peturova".role.id;


--
-- TOC entry 3538 (class 2604 OID 25815)
-- Name: approval id; Type: DEFAULT; Schema: Peturova; Owner: -
--

ALTER TABLE ONLY "Peturova".approval ALTER COLUMN id SET DEFAULT nextval('"Peturova".approval_id_seq'::regclass);


--
-- TOC entry 3530 (class 2604 OID 25726)
-- Name: department id; Type: DEFAULT; Schema: Peturova; Owner: -
--

ALTER TABLE ONLY "Peturova".department ALTER COLUMN id SET DEFAULT nextval('"Peturova".department_id_seq'::regclass);


--
-- TOC entry 3534 (class 2604 OID 25769)
-- Name: document id; Type: DEFAULT; Schema: Peturova; Owner: -
--

ALTER TABLE ONLY "Peturova".document ALTER COLUMN id SET DEFAULT nextval('"Peturova".document_id_seq'::regclass);


--
-- TOC entry 3536 (class 2604 OID 25792)
-- Name: documentflow id; Type: DEFAULT; Schema: Peturova; Owner: -
--

ALTER TABLE ONLY "Peturova".documentflow ALTER COLUMN id SET DEFAULT nextval('"Peturova".documentflow_id_seq'::regclass);


--
-- TOC entry 3533 (class 2604 OID 25762)
-- Name: dstatus id; Type: DEFAULT; Schema: Peturova; Owner: -
--

ALTER TABLE ONLY "Peturova".dstatus ALTER COLUMN id SET DEFAULT nextval('"Peturova".dstatus_id_seq'::regclass);


--
-- TOC entry 3532 (class 2604 OID 25755)
-- Name: dtype id; Type: DEFAULT; Schema: Peturova; Owner: -
--

ALTER TABLE ONLY "Peturova".dtype ALTER COLUMN id SET DEFAULT nextval('"Peturova".dtype_id_seq'::regclass);


--
-- TOC entry 3531 (class 2604 OID 25733)
-- Name: employee id; Type: DEFAULT; Schema: Peturova; Owner: -
--

ALTER TABLE ONLY "Peturova".employee ALTER COLUMN id SET DEFAULT nextval('"Peturova".employee_id_seq'::regclass);


--
-- TOC entry 3529 (class 2604 OID 25719)
-- Name: role id; Type: DEFAULT; Schema: Peturova; Owner: -
--

ALTER TABLE ONLY "Peturova".role ALTER COLUMN id SET DEFAULT nextval('"Peturova".role_id_seq'::regclass);


--
-- TOC entry 3724 (class 0 OID 25812)
-- Dependencies: 267
-- Data for Name: approval; Type: TABLE DATA; Schema: Peturova; Owner: -
--

INSERT INTO "Peturova".approval VALUES (1, 1, 2, '2025-10-06 15:00:00', 'Согласовано');
INSERT INTO "Peturova".approval VALUES (2, 2, 1, '2025-10-05 12:00:00', 'Нужно доработать');
INSERT INTO "Peturova".approval VALUES (3, 3, 4, '2025-10-06 15:00:00', 'Согласовано');
INSERT INTO "Peturova".approval VALUES (4, 4, 3, '2025-10-05 12:00:00', 'Нужно доработать');
INSERT INTO "Peturova".approval VALUES (5, 5, 6, '2025-10-06 15:00:00', 'Согласовано');
INSERT INTO "Peturova".approval VALUES (6, 6, 5, '2025-10-05 12:00:00', 'Нужно доработать');
INSERT INTO "Peturova".approval VALUES (7, 7, 8, '2025-10-06 15:00:00', 'Согласовано');
INSERT INTO "Peturova".approval VALUES (8, 8, 7, '2025-10-05 12:00:00', 'Нужно доработать');


--
-- TOC entry 3712 (class 0 OID 25723)
-- Dependencies: 255
-- Data for Name: department; Type: TABLE DATA; Schema: Peturova; Owner: -
--

INSERT INTO "Peturova".department VALUES (1, 'Отдел кадров', 1);
INSERT INTO "Peturova".department VALUES (2, 'Бухгалтерия', 2);
INSERT INTO "Peturova".department VALUES (3, 'Отдел кадров', 3);
INSERT INTO "Peturova".department VALUES (4, 'Бухгалтерия', 4);
INSERT INTO "Peturova".department VALUES (5, 'Отдел кадров', 5);
INSERT INTO "Peturova".department VALUES (6, 'Бухгалтерия', 6);
INSERT INTO "Peturova".department VALUES (7, 'Отдел кадров', 7);
INSERT INTO "Peturova".department VALUES (8, 'Бухгалтерия', 8);


--
-- TOC entry 3720 (class 0 OID 25766)
-- Dependencies: 263
-- Data for Name: document; Type: TABLE DATA; Schema: Peturova; Owner: -
--

INSERT INTO "Peturova".document VALUES (1, '001/23', '2025-10-06 12:00:00', 1, 1, 1, 365);
INSERT INTO "Peturova".document VALUES (2, '002/23', '2025-10-05 09:30:00', 2, 2, 2, 730);
INSERT INTO "Peturova".document VALUES (3, '001/23', '2025-10-06 12:00:00', 3, 7, 3, 365);
INSERT INTO "Peturova".document VALUES (4, '002/23', '2025-10-05 09:30:00', 4, 8, 4, 730);
INSERT INTO "Peturova".document VALUES (5, '001/23', '2025-10-06 12:00:00', 5, 13, 5, 365);
INSERT INTO "Peturova".document VALUES (6, '002/23', '2025-10-05 09:30:00', 6, 14, 6, 730);
INSERT INTO "Peturova".document VALUES (7, '001/23', '2025-10-06 12:00:00', 7, 19, 7, 365);
INSERT INTO "Peturova".document VALUES (8, '002/23', '2025-10-05 09:30:00', 8, 20, 8, 730);


--
-- TOC entry 3722 (class 0 OID 25789)
-- Dependencies: 265
-- Data for Name: documentflow; Type: TABLE DATA; Schema: Peturova; Owner: -
--

INSERT INTO "Peturova".documentflow VALUES (1, 1, 1, 2, '2025-10-06 13:00:00', 'Отправлено');
INSERT INTO "Peturova".documentflow VALUES (2, 2, 2, 1, '2025-10-05 10:00:00', 'На согласовании');
INSERT INTO "Peturova".documentflow VALUES (3, 3, 3, 4, '2025-10-06 13:00:00', 'Отправлено');
INSERT INTO "Peturova".documentflow VALUES (4, 4, 4, 3, '2025-10-05 10:00:00', 'На согласовании');
INSERT INTO "Peturova".documentflow VALUES (5, 5, 5, 6, '2025-10-06 13:00:00', 'Отправлено');
INSERT INTO "Peturova".documentflow VALUES (6, 6, 6, 5, '2025-10-05 10:00:00', 'На согласовании');
INSERT INTO "Peturova".documentflow VALUES (7, 7, 7, 8, '2025-10-06 13:00:00', 'Отправлено');
INSERT INTO "Peturova".documentflow VALUES (8, 8, 8, 7, '2025-10-05 10:00:00', 'На согласовании');


--
-- TOC entry 3718 (class 0 OID 25759)
-- Dependencies: 261
-- Data for Name: dstatus; Type: TABLE DATA; Schema: Peturova; Owner: -
--

INSERT INTO "Peturova".dstatus VALUES (1, 'в работе');
INSERT INTO "Peturova".dstatus VALUES (2, 'на согласовании');
INSERT INTO "Peturova".dstatus VALUES (3, 'утверждён');
INSERT INTO "Peturova".dstatus VALUES (4, 'на доработке');
INSERT INTO "Peturova".dstatus VALUES (5, 'архивирован');
INSERT INTO "Peturova".dstatus VALUES (6, 'уничтожен');
INSERT INTO "Peturova".dstatus VALUES (7, 'в работе');
INSERT INTO "Peturova".dstatus VALUES (8, 'на согласовании');
INSERT INTO "Peturova".dstatus VALUES (9, 'утверждён');
INSERT INTO "Peturova".dstatus VALUES (10, 'на доработке');
INSERT INTO "Peturova".dstatus VALUES (11, 'архивирован');
INSERT INTO "Peturova".dstatus VALUES (12, 'уничтожен');
INSERT INTO "Peturova".dstatus VALUES (13, 'в работе');
INSERT INTO "Peturova".dstatus VALUES (14, 'на согласовании');
INSERT INTO "Peturova".dstatus VALUES (15, 'утверждён');
INSERT INTO "Peturova".dstatus VALUES (16, 'на доработке');
INSERT INTO "Peturova".dstatus VALUES (17, 'архивирован');
INSERT INTO "Peturova".dstatus VALUES (18, 'уничтожен');
INSERT INTO "Peturova".dstatus VALUES (19, 'в работе');
INSERT INTO "Peturova".dstatus VALUES (20, 'на согласовании');
INSERT INTO "Peturova".dstatus VALUES (21, 'утверждён');
INSERT INTO "Peturova".dstatus VALUES (22, 'на доработке');
INSERT INTO "Peturova".dstatus VALUES (23, 'архивирован');
INSERT INTO "Peturova".dstatus VALUES (24, 'уничтожен');


--
-- TOC entry 3716 (class 0 OID 25752)
-- Dependencies: 259
-- Data for Name: dtype; Type: TABLE DATA; Schema: Peturova; Owner: -
--

INSERT INTO "Peturova".dtype VALUES (1, 'Приказ', 'Приказ по организации');
INSERT INTO "Peturova".dtype VALUES (2, 'Договор', 'Договор с контрагентом');
INSERT INTO "Peturova".dtype VALUES (3, 'Приказ', 'Приказ по организации');
INSERT INTO "Peturova".dtype VALUES (4, 'Договор', 'Договор с контрагентом');
INSERT INTO "Peturova".dtype VALUES (5, 'Приказ', 'Приказ по организации');
INSERT INTO "Peturova".dtype VALUES (6, 'Договор', 'Договор с контрагентом');
INSERT INTO "Peturova".dtype VALUES (7, 'Приказ', 'Приказ по организации');
INSERT INTO "Peturova".dtype VALUES (8, 'Договор', 'Договор с контрагентом');


--
-- TOC entry 3714 (class 0 OID 25730)
-- Dependencies: 257
-- Data for Name: employee; Type: TABLE DATA; Schema: Peturova; Owner: -
--

INSERT INTO "Peturova".employee VALUES (1, 'Иван Иванов', 7, 1, 'ivan@mail.com');
INSERT INTO "Peturova".employee VALUES (2, 'Мария Петрова', 8, 2, 'maria@mail.com');
INSERT INTO "Peturova".employee VALUES (3, 'Иван Иванов', 13, 3, 'ivan@mail.com');
INSERT INTO "Peturova".employee VALUES (4, 'Мария Петрова', 14, 4, 'maria@mail.com');
INSERT INTO "Peturova".employee VALUES (5, 'Иван Иванов', 19, 5, 'ivan@mail.com');
INSERT INTO "Peturova".employee VALUES (6, 'Мария Петрова', 20, 6, 'maria@mail.com');
INSERT INTO "Peturova".employee VALUES (7, 'Иван Иванов', 25, 7, 'ivan@mail.com');
INSERT INTO "Peturova".employee VALUES (8, 'Мария Петрова', 26, 8, 'maria@mail.com');


--
-- TOC entry 3710 (class 0 OID 25716)
-- Dependencies: 253
-- Data for Name: role; Type: TABLE DATA; Schema: Peturova; Owner: -
--

INSERT INTO "Peturova".role VALUES (1, 'автор');
INSERT INTO "Peturova".role VALUES (2, 'согласующий');
INSERT INTO "Peturova".role VALUES (3, 'утверждающий');
INSERT INTO "Peturova".role VALUES (4, 'исполнитель');
INSERT INTO "Peturova".role VALUES (5, 'администратор');
INSERT INTO "Peturova".role VALUES (6, 'архивариус');
INSERT INTO "Peturova".role VALUES (7, 'автор');
INSERT INTO "Peturova".role VALUES (8, 'согласующий');
INSERT INTO "Peturova".role VALUES (9, 'утверждающий');
INSERT INTO "Peturova".role VALUES (10, 'исполнитель');
INSERT INTO "Peturova".role VALUES (11, 'администратор');
INSERT INTO "Peturova".role VALUES (12, 'архивариус');
INSERT INTO "Peturova".role VALUES (13, 'автор');
INSERT INTO "Peturova".role VALUES (14, 'согласующий');
INSERT INTO "Peturova".role VALUES (15, 'утверждающий');
INSERT INTO "Peturova".role VALUES (16, 'исполнитель');
INSERT INTO "Peturova".role VALUES (17, 'администратор');
INSERT INTO "Peturova".role VALUES (18, 'архивариус');
INSERT INTO "Peturova".role VALUES (19, 'автор');
INSERT INTO "Peturova".role VALUES (20, 'согласующий');
INSERT INTO "Peturova".role VALUES (21, 'утверждающий');
INSERT INTO "Peturova".role VALUES (22, 'исполнитель');
INSERT INTO "Peturova".role VALUES (23, 'администратор');
INSERT INTO "Peturova".role VALUES (24, 'архивариус');
INSERT INTO "Peturova".role VALUES (25, 'автор');
INSERT INTO "Peturova".role VALUES (26, 'согласующий');
INSERT INTO "Peturova".role VALUES (27, 'утверждающий');
INSERT INTO "Peturova".role VALUES (28, 'исполнитель');
INSERT INTO "Peturova".role VALUES (29, 'администратор');
INSERT INTO "Peturova".role VALUES (30, 'архивариус');


--
-- TOC entry 3738 (class 0 OID 0)
-- Dependencies: 266
-- Name: approval_id_seq; Type: SEQUENCE SET; Schema: Peturova; Owner: -
--

SELECT pg_catalog.setval('"Peturova".approval_id_seq', 8, true);


--
-- TOC entry 3739 (class 0 OID 0)
-- Dependencies: 254
-- Name: department_id_seq; Type: SEQUENCE SET; Schema: Peturova; Owner: -
--

SELECT pg_catalog.setval('"Peturova".department_id_seq', 8, true);


--
-- TOC entry 3740 (class 0 OID 0)
-- Dependencies: 262
-- Name: document_id_seq; Type: SEQUENCE SET; Schema: Peturova; Owner: -
--

SELECT pg_catalog.setval('"Peturova".document_id_seq', 8, true);


--
-- TOC entry 3741 (class 0 OID 0)
-- Dependencies: 264
-- Name: documentflow_id_seq; Type: SEQUENCE SET; Schema: Peturova; Owner: -
--

SELECT pg_catalog.setval('"Peturova".documentflow_id_seq', 8, true);


--
-- TOC entry 3742 (class 0 OID 0)
-- Dependencies: 260
-- Name: dstatus_id_seq; Type: SEQUENCE SET; Schema: Peturova; Owner: -
--

SELECT pg_catalog.setval('"Peturova".dstatus_id_seq', 24, true);


--
-- TOC entry 3743 (class 0 OID 0)
-- Dependencies: 258
-- Name: dtype_id_seq; Type: SEQUENCE SET; Schema: Peturova; Owner: -
--

SELECT pg_catalog.setval('"Peturova".dtype_id_seq', 8, true);


--
-- TOC entry 3744 (class 0 OID 0)
-- Dependencies: 256
-- Name: employee_id_seq; Type: SEQUENCE SET; Schema: Peturova; Owner: -
--

SELECT pg_catalog.setval('"Peturova".employee_id_seq', 8, true);


--
-- TOC entry 3745 (class 0 OID 0)
-- Dependencies: 252
-- Name: role_id_seq; Type: SEQUENCE SET; Schema: Peturova; Owner: -
--

SELECT pg_catalog.setval('"Peturova".role_id_seq', 30, true);


--
-- TOC entry 3554 (class 2606 OID 25817)
-- Name: approval approval_pkey; Type: CONSTRAINT; Schema: Peturova; Owner: -
--

ALTER TABLE ONLY "Peturova".approval
    ADD CONSTRAINT approval_pkey PRIMARY KEY (id);


--
-- TOC entry 3542 (class 2606 OID 25728)
-- Name: department department_pkey; Type: CONSTRAINT; Schema: Peturova; Owner: -
--

ALTER TABLE ONLY "Peturova".department
    ADD CONSTRAINT department_pkey PRIMARY KEY (id);


--
-- TOC entry 3550 (class 2606 OID 25772)
-- Name: document document_pkey; Type: CONSTRAINT; Schema: Peturova; Owner: -
--

ALTER TABLE ONLY "Peturova".document
    ADD CONSTRAINT document_pkey PRIMARY KEY (id);


--
-- TOC entry 3552 (class 2606 OID 25795)
-- Name: documentflow documentflow_pkey; Type: CONSTRAINT; Schema: Peturova; Owner: -
--

ALTER TABLE ONLY "Peturova".documentflow
    ADD CONSTRAINT documentflow_pkey PRIMARY KEY (id);


--
-- TOC entry 3548 (class 2606 OID 25764)
-- Name: dstatus dstatus_pkey; Type: CONSTRAINT; Schema: Peturova; Owner: -
--

ALTER TABLE ONLY "Peturova".dstatus
    ADD CONSTRAINT dstatus_pkey PRIMARY KEY (id);


--
-- TOC entry 3546 (class 2606 OID 25757)
-- Name: dtype dtype_pkey; Type: CONSTRAINT; Schema: Peturova; Owner: -
--

ALTER TABLE ONLY "Peturova".dtype
    ADD CONSTRAINT dtype_pkey PRIMARY KEY (id);


--
-- TOC entry 3544 (class 2606 OID 25735)
-- Name: employee employee_pkey; Type: CONSTRAINT; Schema: Peturova; Owner: -
--

ALTER TABLE ONLY "Peturova".employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (id);


--
-- TOC entry 3540 (class 2606 OID 25721)
-- Name: role role_pkey; Type: CONSTRAINT; Schema: Peturova; Owner: -
--

ALTER TABLE ONLY "Peturova".role
    ADD CONSTRAINT role_pkey PRIMARY KEY (id);


--
-- TOC entry 3564 (class 2606 OID 25818)
-- Name: approval approval_document_id_fkey; Type: FK CONSTRAINT; Schema: Peturova; Owner: -
--

ALTER TABLE ONLY "Peturova".approval
    ADD CONSTRAINT approval_document_id_fkey FOREIGN KEY (document_id) REFERENCES "Peturova".document(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3565 (class 2606 OID 25823)
-- Name: approval approval_employee_id_fkey; Type: FK CONSTRAINT; Schema: Peturova; Owner: -
--

ALTER TABLE ONLY "Peturova".approval
    ADD CONSTRAINT approval_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES "Peturova".employee(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 3558 (class 2606 OID 25783)
-- Name: document document_author_id_fkey; Type: FK CONSTRAINT; Schema: Peturova; Owner: -
--

ALTER TABLE ONLY "Peturova".document
    ADD CONSTRAINT document_author_id_fkey FOREIGN KEY (author_id) REFERENCES "Peturova".employee(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 3559 (class 2606 OID 25778)
-- Name: document document_status_id_fkey; Type: FK CONSTRAINT; Schema: Peturova; Owner: -
--

ALTER TABLE ONLY "Peturova".document
    ADD CONSTRAINT document_status_id_fkey FOREIGN KEY (status_id) REFERENCES "Peturova".dstatus(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 3560 (class 2606 OID 25773)
-- Name: document document_type_id_fkey; Type: FK CONSTRAINT; Schema: Peturova; Owner: -
--

ALTER TABLE ONLY "Peturova".document
    ADD CONSTRAINT document_type_id_fkey FOREIGN KEY (type_id) REFERENCES "Peturova".dtype(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 3561 (class 2606 OID 25796)
-- Name: documentflow documentflow_document_id_fkey; Type: FK CONSTRAINT; Schema: Peturova; Owner: -
--

ALTER TABLE ONLY "Peturova".documentflow
    ADD CONSTRAINT documentflow_document_id_fkey FOREIGN KEY (document_id) REFERENCES "Peturova".document(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3562 (class 2606 OID 25806)
-- Name: documentflow documentflow_receiver_id_fkey; Type: FK CONSTRAINT; Schema: Peturova; Owner: -
--

ALTER TABLE ONLY "Peturova".documentflow
    ADD CONSTRAINT documentflow_receiver_id_fkey FOREIGN KEY (receiver_id) REFERENCES "Peturova".employee(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 3563 (class 2606 OID 25801)
-- Name: documentflow documentflow_sender_id_fkey; Type: FK CONSTRAINT; Schema: Peturova; Owner: -
--

ALTER TABLE ONLY "Peturova".documentflow
    ADD CONSTRAINT documentflow_sender_id_fkey FOREIGN KEY (sender_id) REFERENCES "Peturova".employee(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 3556 (class 2606 OID 25741)
-- Name: employee employee_department_id_fkey; Type: FK CONSTRAINT; Schema: Peturova; Owner: -
--

ALTER TABLE ONLY "Peturova".employee
    ADD CONSTRAINT employee_department_id_fkey FOREIGN KEY (department_id) REFERENCES "Peturova".department(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 3557 (class 2606 OID 25736)
-- Name: employee employee_role_id_fkey; Type: FK CONSTRAINT; Schema: Peturova; Owner: -
--

ALTER TABLE ONLY "Peturova".employee
    ADD CONSTRAINT employee_role_id_fkey FOREIGN KEY (role_id) REFERENCES "Peturova".role(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 3555 (class 2606 OID 25746)
-- Name: department fk_department_head; Type: FK CONSTRAINT; Schema: Peturova; Owner: -
--

ALTER TABLE ONLY "Peturova".department
    ADD CONSTRAINT fk_department_head FOREIGN KEY (head_id) REFERENCES "Peturova".employee(id) ON UPDATE CASCADE ON DELETE SET NULL;


-- Completed on 2025-11-11 16:43:17

--
-- PostgreSQL database dump complete
--

