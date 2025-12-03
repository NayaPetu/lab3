--
-- PostgreSQL database dump
--

-- Dumped from database version 16.10 (Ubuntu 16.10-0ubuntu0.24.04.1)
-- Dumped by pg_dump version 17.0

-- Started on 2025-12-03 17:06:34

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
-- TOC entry 15 (class 2615 OID 25656)
-- Name: Peturova; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA "Peturova";


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 270 (class 1259 OID 25812)
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
-- TOC entry 269 (class 1259 OID 25811)
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
-- TOC entry 3967 (class 0 OID 0)
-- Dependencies: 269
-- Name: approval_id_seq; Type: SEQUENCE OWNED BY; Schema: Peturova; Owner: -
--

ALTER SEQUENCE "Peturova".approval_id_seq OWNED BY "Peturova".approval.id;


--
-- TOC entry 258 (class 1259 OID 25723)
-- Name: department; Type: TABLE; Schema: Peturova; Owner: -
--

CREATE TABLE "Peturova".department (
    id integer NOT NULL,
    name character varying(200) NOT NULL,
    head_id integer
);


--
-- TOC entry 257 (class 1259 OID 25722)
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
-- TOC entry 3968 (class 0 OID 0)
-- Dependencies: 257
-- Name: department_id_seq; Type: SEQUENCE OWNED BY; Schema: Peturova; Owner: -
--

ALTER SEQUENCE "Peturova".department_id_seq OWNED BY "Peturova".department.id;


--
-- TOC entry 266 (class 1259 OID 25766)
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
-- TOC entry 265 (class 1259 OID 25765)
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
-- TOC entry 3969 (class 0 OID 0)
-- Dependencies: 265
-- Name: document_id_seq; Type: SEQUENCE OWNED BY; Schema: Peturova; Owner: -
--

ALTER SEQUENCE "Peturova".document_id_seq OWNED BY "Peturova".document.id;


--
-- TOC entry 268 (class 1259 OID 25789)
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
-- TOC entry 267 (class 1259 OID 25788)
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
-- TOC entry 3970 (class 0 OID 0)
-- Dependencies: 267
-- Name: documentflow_id_seq; Type: SEQUENCE OWNED BY; Schema: Peturova; Owner: -
--

ALTER SEQUENCE "Peturova".documentflow_id_seq OWNED BY "Peturova".documentflow.id;


--
-- TOC entry 264 (class 1259 OID 25759)
-- Name: dstatus; Type: TABLE; Schema: Peturova; Owner: -
--

CREATE TABLE "Peturova".dstatus (
    id integer NOT NULL,
    name character varying(100) NOT NULL
);


--
-- TOC entry 263 (class 1259 OID 25758)
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
-- TOC entry 3971 (class 0 OID 0)
-- Dependencies: 263
-- Name: dstatus_id_seq; Type: SEQUENCE OWNED BY; Schema: Peturova; Owner: -
--

ALTER SEQUENCE "Peturova".dstatus_id_seq OWNED BY "Peturova".dstatus.id;


--
-- TOC entry 262 (class 1259 OID 25752)
-- Name: dtype; Type: TABLE; Schema: Peturova; Owner: -
--

CREATE TABLE "Peturova".dtype (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    description character varying(255)
);


--
-- TOC entry 261 (class 1259 OID 25751)
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
-- TOC entry 3972 (class 0 OID 0)
-- Dependencies: 261
-- Name: dtype_id_seq; Type: SEQUENCE OWNED BY; Schema: Peturova; Owner: -
--

ALTER SEQUENCE "Peturova".dtype_id_seq OWNED BY "Peturova".dtype.id;


--
-- TOC entry 260 (class 1259 OID 25730)
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
-- TOC entry 259 (class 1259 OID 25729)
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
-- TOC entry 3973 (class 0 OID 0)
-- Dependencies: 259
-- Name: employee_id_seq; Type: SEQUENCE OWNED BY; Schema: Peturova; Owner: -
--

