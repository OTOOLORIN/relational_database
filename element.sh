PSQL='psql -X --username=freecodecamp --dbname=periodic_table -t -c'
if [[ $1 ]]
  then
    ATOMIC_NUMBERS=$($PSQL 'SELECT atomic_number FROM elements');
    SYMBOLS=$($PSQL 'SELECT symbol FROM elements');
    NAMES=$($PSQL 'SELECT name FROM elements')
    if [[ $ATOMIC_NUMBERS =~ $1 ]]
      then
        ELEMENT_NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number=$1")
        ELEMENT_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$1")
        ATOMIC_NUMBER=$1
    elif [[ $SYMBOLS =~ $1 ]]
      then
          ELEMENT_NAME=$($PSQL "SELECT name FROM elements WHERE symbol='$1'")
          ELEMENT_SYMBOL=$1
          ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$1'")
    elif [[ $NAMES =~ $1 ]]
      then
        ELEMENT_NAME=$($PSQL "SELECT name FROM elements WHERE name='$1'")
        ELEMENT_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE name='$1'")
        ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE name='$1'")
    else
      echo I could not find that element in the database.
      exit
    fi
  else
    echo Please provide an element as an argument.
fi
  if [[ $ELEMENT_NAME ]]
    then
      ELEMENT_TYPE=$($PSQL "SELECT type FROM types INNER JOIN properties USING(type_id) INNER JOIN elements USING(atomic_number) WHERE name=trim('$ELEMENT_NAME')")
      ELEMENT_MASS=$($PSQL "SELECT atomic_mass FROM properties INNER JOIN elements USING(atomic_number) WHERE name=trim('$ELEMENT_NAME')")
      ELEMENT_MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties INNER JOIN elements USING(atomic_number) WHERE name=trim('$ELEMENT_NAME')")
      ELEMENT_BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties INNER JOIN elements USING(atomic_number) WHERE name=trim('$ELEMENT_NAME')")
      echo "The element with atomic number $(echo $ATOMIC_NUMBER | sed 's/ //') \
is $(echo $ELEMENT_NAME | sed 's/ //') ($(echo $ELEMENT_SYMBOL | sed 's/ //')). \
It's a $(echo $ELEMENT_TYPE | sed 's/ //'), \
with a mass of $( echo $ELEMENT_MASS | sed 's/ //') amu. $(echo $ELEMENT_NAME | sed 's/ //') \
has a melting point of $(echo $ELEMENT_MELTING_POINT | sed 's/ //') \
celsius and a boiling point of $(echo $ELEMENT_BOILING_POINT | sed 's/ //') celsius."
  elif [[ $1 ]]
    then
    echo I could not find that element in the database.
  fi
