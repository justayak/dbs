--- bundeliga-DB by Memel, Timo, Julian
CREATE TABLE Team 
(
	name VARCHAR(20),
	stadium VARCHAR(100),
	divisionId INTEGER,
	CONSTRAINT team_pk PRIMARY KEY (name),
);