ALTER SEQUENCE "Peturova".employee_id_seq OWNED BY "Peturova".employee.id;


--
-- TOC entry 256 (class 1259 OID 25716)
-- Name: role; Type: TABLE; Schema: Peturova; Owner: -
--

CREATE TABLE "Peturova".role (
    id integer NOT NULL,
    name character varying(100) NOT NULL
);


--
-- TOC entry 255 (class 1259 OID 25715)
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
-- TOC entry 3974 (class 0 OID 0)
-- Dependencies: 255
-- Name: role_id_seq; Type: SEQUENCE OWNED BY; Schema: Peturova; Owner: -
--

ALTER SEQUENCE "Peturova".role_id_seq OWNED BY "Peturova".role.id;


--
-- TOC entry 3775 (class 2604 OID 25815)
-- Name: approval id; Type: DEFAULT; Schema: Peturova; Owner: -
--

ALTER TABLE ONLY "Peturova".approval ALTER COLUMN id SET DEFAULT nextval('"Peturova".approval_id_seq'::regclass);


--
-- TOC entry 3767 (class 2604 OID 25726)
-- Name: department id; Type: DEFAULT; Schema: Peturova; Owner: -
--

ALTER TABLE ONLY "Peturova".department ALTER COLUMN id SET DEFAULT nextval('"Peturova".department_id_seq'::regclass);


--
-- TOC entry 3771 (class 2604 OID 25769)
-- Name: document id; Type: DEFAULT; Schema: Peturova; Owner: -
--

ALTER TABLE ONLY "Peturova".document ALTER COLUMN id SET DEFAULT nextval('"Peturova".document_id_seq'::regclass);


--
-- TOC entry 3773 (class 2604 OID 25792)
-- Name: documentflow id; Type: DEFAULT; Schema: Peturova; Owner: -
--

ALTER TABLE ONLY "Peturova".documentflow ALTER COLUMN id SET DEFAULT nextval('"Peturova".documentflow_id_seq'::regclass);


--
-- TOC entry 3770 (class 2604 OID 25762)
-- Name: dstatus id; Type: DEFAULT; Schema: Peturova; Owner: -
--

ALTER TABLE ONLY "Peturova".dstatus ALTER COLUMN id SET DEFAULT nextval('"Peturova".dstatus_id_seq'::regclass);


--
-- TOC entry 3769 (class 2604 OID 25755)
-- Name: dtype id; Type: DEFAULT; Schema: Peturova; Owner: -
--

ALTER TABLE ONLY "Peturova".dtype ALTER COLUMN id SET DEFAULT nextval('"Peturova".dtype_id_seq'::regclass);


--
-- TOC entry 3768 (class 2604 OID 25733)
-- Name: employee id; Type: DEFAULT; Schema: Peturova; Owner: -
--

ALTER TABLE ONLY "Peturova".employee ALTER COLUMN id SET DEFAULT nextval('"Peturova".employee_id_seq'::regclass);


--
-- TOC entry 3766 (class 2604 OID 25719)
-- Name: role id; Type: DEFAULT; Schema: Peturova; Owner: -
--

ALTER TABLE ONLY "Peturova".role ALTER COLUMN id SET DEFAULT nextval('"Peturova".role_id_seq'::regclass);


--
-- TOC entry 3961 (class 0 OID 25812)
-- Dependencies: 270
-- Data for Name: approval; Type: TABLE DATA; Schema: Peturova; Owner: -
--

