--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.4
-- Dumped by pg_dump version 9.5.4

-- Started on 2016-11-02 16:20:03 EET

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET search_path = public, pg_catalog;

--
-- TOC entry 2527 (class 0 OID 17039)
-- Dependencies: 181
-- Data for Name: k_admin_group; Type: TABLE DATA; Schema: public; Owner: volodymyrmordas
--

COPY k_admin_group (id, name, description, created_at, updated_at) FROM stdin;
1	admin	User Group	2016-11-02 15:27:28.585603	2016-11-02 15:27:28.585603
\.


--
-- TOC entry 2528 (class 0 OID 17044)
-- Dependencies: 182
-- Data for Name: k_admin_user; Type: TABLE DATA; Schema: public; Owner: volodymyrmordas
--

COPY k_admin_user (id, first_name, last_name, email, password, created_at, updated_at) FROM stdin;
1	Volodymyr	Mordas	admin@admin.com	8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918	2016-11-02 15:20:20.368059	2016-11-02 15:20:20.368059
\.


--
-- TOC entry 2530 (class 0 OID 17051)
-- Dependencies: 184
-- Data for Name: k_admin_user_group; Type: TABLE DATA; Schema: public; Owner: volodymyrmordas
--

COPY k_admin_user_group (admin_user_id, admin_group_id) FROM stdin;
1	1
\.


--
-- TOC entry 2559 (class 0 OID 0)
-- Dependencies: 183
-- Name: k_admin_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: volodymyrmordas
--

SELECT pg_catalog.setval('k_admin_user_id_seq', 1, true);


--
-- TOC entry 2543 (class 0 OID 17102)
-- Dependencies: 197
-- Data for Name: k_building; Type: TABLE DATA; Schema: public; Owner: volodymyrmordas
--

COPY k_building (id, title, lat, lng, type, status, created_at, updated_at, description) FROM stdin;
1	Odessa SmartHotel	46.4496854987	30.7589721680	2	1	2016-11-02 15:53:19.68	2016-11-02 15:53:19.68	My Odessa SmartHotel
\.


--
-- TOC entry 2531 (class 0 OID 17054)
-- Dependencies: 185
-- Data for Name: k_apartment; Type: TABLE DATA; Schema: public; Owner: volodymyrmordas
--

COPY k_apartment (id, building_id, title, type, status, created_at, updated_at, description, number) FROM stdin;
1	1	Apartment 1	3	2	2016-11-02 15:53:42.767	2016-11-02 15:53:42.767	room 1	1
\.


--
-- TOC entry 2560 (class 0 OID 0)
-- Dependencies: 186
-- Name: k_apartment_building_id_seq; Type: SEQUENCE SET; Schema: public; Owner: volodymyrmordas
--

SELECT pg_catalog.setval('k_apartment_building_id_seq', 1, false);


--
-- TOC entry 2561 (class 0 OID 0)
-- Dependencies: 187
-- Name: k_apartment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: volodymyrmordas
--

SELECT pg_catalog.setval('k_apartment_id_seq', 1, true);


--
-- TOC entry 2534 (class 0 OID 17065)
-- Dependencies: 188
-- Data for Name: k_apartment_media; Type: TABLE DATA; Schema: public; Owner: volodymyrmordas
--

