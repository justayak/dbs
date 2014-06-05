--- bundeliga-DB by Memel, Timo, Julian
CREATE TABLE Country (
	name varchar(80) PRIMARY KEY
);

CREATE TABLE Division (
	id integer PRIMARY KEY,
	name varchar(80)
);

CREATE TABLE Season (
	id integer PRIMARY KEY,
	name varchar(80),
	start date,
	end date
);

CREATE TABLE Team (
	name varchar(80) PRIMARY KEY,
	stadium varchar(80) ,
	divisionID integer REFERENCES Division(id)
);

CREATE TABLE Player (
	playerId integer PRIMARY KEY,
	name varchar(80),
	homeCountry varchar(80) REFERENCES Country(name)
	team_name varchar (80) REFERENCES Team(name)
);

CREATE TABLE Match (
	seasonID integer REFERENCES Season(id),
date date,
home_name varchar(80) REFERENCES Team(name),
guest_name varchar(80) REFERENCES Team(name),
PRIMARY KEY (seasonID, date, home_name, guest_name)	
);

CREATE TABLE EventType (
	name varchar(80)
);

CREATE TABLE Event (
	match_date date REFERENCES Match(date),
	home_name varchar(80) REFERENCES Team(name),
	type varchar(80) REFERENCES EventType(name),
	playerId integer REFERENCES Player(playerId),
	minute integer,
	PRIMARY KEY (match_date, home_name, type, minute, player_id)
);

CREATE TABLE PlayerToTeam (
	playerId integer REFERENCES Player(playerId),
	team_name varchar(80) REFERENCES Team(name),
	number integer,
	PRIMARY KEY (playerId, team_name, number)
);

--P.S:
--tables that I created: Division, County, Season, EventType