INSERT INTO "Peturova".approval VALUES (20, 25, 51, '2025-10-06 15:00:00', 'Согласовано');
INSERT INTO "Peturova".approval VALUES (21, 26, 50, '2025-10-05 12:00:00', 'Нужно доработать');
INSERT INTO "Peturova".approval VALUES (22, 25, 51, '2023-01-16 11:20:00', 'Утверждено');
INSERT INTO "Peturova".approval VALUES (23, 26, 56, '2023-02-11 10:15:00', 'Юридически корректно');
INSERT INTO "Peturova".approval VALUES (24, 26, 54, '2023-02-12 14:45:00', 'Финансовые условия приемлемы');
INSERT INTO "Peturova".approval VALUES (25, 26, 50, '2023-02-13 09:10:00', 'Утверждаю');
INSERT INTO "Peturova".approval VALUES (26, 27, 51, '2023-10-06 10:30:00', 'Утверждено');
INSERT INTO "Peturova".approval VALUES (27, 29, 54, '2023-05-19 13:15:00', 'Согласовано');
INSERT INTO "Peturova".approval VALUES (28, 29, 50, '2023-05-20 09:45:00', 'Утверждено');
INSERT INTO "Peturova".approval VALUES (29, 30, 55, '2023-03-25 16:30:00', 'Работы выполнены в полном объёме');
INSERT INTO "Peturova".approval VALUES (30, 31, 56, '2023-04-26 11:10:00', 'Замечаний нет');


--
-- TOC entry 3949 (class 0 OID 25723)
-- Dependencies: 258
-- Data for Name: department; Type: TABLE DATA; Schema: Peturova; Owner: -
--

INSERT INTO "Peturova".department VALUES (45, 'Отдел закупок', NULL);
INSERT INTO "Peturova".department VALUES (46, 'Производственный отдел', NULL);
INSERT INTO "Peturova".department VALUES (47, 'Отдел маркетинга', NULL);
INSERT INTO "Peturova".department VALUES (39, 'Руководство', 50);
INSERT INTO "Peturova".department VALUES (40, 'Отдел кадров', 52);
INSERT INTO "Peturova".department VALUES (41, 'Бухгалтерия', 54);
INSERT INTO "Peturova".department VALUES (42, 'Юридический отдел', 56);
INSERT INTO "Peturova".department VALUES (43, 'IT-отдел', 57);
INSERT INTO "Peturova".department VALUES (44, 'Отдел продаж', 10);
INSERT INTO "Peturova".department VALUES (48, 'Архив', 11);


--
-- TOC entry 3957 (class 0 OID 25766)
-- Dependencies: 266
-- Data for Name: document; Type: TABLE DATA; Schema: Peturova; Owner: -
--

INSERT INTO "Peturova".document VALUES (26, 'ДГ-002/23', '2023-02-10 00:00:00', 34, 55, 9, 1825);
INSERT INTO "Peturova".document VALUES (27, 'ПР-003/23', '2023-10-05 00:00:00', 33, 55, 50, 3650);
INSERT INTO "Peturova".document VALUES (28, 'СЗ-004/23', '2023-09-01 00:00:00', 35, 53, 57, 365);
INSERT INTO "Peturova".document VALUES (29, 'СЗ-005/23', '2023-05-18 00:00:00', 35, 55, 52, 365);
INSERT INTO "Peturova".document VALUES (30, 'АКТ-006/23', '2023-03-20 00:00:00', 37, 58, 54, 1095);
INSERT INTO "Peturova".document VALUES (31, 'ОТЧ-007/23', '2023-04-25 00:00:00', 40, 54, 10, 1825);
INSERT INTO "Peturova".document VALUES (32, 'ПР-008/23', '2023-11-01 00:00:00', 33, 53, 50, 3650);
INSERT INTO "Peturova".document VALUES (25, 'ПР-001/23-ОБН', '2023-01-15 00:00:00', 33, 55, 50, 500);


--
-- TOC entry 3959 (class 0 OID 25789)
-- Dependencies: 268
-- Data for Name: documentflow; Type: TABLE DATA; Schema: Peturova; Owner: -
--

