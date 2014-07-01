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