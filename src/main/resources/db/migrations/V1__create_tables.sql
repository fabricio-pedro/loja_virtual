

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET SESSION AUTHORIZATION 'admin';
--DROP DATABASE IF EXISTS lojadb;
--
-- TOC entry 3571 (class 1262 OID 16384)
-- Name: lojadb; Type: DATABASE; Schema: -; Owner: admin
--

--CREATE DATABASE lojadb WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


--\connect lojadb

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--SET SESSION AUTHORIZATION 'pg_database_owner';

--
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

--CREATE SCHEMA public;


--
-- TOC entry 3572 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET SESSION AUTHORIZATION 'admin';

--
-- TOC entry 254 (class 1255 OID 16849)
-- Name: validachavepessoa(); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION public.validachavepessoa() RETURNS trigger
    LANGUAGE plpgsql
    AS '

  declare existe integer;

  begin 
    existe = (select count(1) from pessoa_fisica where id = NEW.pessoa_id);
    if(existe <=0 ) then 
     existe = (select count(1) from pessoa_juridica where id = NEW.pessoa_id);
    if (existe <= 0) then
      raise exception ''Não foi encontrado o ID ou PK da pessoa para realizar a associação'';
     end if;
    end if;
    RETURN NEW;
  end;
  ';


--
-- TOC entry 266 (class 1255 OID 16850)
-- Name: validachavepessoa2(); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION public.validachavepessoa2() RETURNS trigger
    LANGUAGE plpgsql
    AS '

  declare existe integer;

  begin 
    existe = (select count(1) from pessoa_fisica where id = NEW.pessoa_forn_id);
    if(existe <=0 ) then 
     existe = (select count(1) from pessoa_juridica where id = NEW.pessoa_forn_id);
    if (existe <= 0) then
      raise exception ''Não foi encontrado o ID ou PK da pessoa para realizar a associação'';
     end if;
    end if;
    RETURN NEW;
  end;
  ';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 215 (class 1259 OID 16385)
-- Name: acesso; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.acesso (
    id bigint NOT NULL,
    descricao character varying(255) NOT NULL
);


--
-- TOC entry 224 (class 1259 OID 16521)
-- Name: acesso_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.acesso_seq
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 216 (class 1259 OID 16390)
-- Name: avaliacao_produto; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.avaliacao_produto (
    id bigint NOT NULL,
    descricao character varying(255) NOT NULL,
    nota integer NOT NULL,
    pessoa_id bigint NOT NULL,
    produto_id bigint NOT NULL
);


--
-- TOC entry 217 (class 1259 OID 16395)
-- Name: categoria_produto; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.categoria_produto (
    id bigint NOT NULL,
    nome_desc character varying(255) NOT NULL
);


--
-- TOC entry 218 (class 1259 OID 16400)
-- Name: conta_pagar; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.conta_pagar (
    id bigint NOT NULL,
    descricao character varying(255) NOT NULL,
    dt_pagamento date,
    dt_vencimento date NOT NULL,
    status character varying(255) NOT NULL,
    valor_desconto numeric(38,2),
    valor_total numeric(38,2) NOT NULL,
    pessoa_id bigint NOT NULL,
    pessoa_forn_id bigint NOT NULL,
    CONSTRAINT conta_pagar_status_check CHECK (((status)::text = ANY ((ARRAY['COBRANCA'::character varying, 'VENCIDA'::character varying, 'ABERTA'::character varying, 'QUITADA'::character varying, 'RENEGOCIADA'::character varying])::text[])))
);


--
-- TOC entry 219 (class 1259 OID 16408)
-- Name: conta_receber; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.conta_receber (
    id bigint NOT NULL,
    descricao character varying(255) NOT NULL,
    dt_pagamento date,
    dt_vencimento date NOT NULL,
    status character varying(255) NOT NULL,
    valor_desconto numeric(38,2),
    valor_total numeric(38,2) NOT NULL,
    pessoa_id bigint NOT NULL,
    CONSTRAINT conta_receber_status_check CHECK (((status)::text = ANY ((ARRAY['COBRANCA'::character varying, 'VENCIDA'::character varying, 'ABERTA'::character varying, 'QUITADA'::character varying, 'RENEGOCIADA'::character varying])::text[])))
);


