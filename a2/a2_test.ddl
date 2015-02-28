-- The country table contains all the countries in the world and their facts.
-- 'cid' is the id of the country.
-- 'name' is the name of the country.
-- 'height' is the highest elevation point of the country.
-- 'population' is the population of the country.
CREATE TABLE country (
    cid 		INTEGER 	PRIMARY KEY,
    cname 		VARCHAR(20)	NOT NULL,
    height 		INTEGER 	NOT NULL,
    population	INTEGER 	NOT NULL);
    
-- The language table contains information about the languages and the percentage of the speakers of the language for each country.
-- 'cid' is the id of the country.
-- 'lid' is the id of the language.
-- 'lname' is the name of the language.
-- 'lpercentage' is the percentage of the population in the country who speak the language.
CREATE TABLE language (
    cid 		INTEGER 	REFERENCES country(cid) ON DELETE RESTRICT,
    lid 		INTEGER 	NOT NULL,
    lname 		VARCHAR(20) NOT NULL,
    lpercentage	REAL 		NOT NULL,
	PRIMARY KEY(cid, lid));

-- The religion table contains information about the religions and the percentage of the population in each country that follow the religion.
-- 'cid' is the id of the country.
-- 'rid' is the id of the religion.
-- 'rname' is the name of the religion.
-- 'rpercentage' is the percentage of the population in the country who follows the religion.
CREATE TABLE religion (
    cid 		INTEGER 	REFERENCES country(cid) ON DELETE RESTRICT,
    rid 		INTEGER 	NOT NULL,
    rname 		VARCHAR(20) NOT NULL,
    rpercentage	REAL 		NOT NULL,
	PRIMARY KEY(cid, rid));