COPY k_apartment_media (id, apartment_id, filename, type, status, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 2562 (class 0 OID 0)
-- Dependencies: 189
-- Name: k_apartment_media_apartment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: volodymyrmordas
--

SELECT pg_catalog.setval('k_apartment_media_apartment_id_seq', 1, false);


--
-- TOC entry 2563 (class 0 OID 0)
-- Dependencies: 190
-- Name: k_apartment_media_id_seq; Type: SEQUENCE SET; Schema: public; Owner: volodymyrmordas
--

SELECT pg_catalog.setval('k_apartment_media_id_seq', 1, false);


--
-- TOC entry 2537 (class 0 OID 17076)
-- Dependencies: 191
-- Data for Name: k_apartment_price; Type: TABLE DATA; Schema: public; Owner: volodymyrmordas
--

COPY k_apartment_price (id, apartment_id, price, start_at, type, status, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 2564 (class 0 OID 0)
-- Dependencies: 192
-- Name: k_apartment_price_apartment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: volodymyrmordas
--

SELECT pg_catalog.setval('k_apartment_price_apartment_id_seq', 1, false);


--
-- TOC entry 2565 (class 0 OID 0)
-- Dependencies: 193
-- Name: k_apartment_price_id_seq; Type: SEQUENCE SET; Schema: public; Owner: volodymyrmordas
--

SELECT pg_catalog.setval('k_apartment_price_id_seq', 1, false);


--
-- TOC entry 2550 (class 0 OID 17129)
-- Dependencies: 204
-- Data for Name: k_user; Type: TABLE DATA; Schema: public; Owner: volodymyrmordas
--

COPY k_user (id, first_name, last_name, phone, email, type, status, created_at, updated_at, phone_verified, email_verified) FROM stdin;
1	Volodymyr	Mordas	+380979750753	volodymyrmordas@gmail.com	1	1	2016-11-02 15:58:56.590202	2016-11-02 16:14:58.204	t	t
\.


--
-- TOC entry 2545 (class 0 OID 17114)
-- Dependencies: 199
-- Data for Name: k_order; Type: TABLE DATA; Schema: public; Owner: volodymyrmordas
--

COPY k_order (id, building_id, apartment_id, title, start_at, end_at, type, status, created_at, updated_at, user_id) FROM stdin;
\.


--
-- TOC entry 2540 (class 0 OID 17088)
-- Dependencies: 194
-- Data for Name: k_billing; Type: TABLE DATA; Schema: public; Owner: volodymyrmordas
--

COPY k_billing (id, order_id, amount, currency_code, created_at, updated_at, payment_date) FROM stdin;
\.


--
-- TOC entry 2566 (class 0 OID 0)
-- Dependencies: 195
-- Name: k_billing_id_seq; Type: SEQUENCE SET; Schema: public; Owner: volodymyrmordas
--

SELECT pg_catalog.setval('k_billing_id_seq', 1, false);


--
-- TOC entry 2567 (class 0 OID 0)
-- Dependencies: 196
-- Name: k_billing_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: volodymyrmordas
--

SELECT pg_catalog.setval('k_billing_order_id_seq', 1, false);


--
-- TOC entry 2568 (class 0 OID 0)
-- Dependencies: 198
-- Name: k_building_id_seq; Type: SEQUENCE SET; Schema: public; Owner: volodymyrmordas
--

SELECT pg_catalog.setval('k_building_id_seq', 1, true);


--
-- TOC entry 2569 (class 0 OID 0)
-- Dependencies: 200
-- Name: k_order_apartment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: volodymyrmordas
--

SELECT pg_catalog.setval('k_order_apartment_id_seq', 1, false);


--
-- TOC entry 2570 (class 0 OID 0)
-- Dependencies: 201
-- Name: k_order_building_id_seq; Type: SEQUENCE SET; Schema: public; Owner: volodymyrmordas
--

SELECT pg_catalog.setval('k_order_building_id_seq', 1, false);


--
-- TOC entry 2571 (class 0 OID 0)
-- Dependencies: 202
-- Name: k_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: volodymyrmordas
--

SELECT pg_catalog.setval('k_order_id_seq', 1, false);


--
-- TOC entry 2572 (class 0 OID 0)
-- Dependencies: 203
-- Name: k_order_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: volodymyrmordas
--

SELECT pg_catalog.setval('k_order_user_id_seq', 1, false);


--
-- TOC entry 2573 (class 0 OID 0)
-- Dependencies: 205
-- Name: k_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: volodymyrmordas
--

SELECT pg_catalog.setval('k_user_id_seq', 1, true);


--
-- TOC entry 2552 (class 0 OID 17140)
-- Dependencies: 206
-- Data for Name: k_verification; Type: TABLE DATA; Schema: public; Owner: volodymyrmordas
--

COPY k_verification (id, code, user_id, created_at, type) FROM stdin;
\.


--
-- TOC entry 2574 (class 0 OID 0)
-- Dependencies: 207
-- Name: k_verification_id_seq; Type: SEQUENCE SET; Schema: public; Owner: volodymyrmordas
--

SELECT pg_catalog.setval('k_verification_id_seq', 4, true);


--
-- TOC entry 2575 (class 0 OID 0)
-- Dependencies: 208
-- Name: k_verification_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: volodymyrmordas
--

SELECT pg_catalog.setval('k_verification_user_id_seq', 1, false);


-- Completed on 2016-11-02 16:20:03 EET

--
-- PostgreSQL database dump complete
--