--
-- TOC entry 220 (class 1259 OID 16416)
-- Name: cup_desconto; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.cup_desconto (
    id bigint NOT NULL,
    cod_desc character varying(255) NOT NULL,
    data_validade date,
    valor_porc_desc numeric(38,2),
    valor_real_desc numeric(38,2)
);


--
-- TOC entry 242 (class 1259 OID 16619)
-- Name: endereco; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.endereco (
    id bigint NOT NULL,
    bairro character varying(255) NOT NULL,
    cep character varying(255) NOT NULL,
    cidade character varying(255) NOT NULL,
    complemento character varying(255),
    numero character varying(255) NOT NULL,
    rua_logra character varying(255) NOT NULL,
    tipo_endereco character varying(255) NOT NULL,
    uf character varying(255) NOT NULL,
    pessoa_id bigint NOT NULL,
    CONSTRAINT endereco_tipo_endereco_check CHECK (((tipo_endereco)::text = ANY ((ARRAY['COBRANCA'::character varying, 'ENTREGA'::character varying])::text[])))
);


--
-- TOC entry 243 (class 1259 OID 16637)
-- Name: forma_pagamento; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.forma_pagamento (
    id bigint NOT NULL,
    descricao character varying(255) NOT NULL
);


--
-- TOC entry 244 (class 1259 OID 16647)
-- Name: imagem_produto; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.imagem_produto (
    id bigint NOT NULL,
    imagem_miniatura text NOT NULL,
    imagem_original text NOT NULL,
    produto_id bigint NOT NULL
);


--
-- TOC entry 245 (class 1259 OID 16659)
-- Name: item_venda_loja; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.item_venda_loja (
    id bigint NOT NULL,
    quantidade double precision NOT NULL,
    produto_id bigint NOT NULL,
    venda_compra_loja_virtual_id bigint NOT NULL
);


--
-- TOC entry 221 (class 1259 OID 16446)
-- Name: marca_produto; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.marca_produto (
    id bigint NOT NULL,
    nome_desc character varying(255) NOT NULL
);


--
-- TOC entry 225 (class 1259 OID 16522)
-- Name: marca_produto_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.marca_produto_seq
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 246 (class 1259 OID 16674)
-- Name: nota_fiscal_compra; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.nota_fiscal_compra (
    id bigint NOT NULL,
    data_compra date NOT NULL,
    descricao_obs character varying(255),
    numero_nota character varying(255) NOT NULL,
    serie_nota character varying(255) NOT NULL,
    valor_desconto numeric(38,2),
    valor_icms numeric(38,2) NOT NULL,
    valor_total numeric(38,2) NOT NULL,
    conta_pagar_id bigint NOT NULL,
    pessoa_id bigint NOT NULL
);


--
-- TOC entry 247 (class 1259 OID 16708)
-- Name: nota_fiscal_venda; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.nota_fiscal_venda (
    id bigint NOT NULL,
    numero character varying(255) NOT NULL,
    pdf text NOT NULL,
    serie character varying(255) NOT NULL,
    tipo character varying(255) NOT NULL,
    xml text NOT NULL
);


--
-- TOC entry 248 (class 1259 OID 16735)
-- Name: nota_item_produto; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.nota_item_produto (
    id bigint NOT NULL,
    quantidade double precision NOT NULL,
    nota_fiscal_compra_id bigint NOT NULL,
    produto_id bigint NOT NULL
);


--
-- TOC entry 249 (class 1259 OID 16750)
-- Name: pessoa_fisica; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.pessoa_fisica (
    id bigint NOT NULL,
    email character varying(255) NOT NULL,
    nome character varying(255) NOT NULL,
    telefone character varying(255) NOT NULL,
    cpf character varying(255) NOT NULL,
    data_nascimento date
);


