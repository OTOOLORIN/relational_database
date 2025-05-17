--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)
-- Dumped by pg_dump version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)

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

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: comet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.comet (
    comet_id integer NOT NULL,
    name character varying(30) NOT NULL,
    type character varying(30)
);


ALTER TABLE public.comet OWNER TO freecodecamp;

--
-- Name: comet_comet_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.comet_comet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.comet_comet_id_seq OWNER TO freecodecamp;

--
-- Name: comet_comet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.comet_comet_id_seq OWNED BY public.comet.comet_id;


--
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    name character varying(30) NOT NULL,
    description character varying(100),
    shape character varying(20),
    age_in_billion_years numeric(3,1) NOT NULL
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.galaxy_galaxy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_galaxy_id_seq OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.galaxy_galaxy_id_seq OWNED BY public.galaxy.galaxy_id;


--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    name character varying(30) NOT NULL,
    fun_fact text,
    is_spherical boolean,
    planet_id integer
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.moon_moon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moon_moon_id_seq OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.moon_moon_id_seq OWNED BY public.moon.moon_id;


--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    name character varying(30) NOT NULL,
    fun_fact text NOT NULL,
    has_live boolean,
    distance_from_star_in_m_km integer,
    star_id integer
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.planet_planet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_planet_id_seq OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.planet_planet_id_seq OWNED BY public.planet.planet_id;


--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    name character varying(30) NOT NULL,
    description text NOT NULL,
    type character varying(50),
    temp_k integer,
    galaxy_id integer
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.star_star_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_star_id_seq OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.star_star_id_seq OWNED BY public.star.star_id;


--
-- Name: comet comet_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.comet ALTER COLUMN comet_id SET DEFAULT nextval('public.comet_comet_id_seq'::regclass);


--
-- Name: galaxy galaxy_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy ALTER COLUMN galaxy_id SET DEFAULT nextval('public.galaxy_galaxy_id_seq'::regclass);


--
-- Name: moon moon_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon ALTER COLUMN moon_id SET DEFAULT nextval('public.moon_moon_id_seq'::regclass);


--
-- Name: planet planet_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet ALTER COLUMN planet_id SET DEFAULT nextval('public.planet_planet_id_seq'::regclass);


--
-- Name: star star_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star ALTER COLUMN star_id SET DEFAULT nextval('public.star_star_id_seq'::regclass);


