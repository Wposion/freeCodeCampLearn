#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

cat games.csv | while IFS="," read year round winner opponent winner_goals opponent_goals
do
  if [[ $year != year ]]
  then
    echo $year $round $winner $opponent $winner_goals $opponent_goals
    #find winner and opponent exist in team or not
    SELECT_WINNER_RESULT=$($PSQL "SELECT team_id FROM teams WHERE name = '$winner'")
    SELECT_OPPONENT_RESULT=$($PSQL "SELECT team_id FROM teams WHERE name = '$opponent'")
    
    # Get winner team id
    if [[ -z $SELECT_WINNER_RESULT ]]
    then
      #if not exist
      INSERT_WINNER_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$winner')")
      SELECT_WINNER_RESULT=$($PSQL "SELECT team_id FROM teams WHERE name = '$winner'")
      winner_id=$SELECT_WINNER_RESULT
    else
      #if exist than insert data
      winner_id=$SELECT_WINNER_RESULT
    fi

    # Get opponent team id
    if [[ -z $SELECT_OPPONENT_RESULT ]]
    then
      INSERT_OPPONENT_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$opponent')")
      SELECT_OPPONENT_RESULT=$($PSQL "SELECT team_id FROM teams WHERE name = '$opponent'")
      opponent_id=$SELECT_OPPONENT_RESULT
    else
      opponent_id=$SELECT_OPPONENT_RESULT
    fi

    #insert data
    INSERT_OPPONENT_RESULT=$($PSQL "INSERT INTO games(year,round,winner_id,opponent_id,winner_goals,opponent_goals) VALUES($year,'$round',$winner_id,$opponent_id,$winner_goals,$opponent_goals)")
    echo $INSERT_OPPONENT_RESULT
  fi
done