--
-- TOC entry 250 (class 1259 OID 16757)
-- Name: pessoa_juridica; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.pessoa_juridica (
    id bigint NOT NULL,
    email character varying(255) NOT NULL,
    nome character varying(255) NOT NULL,
    telefone character varying(255) NOT NULL,
    categoria character varying(255),
    cnpj character varying(255) NOT NULL,
    insc_estadual character varying(255) NOT NULL,
    insc_municipal character varying(255),
    nome_fantasia character varying(255) NOT NULL,
    razao_social character varying(255) NOT NULL
);


--
-- TOC entry 251 (class 1259 OID 16765)
-- Name: produto; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.produto (
    id bigint NOT NULL,
    alerta_estoque boolean,
    altura double precision NOT NULL,
    ativo boolean NOT NULL,
    descricao text NOT NULL,
    link_youtube character varying(255),
    nome character varying(255) NOT NULL,
    peso double precision NOT NULL,
    profundidade double precision NOT NULL,
    qtd_alerta_estoque integer,
    qtd_clicks integer,
    qtd_estoque integer NOT NULL,
    tipo_unidade character varying(255) NOT NULL,
    valor_venda numeric(38,2) NOT NULL
);


--
-- TOC entry 226 (class 1259 OID 16523)
-- Name: seq_avaliacao_produto; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_avaliacao_produto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 227 (class 1259 OID 16524)
-- Name: seq_categoria_produto; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_categoria_produto
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 228 (class 1259 OID 16525)
-- Name: seq_conta_pagar; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_conta_pagar
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 229 (class 1259 OID 16526)
-- Name: seq_conta_receber; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_conta_receber
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 230 (class 1259 OID 16527)
-- Name: seq_cup_desconto; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_cup_desconto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 231 (class 1259 OID 16528)
-- Name: seq_endereco; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_endereco
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 232 (class 1259 OID 16529)
-- Name: seq_imagem_produto; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_imagem_produto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 233 (class 1259 OID 16530)
-- Name: seq_item_venda_loja; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_item_venda_loja
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 234 (class 1259 OID 16531)
-- Name: seq_nota_fical_vend; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_nota_fical_vend
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 235 (class 1259 OID 16532)
-- Name: seq_nota_fiscal_compra; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_nota_fiscal_compra
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 236 (class 1259 OID 16533)
-- Name: seq_nota_item_produto; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_nota_item_produto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 237 (class 1259 OID 16534)
-- Name: seq_pessoa; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_pessoa
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 238 (class 1259 OID 16535)
-- Name: seq_produto; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_produto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 239 (class 1259 OID 16536)
-- Name: seq_status_rastreio; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_status_rastreio
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 240 (class 1259 OID 16537)
-- Name: seq_usuario; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_usuario
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 241 (class 1259 OID 16538)
-- Name: seq_venda_compra_loja_virtual; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_venda_compra_loja_virtual
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 222 (class 1259 OID 16491)
-- Name: status_rastreio; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.status_rastreio (
    id bigint NOT NULL,
    centro_distribuicao character varying(255),
    cidade character varying(255),
    estado character varying(255),
    status character varying(255),
    venda_compra_loja_virtual_id bigint NOT NULL
);


--
-- TOC entry 252 (class 1259 OID 16792)
-- Name: usuario; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.usuario (
    id bigint NOT NULL,
    data_atual_senha date NOT NULL,
    login character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    pessoa_id bigint NOT NULL
);


--
-- TOC entry 223 (class 1259 OID 16505)
-- Name: usuarios_acesso; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.usuarios_acesso (
    usuario_id bigint NOT NULL,
    acesso_id bigint NOT NULL
);


--
-- TOC entry 253 (class 1259 OID 16804)
-- Name: venda_compra_loja_virtual; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.venda_compra_loja_virtual (
    id bigint NOT NULL,
    data_entrega date NOT NULL,
    data_venda date NOT NULL,
    dia_entrega integer NOT NULL,
    valor_desconto numeric(38,2),
    valor_frete numeric(38,2) NOT NULL,
    valor_total numeric(38,2) NOT NULL,
    cup_desconto_id bigint,
    endereco_cobranca_id bigint NOT NULL,
    endereco_entrega_id bigint NOT NULL,
    forma_pagamento_id bigint NOT NULL,
    nota_fiscal_venda_id bigint NOT NULL,
    pessoa_id bigint NOT NULL
);