--
-- Data for Name: comet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.comet VALUES (1, 'Halleys Comet', 'Short-period');
INSERT INTO public.comet VALUES (2, 'Hale-Bopp', 'Long-period');
INSERT INTO public.comet VALUES (3, 'Comet NEOWISE', 'Long-period');


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy VALUES (1, 'Milky Way', 'Our home galaxy, containing the Sun, Earth, and billions of other stars.', 'Spiral', 13.6);
INSERT INTO public.galaxy VALUES (2, 'Andromeda', 'It is on a collision course with the milky way and will merge in 4B years.', 'Spiral', 10.0);
INSERT INTO public.galaxy VALUES (3, 'Triangulum', 'The third largest galaxy in our local group. A satellite of Andromeda.', 'Spiral', 13.0);
INSERT INTO public.galaxy VALUES (4, 'Large Magellanic Cloud', 'A nearby satellite galaxy of the milky way.', 'Irregular', 13.2);
INSERT INTO public.galaxy VALUES (5, 'Small Magellanic Cloud', 'Another milky way satellite. It is smaller than the LMC.', 'Irregular', 13.0);
INSERT INTO public.galaxy VALUES (6, 'Messier 87', 'A giant elliptical galaxy in the Virgo Cluster. Famous for the first black hole image', 'Elliptical', 13.7);


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES (1, 'The Moon', 'Only moon humans visited; drives Earth’s tides', true, 3);
INSERT INTO public.moon VALUES (2, 'Io', 'Most volcanic object in the Solar System', true, 5);
INSERT INTO public.moon VALUES (3, 'Europa', 'icy crust with ocean', true, 5);
INSERT INTO public.moon VALUES (4, 'Ganymede', 'Largest moon; has magnetic field', true, 5);
INSERT INTO public.moon VALUES (5, 'Callisto', 'Heavily cratered; possible internal ocean', true, 5);
INSERT INTO public.moon VALUES (6, 'Titan', 'Thick atmosphere; methane lakes', true, 6);
INSERT INTO public.moon VALUES (7, 'Enceladus', 'Icy surface; geysers shoot into space', true, 6);
INSERT INTO public.moon VALUES (8, 'Mimas', 'Huge crater, resembles Death Star', true, 6);
INSERT INTO public.moon VALUES (9, 'Phobos', 'Small; will crash into Mars eventually', false, 4);
INSERT INTO public.moon VALUES (10, 'Deimos', 'Tiny and smooth; likely a captured asteroid', false, 4);
INSERT INTO public.moon VALUES (11, 'Titania', 'Icy surface; may have subsurface ocean', true, 7);
INSERT INTO public.moon VALUES (12, 'Oberon', 'Cretered; very old surface', true, 7);
INSERT INTO public.moon VALUES (13, 'Triton', 'Retrograde orbit; icy with geysers', true, 8);
INSERT INTO public.moon VALUES (14, 'Rhea', 'Second-largest Saturn moon; may have thin rings', true, 6);
INSERT INTO public.moon VALUES (15, 'Dione', 'Icy surface; may have subsurface ocean', true, 6);
INSERT INTO public.moon VALUES (16, 'Tethys', 'Large canyon (Ithaca Chasma) on surface', true, 6);
INSERT INTO public.moon VALUES (17, 'Hyperion', 'Very porous; tumbles chaotically in orbit', false, 6);
INSERT INTO public.moon VALUES (18, 'Miranda', 'Strange patchwork of cliffs and valleys', true, 7);
INSERT INTO public.moon VALUES (19, 'Ariel', 'Smooth surface; signs of past geologic activity', true, 7);
INSERT INTO public.moon VALUES (20, 'Nix', 'One of Pluto’s smaller moons; highly reflective', false, 9);
INSERT INTO public.moon VALUES (21, 'Hydra', 'Small and elongated; rotates chaotically', false, 9);


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES (1, 'Mercury', 'Smallest planet; no moons; extreme temperatures', false, 58, 1);
INSERT INTO public.planet VALUES (2, 'Venus', 'Hottest planet due to runaway greenhouse effect', false, 108, 1);
INSERT INTO public.planet VALUES (3, 'Earth', 'Only known planet with life and plate tectonics', true, 150, 1);
INSERT INTO public.planet VALUES (4, 'Mars', 'Known as the "Red Planet"; has the tallest volcano in the Solar System (Olympus Mons)', false, 228, 1);
INSERT INTO public.planet VALUES (5, 'Jupiter', 'Largest planet; has a Great Red Spot (a giant storm); has over 90 moons', false, 778, 1);
INSERT INTO public.planet VALUES (6, 'Saturn', 'Known for its stunning ring system', false, 1043, 1);
INSERT INTO public.planet VALUES (7, 'Uranus', 'Rotates on its side; pale blue color due to methane gas', false, 2087, 1);
INSERT INTO public.planet VALUES (8, 'Neptune', 'Fastest winds in the Solar System; deep blue color', false, 4500, 1);
INSERT INTO public.planet VALUES (10, 'Ceras', 'Largest object in the asteroid belt; round and icy, with bright salt deposits', false, 414, 1);
INSERT INTO public.planet VALUES (11, 'Eris', 'Slightly smaller than Pluto, but more massive', false, 10001, 1);
INSERT INTO public.planet VALUES (12, 'Haumea', 'Shaped like a flattened egg due to its fast rotation; has rings and moons', false, 6500, 1);
INSERT INTO public.planet VALUES (13, 'Makemake', 'Slightly smaller than Pluto; very bright surface due to methane ice', false, 6800, 1);
INSERT INTO public.planet VALUES (9, 'Pluto', 'Once considered the 9th planet, reclassified in 2006; has five moons, including Charon', false, 5900, 1);


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES (1, 'Sun', 'Our closest star and the center of the Solar System. It provides energy for life on Earth.', 'G-type main-sequence star', 5778, 1);
INSERT INTO public.star VALUES (2, 'Sirius', 'The brightest star in the night sky, located in the Canis Major constellation.', 'A-type sequence star', 9940, 1);
INSERT INTO public.star VALUES (3, 'Betelgeuse', 'A massive, aging star in Orion shoulder. Expected to go suoernove in the next million years.', 'Red supergiant', 3500, 1);
INSERT INTO public.star VALUES (4, 'Rigel', ' Brightest star in the Orion constellation. Extremely luminous and massive.', 'Blue supergiant', 11000, 1);
INSERT INTO public.star VALUES (5, 'Proxima Centauri', 'The closest known star to the Sun, and part of the Alpha Centauri system.', 'Red dwarf (M-type)', 3050, 1);
INSERT INTO public.star VALUES (6, 'Vega', 'Bright star in the Lyra constellation, once used as a reference for zero magnitude brightness', 'A-type main-sequence star', 9600, 1);
INSERT INTO public.star VALUES (7, 'R136a1', 'One of the most massive and luminous stars ever discovered.', NULL, 53000, 4);


--
-- Name: comet_comet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.comet_comet_id_seq', 3, true);


--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_galaxy_id_seq', 6, true);


--
-- Name: moon_moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.moon_moon_id_seq', 21, true);


--
-- Name: planet_planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_planet_id_seq', 13, true);


--
-- Name: star_star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_star_id_seq', 7, true);


--
-- Name: comet comet_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.comet
    ADD CONSTRAINT comet_name_key UNIQUE (name);


--
-- Name: comet comet_name_key1; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.comet
    ADD CONSTRAINT comet_name_key1 UNIQUE (name);


--
-- Name: comet comet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.comet
    ADD CONSTRAINT comet_pkey PRIMARY KEY (comet_id);


--
-- Name: galaxy galaxy_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_name_key UNIQUE (name);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: moon moon_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_name_key UNIQUE (name);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: planet planet_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_name_key UNIQUE (name);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: star star_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_name_key UNIQUE (name);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: moon moon_planet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_planet_id_fkey FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet planet_star_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_star_id_fkey FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- Name: star star_galaxy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_galaxy_id_fkey FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- PostgreSQL database dump complete
--

