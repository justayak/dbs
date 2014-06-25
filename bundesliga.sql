DROP TABLE IF EXISTS Country CASCADE;
CREATE TABLE Country (
	name VARCHAR(80) CONSTRAINT country_pk PRIMARY KEY 
);

DROP TABLE IF EXISTS Division CASCADE;
CREATE TABLE Division (
	name INTEGER CONSTRAINT division_pk PRIMARY KEY
);

DROP TABLE IF EXISTS Season CASCADE;
CREATE TABLE Season (
	name INTEGER CONSTRAINT season_pk PRIMARY KEY
);

DROP TABLE IF EXISTS Team CASCADE;
CREATE TABLE Team (
    id INTEGER CONSTRAINT team_pk PRIMARY KEY,
	name VARCHAR(80),
	division INTEGER REFERENCES Division(name)
);

DROP TABLE IF EXISTS Player CASCADE;
CREATE TABLE Player (
	name VARCHAR(80) NOT NULL,
	id INTEGER CONSTRAINT player_pk PRIMARY KEY,
	country VARCHAR(80) REFERENCES Country(name)
);

DROP TABLE IF EXISTS PlayerToTeam CASCADE;
CREATE TABLE PlayerToTeam (
	playerId INTEGER REFERENCES Player(id),
	teamId INTEGER REFERENCES Team(id),
	seasonId INTEGER REFERENCES Season(name) NOT NULL,
	nbr INTEGER,
	CONSTRAINT playerToTeam_pk PRIMARY KEY(teamId, nbr)
);

DROP TABLE IF EXISTS EventType CASCADE;
CREATE TABLE EventType(
	name INTEGER CONSTRAINT eventtype_pk PRIMARY KEY
);

DROP TABLE IF EXISTS BLMatch CASCADE;
CREATE TABLE BLMatch(
	seasonName INTEGER REFERENCES Season(name),
	mdate DATE,
	startTime TIME NOT NULL,
	home_team INTEGER REFERENCES Team(id),
	guest_team INTEGER NOT NULL REFERENCES Team(id),
	CONSTRAINT match_pk PRIMARY KEY(home_team, mdate)
);

DROP TABLE IF EXISTS Event CASCADE;
CREATE TABLE Event (
	eventType INTEGER REFERENCES EventType(name),
	eventMinute INTEGER,
	match_date DATE,
	match_home INTEGER,
	playerId INTEGER REFERENCES Player(id),
	CONSTRAINT event_minute CHECK (eventMinute >= 0 AND eventMinute < 121),
	CONSTRAINT event_pk PRIMARY KEY (match_date, match_home, eventType, eventMinute, playerId)
	,CONSTRAINT match_fk FOREIGN KEY (match_date, match_home) REFERENCES BLMatch (mdate, home_team)
);
-- 
--- DIVISION
INSERT INTO division VALUES (1);
INSERT INTO division VALUES (2);
INSERT INTO division VALUES (3);

--- TEAM
INSERT INTO team VALUES(1,'FC Bayern Muenchen',1);
INSERT INTO team VALUES(2,'Borussia Dortmund',1);
INSERT INTO team VALUES(3,'Bayer Leverkusen',1);
INSERT INTO team VALUES(4,'FC Schalke 04',1);
INSERT INTO team VALUES(5,'VfL Wolfsburg',1);
INSERT INTO team VALUES(6,'1. FSV Mainz 05',1);
INSERT INTO team VALUES(7,'Borussia Moenchengladbach',1);
INSERT INTO team VALUES(8,'Hertha BSC',1);
INSERT INTO team VALUES(9,'FC Augsburg',1);
INSERT INTO team VALUES(10,'1899 Hoffenheim',1);
INSERT INTO team VALUES(11,'Hannover 96',1);
INSERT INTO team VALUES(12,'Eintracht Frankfurt',1);
INSERT INTO team VALUES(13,'SV Werder Bremen',1);
INSERT INTO team VALUES(14,'1. FC Nuernberg',1);
INSERT INTO team VALUES(15,'VfB Stuttgart',1);
INSERT INTO team VALUES(16,'Hamburger SV',1);
INSERT INTO team VALUES(17,'SC Freiburg',1);
INSERT INTO team VALUES(18,'Eintracht Braunschweig',1);
INSERT INTO team VALUES(19,'1. FC Koeln',2);
INSERT INTO team VALUES(20,'SpVgg Greuther Fuerth',2);
INSERT INTO team VALUES(21,'SC Paderborn 07',2);
INSERT INTO team VALUES(22,'Karlsruher SC',2);
INSERT INTO team VALUES(23,'1. FC Union Berlin',2);
INSERT INTO team VALUES(24,'FC St. Pauli',2);
INSERT INTO team VALUES(25,'1. FC Kaiserslautern',2);
INSERT INTO team VALUES(26,'VfR Aalen',2);
INSERT INTO team VALUES(27,'SV 1916 Sandhausen',2);
INSERT INTO team VALUES(28,'TSV 1860 Muenchen',2);
INSERT INTO team VALUES(29,'Fortuna Duesseldorf',2);
INSERT INTO team VALUES(30,'FC Ingolstadt 04',2);
INSERT INTO team VALUES(31,'FC Erzgebirge Aue',2);
INSERT INTO team VALUES(32,'FSV Frankfurt',2);
INSERT INTO team VALUES(33,'VfL Bochum',2);
INSERT INTO team VALUES(34,'Dynamo Dresden',2);
INSERT INTO team VALUES(35,'Arminia Bielefeld',2);
INSERT INTO team VALUES(36,'FC Energie Cottbus',2);
INSERT INTO team VALUES(37,'1. FC Heidenheim 1846',3);
INSERT INTO team VALUES(38,'RB Leipzig',3);
INSERT INTO team VALUES(39,'SV Darmstadt 98',3);
INSERT INTO team VALUES(40,'VfL Osnabrueck',3);
INSERT INTO team VALUES(41,'Hansa Rostock',3);
INSERT INTO team VALUES(42,'SV Wehen Wiesbaden',3);
INSERT INTO team VALUES(43,'Stuttgarter Kickers',3);
INSERT INTO team VALUES(44,'MSV Duisburg',3);
INSERT INTO team VALUES(45,'Hallescher FC',3);
INSERT INTO team VALUES(46,'Rot-Weiss Erfurt',3);
INSERT INTO team VALUES(47,'Jahn Regensburg',3);
INSERT INTO team VALUES(48,'VfB Stuttgart II',3);
INSERT INTO team VALUES(49,'Borussia Dortmund II',3);
INSERT INTO team VALUES(50,'Preussen Muenster',3);
INSERT INTO team VALUES(51,'SpVgg Unterhaching',3);
INSERT INTO team VALUES(52,'SV Elversberg',3);
INSERT INTO team VALUES(53,'Chemnitzer FC',3);
INSERT INTO team VALUES(54,'Holstein Kiel',3);
INSERT INTO team VALUES(55,'1. FC Saarbruecken',3);
INSERT INTO team VALUES(56,'Wacker Burghausen',3);