--
-- TOC entry 3527 (class 0 OID 16385)
-- Dependencies: 215
-- Data for Name: acesso; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 3528 (class 0 OID 16390)
-- Dependencies: 216
-- Data for Name: avaliacao_produto; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.avaliacao_produto VALUES (1, 'avalicao2', 5, 1, 1) ON CONFLICT DO NOTHING;


--
-- TOC entry 3529 (class 0 OID 16395)
-- Dependencies: 217
-- Data for Name: categoria_produto; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 3530 (class 0 OID 16400)
-- Dependencies: 218
-- Data for Name: conta_pagar; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 3531 (class 0 OID 16408)
-- Dependencies: 219
-- Data for Name: conta_receber; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 3532 (class 0 OID 16416)
-- Dependencies: 220
-- Data for Name: cup_desconto; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 3554 (class 0 OID 16619)
-- Dependencies: 242
-- Data for Name: endereco; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 3555 (class 0 OID 16637)
-- Dependencies: 243
-- Data for Name: forma_pagamento; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 3556 (class 0 OID 16647)
-- Dependencies: 244
-- Data for Name: imagem_produto; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 3557 (class 0 OID 16659)
-- Dependencies: 245
-- Data for Name: item_venda_loja; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 3533 (class 0 OID 16446)
-- Dependencies: 221
-- Data for Name: marca_produto; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 3558 (class 0 OID 16674)
-- Dependencies: 246
-- Data for Name: nota_fiscal_compra; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 3559 (class 0 OID 16708)
-- Dependencies: 247
-- Data for Name: nota_fiscal_venda; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 3560 (class 0 OID 16735)
-- Dependencies: 248
-- Data for Name: nota_item_produto; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 3561 (class 0 OID 16750)
-- Dependencies: 249
-- Data for Name: pessoa_fisica; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.pessoa_fisica VALUES (1, 'NOMES@GMAIL.COM', 'JOAO', '5555555555', '9999999', '2024-07-14') ON CONFLICT DO NOTHING;


--
-- TOC entry 3562 (class 0 OID 16757)
-- Dependencies: 250
-- Data for Name: pessoa_juridica; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 3563 (class 0 OID 16765)
-- Dependencies: 251
-- Data for Name: produto; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.produto VALUES (1, true, 2, true, 'um produto de teste', 'www.teste.com.br', 'Xproduto', 1, 10, 5, 10, 20, 'kg', 15.00) ON CONFLICT DO NOTHING;


--
-- TOC entry 3534 (class 0 OID 16491)
-- Dependencies: 222
-- Data for Name: status_rastreio; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 3564 (class 0 OID 16792)
-- Dependencies: 252
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 3535 (class 0 OID 16505)
-- Dependencies: 223
-- Data for Name: usuarios_acesso; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 3565 (class 0 OID 16804)
-- Dependencies: 253
-- Data for Name: venda_compra_loja_virtual; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- TOC entry 3573 (class 0 OID 0)
-- Dependencies: 224
-- Name: acesso_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.acesso_seq', 1, false);


--
-- TOC entry 3574 (class 0 OID 0)
-- Dependencies: 225
-- Name: marca_produto_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.marca_produto_seq', 1, false);


--
-- TOC entry 3575 (class 0 OID 0)
-- Dependencies: 226
-- Name: seq_avaliacao_produto; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_avaliacao_produto', 1, false);


--
-- TOC entry 3576 (class 0 OID 0)
-- Dependencies: 227
-- Name: seq_categoria_produto; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_categoria_produto', 1, false);


--
-- TOC entry 3577 (class 0 OID 0)
-- Dependencies: 228
-- Name: seq_conta_pagar; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_conta_pagar', 1, false);


--
-- TOC entry 3578 (class 0 OID 0)
-- Dependencies: 229
-- Name: seq_conta_receber; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_conta_receber', 1, false);


--
-- TOC entry 3579 (class 0 OID 0)
-- Dependencies: 230
-- Name: seq_cup_desconto; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_cup_desconto', 1, false);