INSERT INTO "Peturova".documentflow VALUES (24, 25, 50, 51, '2025-10-06 13:00:00', 'Отправлено');
INSERT INTO "Peturova".documentflow VALUES (25, 26, 51, 50, '2025-10-05 10:00:00', 'На согласовании');
INSERT INTO "Peturova".documentflow VALUES (26, 25, 50, 51, '2023-01-15 14:30:00', 'Отправлено на утверждение');
INSERT INTO "Peturova".documentflow VALUES (27, 26, 9, 56, '2023-02-10 15:00:00', 'На согласовании');
INSERT INTO "Peturova".documentflow VALUES (28, 26, 56, 54, '2023-02-11 11:00:00', 'На согласовании');
INSERT INTO "Peturova".documentflow VALUES (29, 26, 54, 50, '2023-02-12 15:30:00', 'На утверждение');
INSERT INTO "Peturova".documentflow VALUES (30, 27, 50, 51, '2023-10-05 16:00:00', 'Отправлено на утверждение');
INSERT INTO "Peturova".documentflow VALUES (31, 28, 57, 56, '2023-09-01 11:20:00', 'На согласовании');
INSERT INTO "Peturova".documentflow VALUES (32, 29, 52, 54, '2023-05-18 10:00:00', 'На согласовании');
INSERT INTO "Peturova".documentflow VALUES (33, 29, 54, 50, '2023-05-19 14:00:00', 'На утверждение');
INSERT INTO "Peturova".documentflow VALUES (34, 30, 54, 55, '2023-03-20 12:00:00', 'На исполнение');
INSERT INTO "Peturova".documentflow VALUES (35, 30, 55, 54, '2023-03-25 16:30:00', 'Исполнено');
INSERT INTO "Peturova".documentflow VALUES (36, 31, 10, 56, '2023-04-25 17:00:00', 'На согласовании');
INSERT INTO "Peturova".documentflow VALUES (37, 32, 50, 56, '2023-11-01 14:00:00', 'На согласовании');
INSERT INTO "Peturova".documentflow VALUES (38, 32, 50, 54, '2023-11-01 14:05:00', 'На согласовании');


--
-- TOC entry 3955 (class 0 OID 25759)
-- Dependencies: 264
-- Data for Name: dstatus; Type: TABLE DATA; Schema: Peturova; Owner: -
--

INSERT INTO "Peturova".dstatus VALUES (52, 'Черновик');
INSERT INTO "Peturova".dstatus VALUES (53, 'На согласовании');
INSERT INTO "Peturova".dstatus VALUES (54, 'Согласован');
INSERT INTO "Peturova".dstatus VALUES (55, 'Утвержден');
INSERT INTO "Peturova".dstatus VALUES (56, 'На доработке');
INSERT INTO "Peturova".dstatus VALUES (57, 'Исполняется');
INSERT INTO "Peturova".dstatus VALUES (58, 'Исполнен');
INSERT INTO "Peturova".dstatus VALUES (59, 'Архивирован');
INSERT INTO "Peturova".dstatus VALUES (60, 'Уничтожен');


--
-- TOC entry 3953 (class 0 OID 25752)
-- Dependencies: 262
-- Data for Name: dtype; Type: TABLE DATA; Schema: Peturova; Owner: -
--

INSERT INTO "Peturova".dtype VALUES (33, 'Приказ', 'Распорядительный документ по основной деятельности');
INSERT INTO "Peturova".dtype VALUES (34, 'Договор', 'Документ, оформляющий соглашение сторон');
INSERT INTO "Peturova".dtype VALUES (35, 'Служебная записка', 'Документ внутренней переписки');
INSERT INTO "Peturova".dtype VALUES (36, 'Протокол', 'Документ, фиксирующий ход обсуждения и решения');
INSERT INTO "Peturova".dtype VALUES (37, 'Акт', 'Документ, подтверждающий факт выполнения работ');
INSERT INTO "Peturova".dtype VALUES (38, 'Письмо', 'Официальное обращение к контрагенту');
INSERT INTO "Peturova".dtype VALUES (39, 'Заявление', 'Документ с просьбой или предложением');
INSERT INTO "Peturova".dtype VALUES (40, 'Отчет', 'Документ с результатами работы');


