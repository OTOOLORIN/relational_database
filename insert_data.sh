#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
cat games.csv | while IFS=',' read year round winner opponent winner_goals opponent_goals
do
  if [[ $year != year ]]
    then
      # get teams id
      team_id_winner=$($PSQL "SELECT team_id FROM teams WHERE name='$winner'")
      team_id_opponent=$($PSQL "SELECT team_id FROM teams WHERE name='$opponent'")
        # if not found
        if [[ -z $team_id_winner ]]
          # insert into team
          then
          insert_team_result=$($PSQL "INSERT INTO teams(name) VALUES('$winner')")
          echo Inserted into teams, $winner
          # get new winner_id
          team_id_winner=$($PSQL "SELECT team_id FROM teams WHERE name='$winner'")
        fi
        if [[ -z $team_id_opponent ]]
          then
            insert_team_result=$($PSQL "INSERT INTO teams(name) VALUES('$opponent')")
            echo Insert into teams, $opponent
            # get new opponent id
            team_id_opponent=$($PSQL "SELECT team_id FROM teams WHERE name='$opponent'")
          fi
       # insert data into games
    DATA_EXISTS="$($PSQL "SELECT COUNT(*) FROM games WHERE year=$year AND 
    winner_id=$team_id_winner AND opponent_id=$team_id_opponent")"
    # if game not recorded
    if [[ $DATA_EXISTS -eq 0 ]]
      then
        # insert game into games
        insert_game_result="$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals)\
        VALUES($year, '$round', $team_id_winner, $team_id_opponent, $winner_goals, $opponent_goals)")"
        echo Inserted into games, $year: {$winner: $winner_goals, $opponent: $opponent_goals}
    fi
    fi
done