--
-- TOC entry 3580 (class 0 OID 0)
-- Dependencies: 231
-- Name: seq_endereco; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_endereco', 1, false);


--
-- TOC entry 3581 (class 0 OID 0)
-- Dependencies: 232
-- Name: seq_imagem_produto; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_imagem_produto', 1, false);


--
-- TOC entry 3582 (class 0 OID 0)
-- Dependencies: 233
-- Name: seq_item_venda_loja; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_item_venda_loja', 1, false);


--
-- TOC entry 3583 (class 0 OID 0)
-- Dependencies: 234
-- Name: seq_nota_fical_vend; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_nota_fical_vend', 1, false);


--
-- TOC entry 3584 (class 0 OID 0)
-- Dependencies: 235
-- Name: seq_nota_fiscal_compra; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_nota_fiscal_compra', 1, false);


--
-- TOC entry 3585 (class 0 OID 0)
-- Dependencies: 236
-- Name: seq_nota_item_produto; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_nota_item_produto', 1, false);


--
-- TOC entry 3586 (class 0 OID 0)
-- Dependencies: 237
-- Name: seq_pessoa; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_pessoa', 1, false);


--
-- TOC entry 3587 (class 0 OID 0)
-- Dependencies: 238
-- Name: seq_produto; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_produto', 1, false);


--
-- TOC entry 3588 (class 0 OID 0)
-- Dependencies: 239
-- Name: seq_status_rastreio; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_status_rastreio', 1, false);


--
-- TOC entry 3589 (class 0 OID 0)
-- Dependencies: 240
-- Name: seq_usuario; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_usuario', 1, false);


--
-- TOC entry 3590 (class 0 OID 0)
-- Dependencies: 241
-- Name: seq_venda_compra_loja_virtual; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_venda_compra_loja_virtual', 1, false);


--
-- TOC entry 3306 (class 2606 OID 16389)
-- Name: acesso acesso_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.acesso
    ADD CONSTRAINT acesso_pkey PRIMARY KEY (id);


--
-- TOC entry 3308 (class 2606 OID 16394)
-- Name: avaliacao_produto avaliacao_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.avaliacao_produto
    ADD CONSTRAINT avaliacao_produto_pkey PRIMARY KEY (id);


--
-- TOC entry 3310 (class 2606 OID 16399)
-- Name: categoria_produto categoria_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.categoria_produto
    ADD CONSTRAINT categoria_produto_pkey PRIMARY KEY (id);


--
-- TOC entry 3312 (class 2606 OID 16407)
-- Name: conta_pagar conta_pagar_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.conta_pagar
    ADD CONSTRAINT conta_pagar_pkey PRIMARY KEY (id);


--
-- TOC entry 3314 (class 2606 OID 16415)
-- Name: conta_receber conta_receber_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.conta_receber
    ADD CONSTRAINT conta_receber_pkey PRIMARY KEY (id);


--
-- TOC entry 3316 (class 2606 OID 16420)
-- Name: cup_desconto cup_desconto_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.cup_desconto
    ADD CONSTRAINT cup_desconto_pkey PRIMARY KEY (id);


--
-- TOC entry 3326 (class 2606 OID 16626)
-- Name: endereco endereco_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.endereco
    ADD CONSTRAINT endereco_pkey PRIMARY KEY (id);


--
-- TOC entry 3328 (class 2606 OID 16641)
-- Name: forma_pagamento forma_pagamento_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.forma_pagamento
    ADD CONSTRAINT forma_pagamento_pkey PRIMARY KEY (id);


--
-- TOC entry 3330 (class 2606 OID 16653)
-- Name: imagem_produto imagem_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.imagem_produto
    ADD CONSTRAINT imagem_produto_pkey PRIMARY KEY (id);


--
-- TOC entry 3332 (class 2606 OID 16663)
-- Name: item_venda_loja item_venda_loja_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.item_venda_loja
    ADD CONSTRAINT item_venda_loja_pkey PRIMARY KEY (id);