-- The hdi table contains the human development index of each country per year. (http://en.wikipedia.org/wiki/Human_Development_Index)
-- 'cid' is the id of the country.
-- 'year' is the year when the hdi score has been estimated.
-- 'hdi_score' is the Human Development Index score of the country that year. It takes values [0, 1] with a larger number representing a higher HDI.
CREATE TABLE hdi (
    cid 		INTEGER 	REFERENCES country(cid) ON DELETE RESTRICT,
    year 		INTEGER 	NOT NULL,
    hdi_score 	REAL 		NOT NULL,
	PRIMARY KEY(cid, year));

-- The ocean table contains information about oceans on the earth.
-- 'oid' is the id of the ocean.
-- 'oname' is the name of the ocean.
-- 'depth' is the depth of the deepest part of the ocean (expressed as a positive integer)
CREATE TABLE ocean (
    oid 		INTEGER 	PRIMARY KEY,
    oname 		VARCHAR(20) NOT NULL,
    depth 		INTEGER 	NOT NULL);

-- The neighbour table provides information about the countries and their neighbours.
-- 'country' refers to the cid of the first country.
-- 'neighbor' refers to the cid of a country that is neighbouring the first country.
-- 'length' is the length of the border between the two neighbouring countries.
-- Note that if A and B are neighbours, then there two tuples are stored in the table to represent that information (A, B) and (B, A). 
CREATE TABLE neighbour (
    country 	INTEGER 	REFERENCES country(cid) ON DELETE RESTRICT,
    neighbor 	INTEGER 	REFERENCES country(cid) ON DELETE RESTRICT, 
    length 		INTEGER 	NOT NULL,
	PRIMARY KEY(country, neighbor));

-- The oceanAccess table provides information about the countries which have a border with an ocean.
-- 'cid' refers to the cid of the country.
-- 'oid' refers to the oid of the ocean.
CREATE TABLE oceanAccess (
    cid 	INTEGER 	REFERENCES country(cid) ON DELETE RESTRICT,
    oid 	INTEGER 	REFERENCES ocean(oid) ON DELETE RESTRICT, 
    PRIMARY KEY(cid, oid));

insert into country values
    (1, 'Canada', 10, 6),
    (2, 'USA', 8, 18),
    (3, 'Italy', 5, 3),
    (4, 'France', 12, 3),
    (5, 'India', 1, 35),
    (6, 'Chad', 5, 1),
    (7, 'Yemen', 3, 1),
    (8, 'China', 6, 37),
    (9, 'Japan', 2, 6),
    (10, 'Zimbabwe', 5, 2),
    (11, 'Iraq', 7, 4),
    (12, 'Egypt', 4, 4);

insert into neighbour values
    (1, 2, 30),
    (1, 3, 4),
    (1, 4, 5),
    (2, 3, 4),
    (2, 1, 30),
    (3, 1, 2),
    (3, 2, 5),
    (4, 5, 1),
    (5, 4, 3),
    (6, 7, 1),
    (7, 6, 1),
    (11, 12,2),
    (12, 11, 2);

insert into ocean values
    (1, 'atlantic', 50),
    (2, 'mediteranean', 20),
    (3, 'pacific', 60),
    (4, 'indian', 25);

insert into oceanAccess values
    (1, 1),
    (1, 3),
    (2, 1),
    (2, 3),
    (4, 1),
    (5, 4);

insert into hdi values
    (1, 2009, 0.9),
    (1, 2010, 0.85),
    (1, 2011, 0.88),
    (1, 2012, 0.86),
    (1, 2013, 0.89),
    (2, 2009, 0.92),
    (2, 2010, 0.92),
    (2, 2011, 0.9),
    (2, 2012, 0.91),
    (2, 2013, 0.94),
    (3, 2009, 0.56),
    (3, 2010, 0.55),
    (3, 2011, 0.58),
    (3, 2012, 0.55),
    (3, 2013, 0.57),
    (4, 2009, 0.76),
    (4, 2010, 0.77),
    (4, 2011, 0.78),
    (4, 2012, 0.79),
    (4, 2013, 0.80),
    (5, 2009, 0.43),
    (5, 2010, 0.44),
    (5, 2011, 0.45),
    (5, 2012, 0.46),
    (5, 2013, 0.47),
    (5, 1994, 0.95),
    (6, 2009, 0.14),
    (6, 2010, 0.15),
    (6, 2011, 0.19),
    (6, 2012, 0.20),
    (6, 2013, 0.21),
    (7, 2009, 0.21),
    (7, 2010, 0.21),
    (7, 2011, 0.21),
    (7, 2012, 0.21),
    (7, 2013, 0.21),
    (8, 2009, 0.7),
    (8, 2010, 0.77),
    (8, 2011, 0.78),
    (8, 2012, 0.8),
    (8, 2013, 0.81),
    (9, 2009, 0.61),
    (9, 2010, 0.68),
    (9, 2011, 0.67),
    (9, 2012, 0.65),
    (9, 2013, 0.67),
    (10, 2009, 0.40),
    (10, 2010, 0.39),
    (10, 2011, 0.39),
    (10, 2012, 0.38),
    (10, 2013, 0.39),
    (11, 2009, 0.18),
    (11, 2010, 0.19),
    (11, 2011, 0.20),
    (11, 2012, 0.21),
    (11, 2013, 0.22),
    (12, 2009, 0.40),
    (12, 2010, 0.41),
    (12, 2011, 0.43),
    (12, 2012, 0.44),
    (12, 2013, 0.45);

insert into religion values
    (1, 1, 'Christian', 0.70),
    (1, 2, 'Islam', 0.20),
    (1, 3, 'Hindu', 0.05),
    (1, 4, 'Jewish', 0.05),
    (2, 1, 'Christian', 0.90),
    (2, 2, 'Islam', 0.06),
    (2, 3, 'Hindu', 0.03),
    (2, 4, 'Jewish', 0.01),
    (3, 1, 'Christian', 0.99),
    (3, 2, 'Islam', 0.01);

insert into language values
    (1, 1, 'English', 0.90),
    (1, 2, 'French', 0.10),
    (2, 1, 'English', 0.85),
    (2, 3, 'Spanish', 0.15),
    (3, 1, 'English', 1.00),
    (5, 5, 'Egyptian', 1.00),
    (6, 4, 'Chinese', 1.00),
    (7, 1, 'English', 1.00);


