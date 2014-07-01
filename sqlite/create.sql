PRAGMA foreign_keys = ON;
DROP TABLE IF EXISTS Country;
CREATE TABLE Country (
	name VARCHAR(80) CONSTRAINT country_pk PRIMARY KEY 
);

DROP TABLE IF EXISTS Division;
CREATE TABLE Division (
	name INTEGER CONSTRAINT division_pk PRIMARY KEY
);

DROP TABLE IF EXISTS Season;
CREATE TABLE Season (
	name INTEGER CONSTRAINT season_pk PRIMARY KEY
);

DROP TABLE IF EXISTS Team;
CREATE TABLE Team (
    id INTEGER CONSTRAINT team_pk PRIMARY KEY,
	name VARCHAR(80),
	division INTEGER REFERENCES Division(name)
);

DROP TABLE IF EXISTS Player;
CREATE TABLE Player (
	name VARCHAR(80) NOT NULL,
	id INTEGER CONSTRAINT player_pk PRIMARY KEY,
	goals INTEGER,
	country VARCHAR(80) REFERENCES Country(name)
);

DROP TABLE IF EXISTS PlayerToTeam;
CREATE TABLE PlayerToTeam (
	playerId INTEGER REFERENCES Player(id),
	teamId INTEGER REFERENCES Team(id),
	nbr INTEGER,
	CONSTRAINT playerToTeam_pk PRIMARY KEY(playerId,teamId,nbr)
);

DROP TABLE IF EXISTS EventType;
CREATE TABLE EventType(
	name INTEGER CONSTRAINT eventtype_pk PRIMARY KEY
);

--- seasonName INTEGER REFERENCES Season(name),
DROP TABLE IF EXISTS BLMatch;
CREATE TABLE BLMatch(
	matchday INTEGER,
	mdate DATE,
	startTime TIME NOT NULL,
	home_team INTEGER REFERENCES Team(id),
	guest_team INTEGER NOT NULL REFERENCES Team(id),
	goalsHome INTEGER,
	goalsGuest INTEGER,
	CONSTRAINT match_pk PRIMARY KEY(home_team, mdate)
);

DROP TABLE IF EXISTS Event;
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

DROP VIEW IF EXISTS v_match;
CREATE VIEW v_match AS SELECT 
home_team AS team_id, 
guest_team as cteam, 
goalshome as goals, 
goalsguest as cgoals,
mdate
FROM blmatch UNION 
SELECT 
guest_team AS team_id, 
home_team as cteam, 
goalsguest as goals, 
goalshome as cgoals,
mdate FROM blmatch 
ORDER BY mdate DESC; --FETCH FIRST 5 ROWS ONLY;