--
-- TOC entry 3318 (class 2606 OID 16450)
-- Name: marca_produto marca_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.marca_produto
    ADD CONSTRAINT marca_produto_pkey PRIMARY KEY (id);


--
-- TOC entry 3334 (class 2606 OID 16680)
-- Name: nota_fiscal_compra nota_fiscal_compra_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.nota_fiscal_compra
    ADD CONSTRAINT nota_fiscal_compra_pkey PRIMARY KEY (id);


--
-- TOC entry 3338 (class 2606 OID 16714)
-- Name: nota_fiscal_venda nota_fiscal_venda_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.nota_fiscal_venda
    ADD CONSTRAINT nota_fiscal_venda_pkey PRIMARY KEY (id);


--
-- TOC entry 3340 (class 2606 OID 16739)
-- Name: nota_item_produto nota_item_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.nota_item_produto
    ADD CONSTRAINT nota_item_produto_pkey PRIMARY KEY (id);


--
-- TOC entry 3342 (class 2606 OID 16756)
-- Name: pessoa_fisica pessoa_fisica_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.pessoa_fisica
    ADD CONSTRAINT pessoa_fisica_pkey PRIMARY KEY (id);


--
-- TOC entry 3344 (class 2606 OID 16763)
-- Name: pessoa_juridica pessoa_juridica_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.pessoa_juridica
    ADD CONSTRAINT pessoa_juridica_pkey PRIMARY KEY (id);


--
-- TOC entry 3346 (class 2606 OID 16771)
-- Name: produto produto_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.produto
    ADD CONSTRAINT produto_pkey PRIMARY KEY (id);


--
-- TOC entry 3320 (class 2606 OID 16497)
-- Name: status_rastreio status_rastreio_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.status_rastreio
    ADD CONSTRAINT status_rastreio_pkey PRIMARY KEY (id);


--
-- TOC entry 3336 (class 2606 OID 16682)
-- Name: nota_fiscal_compra uk_5t4np5rpqhk9809fgd2jvlf0l; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.nota_fiscal_compra
    ADD CONSTRAINT uk_5t4np5rpqhk9809fgd2jvlf0l UNIQUE (conta_pagar_id);


--
-- TOC entry 3322 (class 2606 OID 16518)
-- Name: usuarios_acesso uk_8bak9jswon2id2jbunuqlfl9e; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.usuarios_acesso
    ADD CONSTRAINT uk_8bak9jswon2id2jbunuqlfl9e UNIQUE (acesso_id);


--
-- TOC entry 3350 (class 2606 OID 16810)
-- Name: venda_compra_loja_virtual uk_c30agr0qfwruqaoymp4chk2h1; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.venda_compra_loja_virtual
    ADD CONSTRAINT uk_c30agr0qfwruqaoymp4chk2h1 UNIQUE (nota_fiscal_venda_id);


--
-- TOC entry 3324 (class 2606 OID 16516)
-- Name: usuarios_acesso unique_acesso_usuario; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.usuarios_acesso
    ADD CONSTRAINT unique_acesso_usuario UNIQUE (usuario_id, acesso_id);


--
-- TOC entry 3348 (class 2606 OID 16798)
-- Name: usuario usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id);


--
-- TOC entry 3352 (class 2606 OID 16808)
-- Name: venda_compra_loja_virtual venda_compra_loja_virtual_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.venda_compra_loja_virtual
    ADD CONSTRAINT venda_compra_loja_virtual_pkey PRIMARY KEY (id);


--
-- TOC entry 3370 (class 2620 OID 16857)
-- Name: conta_pagar validachavecontapagar; Type: TRIGGER; Schema: public; Owner: admin
--

CREATE TRIGGER validachavecontapagar BEFORE UPDATE ON public.conta_pagar FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 3371 (class 2620 OID 16858)
-- Name: conta_pagar validachavecontapagar2; Type: TRIGGER; Schema: public; Owner: admin
--

CREATE TRIGGER validachavecontapagar2 BEFORE INSERT ON public.conta_pagar FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 3372 (class 2620 OID 16859)
-- Name: conta_pagar validachavecontapagarfornecedor; Type: TRIGGER; Schema: public; Owner: admin
--

