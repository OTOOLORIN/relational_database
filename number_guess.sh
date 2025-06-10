#!/bin/bash
PSQL='psql -X --username=freecodecamp --dbname=number_guess -t --no-align -c'
SECRET_NUMBER=$(( 1 + RANDOM % 1000 ))
NO_OF_GAMES=0
PROMPT_USER() {
  if [[ $1 ]]
    then 
      echo $1
    fi
  echo Enter your username:
  read USERNAME
  if [[ -z $USERNAME ]]
  then
    clear
    PROMPT_USER "Username cannot be empty"
  fi
}

GET_USER_NUMBER() {
  if [[ -z $1 ]]
  then
    echo Guess the secret number between 1 and 1000:
    read USER_NUMBER
  fi
  if [[ $1 ]]
    then
      echo $1
      read USER_NUMBER
  fi
  until [[ $USER_NUMBER =~ ^[0-9]+$ ]]
    do
      echo That is not an integer, guess again:
      read USER_NUMBER
  done
} 
PLAY_GAME() {
  NO_OF_GUESSES=1
  until [[ $SECRET_NUMBER == $USER_NUMBER ]]
    do
      if [[ $USER_NUMBER -lt $SECRET_NUMBER ]]
       then
        GET_USER_NUMBER "It's lower than that, guess again:"
      else
          GET_USER_NUMBER "It's higher than that, guess again:"
      fi 
      ((NO_OF_GUESSES++))
    done
}
PROMPT_USER
GET_USER() {
  USER_ID=$($PSQL "SELECT user_id FROM users WHERE INITCAP(username)=TRIM(INITCAP('$USERNAME'))")
}
INSERT_USER() {
  INSERT_USER_RESULT=$($PSQL "INSERT INTO users(username) VALUES('$USERNAME')")
}
GET_USER
USER_DATA=$($PSQL "SELECT game_id FROM games WHERE user_id=$USER_ID")
if [[ $USER_ID ]]
  then
    if [[ -z $USER_DATA ]]
      then
        echo "Welcome, $USERNAME! It looks like this is your first time here."
        GET_USER_NUMBER
        PLAY_GAME
    fi
fi
if [[ -z $USER_ID ]]
  then
    echo "Welcome, $USERNAME! It looks like this is your first time here."
    INSERT_USER
    GET_USER 
    GET_USER_NUMBER
    PLAY_GAME
elif [[ $USER_DATA ]]
  then
  GAMES_PLAYED=$($PSQL "SELECT games_played FROM games WHERE user_id=$USER_ID")
  BEST_GAME=$($PSQL "SELECT best_game FROM games WHERE user_id=$USER_ID")
  echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
  GET_USER_NUMBER
  PLAY_GAME
fi 

if [[ $SECRET_NUMBER == $USER_NUMBER ]]
  then
    echo $((++NO_OF_GAMES)) > NO_OF_GAMES
    GAME_ID=$($PSQL "SELECT game_id FROM games WHERE user_id=$USER_ID")
    if [[ -z $GAME_ID ]]
      then
        INSERT_INTO_GAMES="$($PSQL "INSERT INTO games(user_id, games_played, best_game) 
                      VALUES($USER_ID, $NO_OF_GAMES, $NO_OF_GUESSES)")"
    else
      NO_OF_GAMES=$($PSQL "SELECT games_played FROM games WHERE user_id=$USER_ID")
      UPDATE_GAMES=$($PSQL "UPDATE games SET games_played=$NO_OF_GAMES+1 WHERE user_id=$USER_ID")
      BEST_GUESSES=$($PSQL "SELECT best_game FROM games WHERE user_id=$USER_ID")
      if [[ $BEST_GUESSES -gt $NO_OF_GUESSES ]]
        then
          UPDATE_BEST_GUESSES=$($PSQL "UPDATE games SET best_game=$NO_OF_GUESSES WHERE user_id=$USER_ID")
      fi
    fi
    echo  "You guessed it in $NO_OF_GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!"
fi