--
-- TOC entry 3951 (class 0 OID 25730)
-- Dependencies: 260
-- Data for Name: employee; Type: TABLE DATA; Schema: Peturova; Owner: -
--

INSERT INTO "Peturova".employee VALUES (50, 'Смирнов Алексей Петрович', 54, 39, 'smirnov@company.com, +7 (495) 111-11-11');
INSERT INTO "Peturova".employee VALUES (51, 'Кузнецова Ольга Ивановна', 51, 39, 'kuznetsova@company.com, +7 (495) 111-11-12');
INSERT INTO "Peturova".employee VALUES (52, 'Иванова Мария Сергеевна', 49, 40, 'ivanova@company.com, +7 (495) 111-11-21');
INSERT INTO "Peturova".employee VALUES (53, 'Петров Игорь Васильевич', 52, 40, 'petrov@company.com, +7 (495) 111-11-22');
INSERT INTO "Peturova".employee VALUES (54, 'Сидорова Анна Михайловна', 50, 41, 'sidorova@company.com, +7 (495) 111-11-31');
INSERT INTO "Peturova".employee VALUES (55, 'Федоров Дмитрий Александрович', 52, 41, 'fedorov@company.com, +7 (495) 111-11-32');
INSERT INTO "Peturova".employee VALUES (56, 'Николаева Елена Владимировна', 50, 42, 'nikolaeva@company.com, +7 (495) 111-11-41');
INSERT INTO "Peturova".employee VALUES (57, 'Волков Павел Олегович', 52, 43, 'volkov@company.com, +7 (495) 111-11-51');
INSERT INTO "Peturova".employee VALUES (9, 'Лебедева Татьяна Юрьевна', 49, 43, 'lebedeva@company.com, +7 (495) 111-11-52');
INSERT INTO "Peturova".employee VALUES (10, 'Козлов Андрей Николаевич', 49, 44, 'kozlov@company.com, +7 (495) 111-11-61');
INSERT INTO "Peturova".employee VALUES (11, 'Морозова Людмила Анатольевна', 53, 48, 'morozova@company.com, +7 (495) 111-11-91');


--
-- TOC entry 3947 (class 0 OID 25716)
-- Dependencies: 256
-- Data for Name: role; Type: TABLE DATA; Schema: Peturova; Owner: -
--

INSERT INTO "Peturova".role VALUES (49, 'Автор');
INSERT INTO "Peturova".role VALUES (50, 'Согласующий');
INSERT INTO "Peturova".role VALUES (51, 'Утверждающий');
INSERT INTO "Peturova".role VALUES (52, 'Исполнитель');
INSERT INTO "Peturova".role VALUES (53, 'Архивариус');
INSERT INTO "Peturova".role VALUES (54, 'Администратор');


--
-- TOC entry 3975 (class 0 OID 0)
-- Dependencies: 269
-- Name: approval_id_seq; Type: SEQUENCE SET; Schema: Peturova; Owner: -
--

SELECT pg_catalog.setval('"Peturova".approval_id_seq', 30, true);


--
-- TOC entry 3976 (class 0 OID 0)
-- Dependencies: 257
-- Name: department_id_seq; Type: SEQUENCE SET; Schema: Peturova; Owner: -
--

SELECT pg_catalog.setval('"Peturova".department_id_seq', 48, true);


--
-- TOC entry 3977 (class 0 OID 0)
-- Dependencies: 265
-- Name: document_id_seq; Type: SEQUENCE SET; Schema: Peturova; Owner: -
--

SELECT pg_catalog.setval('"Peturova".document_id_seq', 32, true);


