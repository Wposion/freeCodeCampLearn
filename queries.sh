#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=worldcup --no-align --tuples-only -c"

# Do not change code above this line. Use the PSQL variable above to query your database.

echo -e "\nTotal number of goals in all games from winning teams:"
echo "$($PSQL "SELECT SUM(winner_goals) FROM games")"

echo -e "\nTotal number of goals in all games from both teams combined:"
echo "$($PSQL "SELECT SUM(winner_goals)+SUM(opponent_goals) AS sum FROM games")"

echo -e "\nAverage number of goals in all games from the winning teams:"
echo "$($PSQL "SELECT AVG(winner_goals) FROM games")"

echo -e "\nAverage number of goals in all games from the winning teams rounded to two decimal places:"
echo "$($PSQL "SELECT ROUND(AVG(winner_goals),2) FROM games")"

echo -e "\nAverage number of goals in all games from both teams:"
echo "$($PSQL "SELECT AVG(winner_goals+opponent_goals) FROM games")"

echo -e "\nMost goals scored in a single game by one team:"
echo "$($PSQL "SELECT MAX(winner_goals) FROM games")"

echo -e "\nNumber of games where the winning team scored more than two goals:"
echo "$($PSQL "SELECT count(*) FROM games WHERE winner_goals > 2")"

echo -e "\nWinner of the 2018 tournament team name:"
echo  "$($PSQL "SELECT teams.name FROM games LEFT JOIN teams ON games.winner_id = teams.team_id where round = 'Final' and year = '2018'")"

echo -e "\nList of teams who played in the 2014 'Eighth-Final' round:"
echo  "$($PSQL "SELECT DISTINCT(teams.name) FROM teams FULL JOIN games as g1 ON teams.team_id = g1.winner_id FULL JOIN games as g2 ON teams.team_id = g2.opponent_id where (g1.round = 'Eighth-Final' or g2.round = 'Eighth-Final') and (g1.year = '2014' or g2.year = '2014') order by teams.name")"

echo -e "\nList of unique winning team names in the whole data set:"
echo  "$($PSQL "SELECT teams.name FROM games inner JOIN teams ON games.winner_id=teams.team_id group by teams.name order by teams.name")"

echo -e "\nYear and team name of all the champions:"
echo  "$($PSQL "SELECT games.year,teams.name FROM games left join teams on games.winner_id=teams.team_id where round = 'Final' order by games.year")"

echo -e "\nList of teams that start with 'Co':"
echo  "$($PSQL "select name from teams where name like 'Co%'")"