CREATE TRIGGER validachavecontapagarfornecedor BEFORE UPDATE ON public.conta_pagar FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa2();


--
-- TOC entry 3373 (class 2620 OID 16861)
-- Name: conta_pagar validachavecontapagarfornecedor2; Type: TRIGGER; Schema: public; Owner: admin
--

CREATE TRIGGER validachavecontapagarfornecedor2 BEFORE INSERT ON public.conta_pagar FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa2();


--
-- TOC entry 3374 (class 2620 OID 16860)
-- Name: conta_receber validachavecontareceber; Type: TRIGGER; Schema: public; Owner: admin
--

CREATE TRIGGER validachavecontareceber BEFORE INSERT ON public.conta_receber FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 3375 (class 2620 OID 16866)
-- Name: conta_receber validachavepessoa; Type: TRIGGER; Schema: public; Owner: admin
--

CREATE TRIGGER validachavepessoa BEFORE UPDATE ON public.conta_receber FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 3376 (class 2620 OID 16862)
-- Name: endereco validachavepessoa; Type: TRIGGER; Schema: public; Owner: admin
--

CREATE TRIGGER validachavepessoa BEFORE UPDATE ON public.endereco FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 3378 (class 2620 OID 16863)
-- Name: nota_fiscal_compra validachavepessoa; Type: TRIGGER; Schema: public; Owner: admin
--

CREATE TRIGGER validachavepessoa BEFORE UPDATE ON public.nota_fiscal_compra FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 3380 (class 2620 OID 16864)
-- Name: usuario validachavepessoa; Type: TRIGGER; Schema: public; Owner: admin
--

CREATE TRIGGER validachavepessoa BEFORE UPDATE ON public.usuario FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 3382 (class 2620 OID 16867)
-- Name: venda_compra_loja_virtual validachavepessoa; Type: TRIGGER; Schema: public; Owner: admin
--

CREATE TRIGGER validachavepessoa BEFORE UPDATE ON public.venda_compra_loja_virtual FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 3377 (class 2620 OID 16865)
-- Name: endereco validachavepessoa2; Type: TRIGGER; Schema: public; Owner: admin
--

CREATE TRIGGER validachavepessoa2 BEFORE INSERT ON public.endereco FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 3379 (class 2620 OID 16870)
-- Name: nota_fiscal_compra validachavepessoa2; Type: TRIGGER; Schema: public; Owner: admin
--

CREATE TRIGGER validachavepessoa2 BEFORE INSERT ON public.nota_fiscal_compra FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 3381 (class 2620 OID 16871)
-- Name: usuario validachavepessoa2; Type: TRIGGER; Schema: public; Owner: admin
--

CREATE TRIGGER validachavepessoa2 BEFORE INSERT ON public.usuario FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 3383 (class 2620 OID 16868)
-- Name: venda_compra_loja_virtual validachavepessoa2; Type: TRIGGER; Schema: public; Owner: admin
--

CREATE TRIGGER validachavepessoa2 BEFORE INSERT ON public.venda_compra_loja_virtual FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 3368 (class 2620 OID 16853)
-- Name: avaliacao_produto validachavepessoaavaliacaoproduto; Type: TRIGGER; Schema: public; Owner: admin
--

CREATE TRIGGER validachavepessoaavaliacaoproduto BEFORE UPDATE ON public.avaliacao_produto FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 3369 (class 2620 OID 16854)
-- Name: avaliacao_produto validachavepessoaavaliacaoproduto2; Type: TRIGGER; Schema: public; Owner: admin
--

CREATE TRIGGER validachavepessoaavaliacaoproduto2 BEFORE INSERT ON public.avaliacao_produto FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 3355 (class 2606 OID 16579)
-- Name: usuarios_acesso acesso_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.usuarios_acesso
    ADD CONSTRAINT acesso_fk FOREIGN KEY (acesso_id) REFERENCES public.acesso(id);


--
-- TOC entry 3360 (class 2606 OID 16683)
-- Name: nota_fiscal_compra conta_pagar_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.nota_fiscal_compra
    ADD CONSTRAINT conta_pagar_fk FOREIGN KEY (conta_pagar_id) REFERENCES public.conta_pagar(id);