--
-- TOC entry 3978 (class 0 OID 0)
-- Dependencies: 267
-- Name: documentflow_id_seq; Type: SEQUENCE SET; Schema: Peturova; Owner: -
--

SELECT pg_catalog.setval('"Peturova".documentflow_id_seq', 38, true);


--
-- TOC entry 3979 (class 0 OID 0)
-- Dependencies: 263
-- Name: dstatus_id_seq; Type: SEQUENCE SET; Schema: Peturova; Owner: -
--

SELECT pg_catalog.setval('"Peturova".dstatus_id_seq', 60, true);


--
-- TOC entry 3980 (class 0 OID 0)
-- Dependencies: 261
-- Name: dtype_id_seq; Type: SEQUENCE SET; Schema: Peturova; Owner: -
--

SELECT pg_catalog.setval('"Peturova".dtype_id_seq', 40, true);


--
-- TOC entry 3981 (class 0 OID 0)
-- Dependencies: 259
-- Name: employee_id_seq; Type: SEQUENCE SET; Schema: Peturova; Owner: -
--

SELECT pg_catalog.setval('"Peturova".employee_id_seq', 57, true);


--
-- TOC entry 3982 (class 0 OID 0)
-- Dependencies: 255
-- Name: role_id_seq; Type: SEQUENCE SET; Schema: Peturova; Owner: -
--

SELECT pg_catalog.setval('"Peturova".role_id_seq', 54, true);


--
-- TOC entry 3791 (class 2606 OID 25817)
-- Name: approval approval_pkey; Type: CONSTRAINT; Schema: Peturova; Owner: -
--

ALTER TABLE ONLY "Peturova".approval
    ADD CONSTRAINT approval_pkey PRIMARY KEY (id);


--
-- TOC entry 3779 (class 2606 OID 25728)
-- Name: department department_pkey; Type: CONSTRAINT; Schema: Peturova; Owner: -
--

ALTER TABLE ONLY "Peturova".department
    ADD CONSTRAINT department_pkey PRIMARY KEY (id);


--
-- TOC entry 3787 (class 2606 OID 25772)
-- Name: document document_pkey; Type: CONSTRAINT; Schema: Peturova; Owner: -
--

ALTER TABLE ONLY "Peturova".document
    ADD CONSTRAINT document_pkey PRIMARY KEY (id);


--
-- TOC entry 3789 (class 2606 OID 25795)
-- Name: documentflow documentflow_pkey; Type: CONSTRAINT; Schema: Peturova; Owner: -
--

ALTER TABLE ONLY "Peturova".documentflow
    ADD CONSTRAINT documentflow_pkey PRIMARY KEY (id);


--
-- TOC entry 3785 (class 2606 OID 25764)
-- Name: dstatus dstatus_pkey; Type: CONSTRAINT; Schema: Peturova; Owner: -
--

ALTER TABLE ONLY "Peturova".dstatus
    ADD CONSTRAINT dstatus_pkey PRIMARY KEY (id);


--
-- TOC entry 3783 (class 2606 OID 25757)
-- Name: dtype dtype_pkey; Type: CONSTRAINT; Schema: Peturova; Owner: -
--

ALTER TABLE ONLY "Peturova".dtype
    ADD CONSTRAINT dtype_pkey PRIMARY KEY (id);


--
-- TOC entry 3781 (class 2606 OID 25735)
-- Name: employee employee_pkey; Type: CONSTRAINT; Schema: Peturova; Owner: -
--

ALTER TABLE ONLY "Peturova".employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (id);


--
-- TOC entry 3777 (class 2606 OID 25721)
-- Name: role role_pkey; Type: CONSTRAINT; Schema: Peturova; Owner: -
--

ALTER TABLE ONLY "Peturova".role
    ADD CONSTRAINT role_pkey PRIMARY KEY (id);


--
-- TOC entry 3801 (class 2606 OID 25818)
-- Name: approval approval_document_id_fkey; Type: FK CONSTRAINT; Schema: Peturova; Owner: -
--

