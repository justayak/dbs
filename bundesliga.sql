--- bundeliga-DB by Memel, Timo, Julian
-- ENUMS als Integer? (Frage an Julius)
DROP TABLE IF EXISTS Country CASCADE;
CREATE TABLE Country (
	name VARCHAR(80) CONSTRAINT country_pk PRIMARY KEY 
);

DROP TABLE IF EXISTS Division CASCADE;
CREATE TABLE Division (
	name VARCHAR(80) CONSTRAINT division_pk PRIMARY KEY
);

DROP TABLE IF EXISTS Season CASCADE;
CREATE TABLE Season (
	name INTEGER CONSTRAINT season_pk PRIMARY KEY
);

DROP TABLE IF EXISTS Team CASCADE;
CREATE TABLE Team (
	name VARCHAR(80) CONSTRAINT team_pk PRIMARY KEY,
	stadium VARCHAR(80) NOT NULL,
	division VARCHAR(80) REFERENCES Division(name)
);

DROP TABLE IF EXISTS Player CASCADE;
CREATE TABLE Player (
	name VARCHAR(80) NOT NULL,
	surname VARCHAR(80) NOT NULL,
	id INTEGER CONSTRAINT player_pk PRIMARY KEY,
	country VARCHAR(80) REFERENCES Country(name)
);

DROP TABLE IF EXISTS PlayerToTeam CASCADE;
CREATE TABLE PlayerToTeam (
	playerId INTEGER REFERENCES Player(id),
	teamName VARCHAR(80) REFERENCES Team(name),
	seasonId INTEGER REFERENCES Season(name) NOT NULL,
	nbr INTEGER,
	CONSTRAINT playerToTeam_pk PRIMARY KEY(teamName, nbr)
);

DROP TABLE IF EXISTS EventType CASCADE;
CREATE TABLE EventType(
	name VARCHAR(80) CONSTRAINT eventtype_pk PRIMARY KEY
);

DROP TABLE IF EXISTS BLMatch CASCADE;
CREATE TABLE BLMatch(
	seasonName INTEGER REFERENCES Season(name),
	mdate DATE,
	startTime TIME NOT NULL,
	home_team VARCHAR(80) REFERENCES Team(name),
	guest_team VARCHAR(80) NOT NULL REFERENCES Team(name),
	CONSTRAINT match_pk PRIMARY KEY(home_team, mdate)
);

DROP TABLE IF EXISTS Event CASCADE;
CREATE TABLE Event (
	eventType VARCHAR(80) REFERENCES EventType(name),
	eventMinute INTEGER,
	match_date DATE,
	match_home VARCHAR(80),
	playerId INTEGER REFERENCES Player(id),
	CONSTRAINT event_minute CHECK (eventMinute >= 0 AND eventMinute < 121),
	CONSTRAINT event_pk PRIMARY KEY (match_date, match_home, eventType, eventMinute, playerId)
	,CONSTRAINT match_fk FOREIGN KEY (match_date, match_home) REFERENCES BLMatch (mdate, home_team)
);
-- 