--
-- TOC entry 3363 (class 2606 OID 16821)
-- Name: venda_compra_loja_virtual cup_desconto_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.venda_compra_loja_virtual
    ADD CONSTRAINT cup_desconto_fk FOREIGN KEY (cup_desconto_id) REFERENCES public.cup_desconto(id);


--
-- TOC entry 3364 (class 2606 OID 16826)
-- Name: venda_compra_loja_virtual endereco_cobranca_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.venda_compra_loja_virtual
    ADD CONSTRAINT endereco_cobranca_fk FOREIGN KEY (endereco_cobranca_id) REFERENCES public.endereco(id);


--
-- TOC entry 3365 (class 2606 OID 16831)
-- Name: venda_compra_loja_virtual endereco_entrega_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.venda_compra_loja_virtual
    ADD CONSTRAINT endereco_entrega_fk FOREIGN KEY (endereco_entrega_id) REFERENCES public.endereco(id);


--
-- TOC entry 3366 (class 2606 OID 16836)
-- Name: venda_compra_loja_virtual forma_pagamento_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.venda_compra_loja_virtual
    ADD CONSTRAINT forma_pagamento_fk FOREIGN KEY (forma_pagamento_id) REFERENCES public.forma_pagamento(id);


--
-- TOC entry 3361 (class 2606 OID 16740)
-- Name: nota_item_produto nota_fiscal_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.nota_item_produto
    ADD CONSTRAINT nota_fiscal_fk FOREIGN KEY (nota_fiscal_compra_id) REFERENCES public.nota_fiscal_compra(id);


--
-- TOC entry 3367 (class 2606 OID 16841)
-- Name: venda_compra_loja_virtual nota_fiscal_venda_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.venda_compra_loja_virtual
    ADD CONSTRAINT nota_fiscal_venda_fk FOREIGN KEY (nota_fiscal_venda_id) REFERENCES public.nota_fiscal_venda(id);


--
-- TOC entry 3357 (class 2606 OID 16777)
-- Name: imagem_produto pessoa_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.imagem_produto
    ADD CONSTRAINT pessoa_fk FOREIGN KEY (produto_id) REFERENCES public.produto(id);


--
-- TOC entry 3353 (class 2606 OID 16772)
-- Name: avaliacao_produto produto_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.avaliacao_produto
    ADD CONSTRAINT produto_fk FOREIGN KEY (produto_id) REFERENCES public.produto(id);


--
-- TOC entry 3358 (class 2606 OID 16782)
-- Name: item_venda_loja produto_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.item_venda_loja
    ADD CONSTRAINT produto_fk FOREIGN KEY (produto_id) REFERENCES public.produto(id);


--
-- TOC entry 3362 (class 2606 OID 16787)
-- Name: nota_item_produto produto_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.nota_item_produto
    ADD CONSTRAINT produto_fk FOREIGN KEY (produto_id) REFERENCES public.produto(id);


--
-- TOC entry 3356 (class 2606 OID 16799)
-- Name: usuarios_acesso usuario_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.usuarios_acesso
    ADD CONSTRAINT usuario_fk FOREIGN KEY (usuario_id) REFERENCES public.usuario(id);


--
-- TOC entry 3359 (class 2606 OID 16811)
-- Name: item_venda_loja venda_compra_loja_virtual_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.item_venda_loja
    ADD CONSTRAINT venda_compra_loja_virtual_fk FOREIGN KEY (venda_compra_loja_virtual_id) REFERENCES public.venda_compra_loja_virtual(id);


--
-- TOC entry 3354 (class 2606 OID 16816)
-- Name: status_rastreio venda_compra_loja_virtual_id; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.status_rastreio
    ADD CONSTRAINT venda_compra_loja_virtual_id FOREIGN KEY (venda_compra_loja_virtual_id) REFERENCES public.venda_compra_loja_virtual(id);


-- Completed on 2024-07-27 17:31:49 -03

--
-- PostgreSQL database dump complete
--