ALTER TABLE ONLY "Peturova".approval
    ADD CONSTRAINT approval_document_id_fkey FOREIGN KEY (document_id) REFERENCES "Peturova".document(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3802 (class 2606 OID 25823)
-- Name: approval approval_employee_id_fkey; Type: FK CONSTRAINT; Schema: Peturova; Owner: -
--

ALTER TABLE ONLY "Peturova".approval
    ADD CONSTRAINT approval_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES "Peturova".employee(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 3795 (class 2606 OID 25783)
-- Name: document document_author_id_fkey; Type: FK CONSTRAINT; Schema: Peturova; Owner: -
--

ALTER TABLE ONLY "Peturova".document
    ADD CONSTRAINT document_author_id_fkey FOREIGN KEY (author_id) REFERENCES "Peturova".employee(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 3796 (class 2606 OID 25778)
-- Name: document document_status_id_fkey; Type: FK CONSTRAINT; Schema: Peturova; Owner: -
--

ALTER TABLE ONLY "Peturova".document
    ADD CONSTRAINT document_status_id_fkey FOREIGN KEY (status_id) REFERENCES "Peturova".dstatus(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 3797 (class 2606 OID 25773)
-- Name: document document_type_id_fkey; Type: FK CONSTRAINT; Schema: Peturova; Owner: -
--

ALTER TABLE ONLY "Peturova".document
    ADD CONSTRAINT document_type_id_fkey FOREIGN KEY (type_id) REFERENCES "Peturova".dtype(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 3798 (class 2606 OID 25796)
-- Name: documentflow documentflow_document_id_fkey; Type: FK CONSTRAINT; Schema: Peturova; Owner: -
--

ALTER TABLE ONLY "Peturova".documentflow
    ADD CONSTRAINT documentflow_document_id_fkey FOREIGN KEY (document_id) REFERENCES "Peturova".document(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3799 (class 2606 OID 25806)
-- Name: documentflow documentflow_receiver_id_fkey; Type: FK CONSTRAINT; Schema: Peturova; Owner: -
--

ALTER TABLE ONLY "Peturova".documentflow
    ADD CONSTRAINT documentflow_receiver_id_fkey FOREIGN KEY (receiver_id) REFERENCES "Peturova".employee(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 3800 (class 2606 OID 25801)
-- Name: documentflow documentflow_sender_id_fkey; Type: FK CONSTRAINT; Schema: Peturova; Owner: -
--

ALTER TABLE ONLY "Peturova".documentflow
    ADD CONSTRAINT documentflow_sender_id_fkey FOREIGN KEY (sender_id) REFERENCES "Peturova".employee(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 3793 (class 2606 OID 25741)
-- Name: employee employee_department_id_fkey; Type: FK CONSTRAINT; Schema: Peturova; Owner: -
--

ALTER TABLE ONLY "Peturova".employee
    ADD CONSTRAINT employee_department_id_fkey FOREIGN KEY (department_id) REFERENCES "Peturova".department(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 3794 (class 2606 OID 25736)
-- Name: employee employee_role_id_fkey; Type: FK CONSTRAINT; Schema: Peturova; Owner: -
--

ALTER TABLE ONLY "Peturova".employee
    ADD CONSTRAINT employee_role_id_fkey FOREIGN KEY (role_id) REFERENCES "Peturova".role(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 3792 (class 2606 OID 25746)
-- Name: department fk_department_head; Type: FK CONSTRAINT; Schema: Peturova; Owner: -
--

ALTER TABLE ONLY "Peturova".department
    ADD CONSTRAINT fk_department_head FOREIGN KEY (head_id) REFERENCES "Peturova".employee(id) ON UPDATE CASCADE ON DELETE SET NULL;


-- Completed on 2025-12-03 17:06:36

--
-- PostgreSQL database dump complete
--

