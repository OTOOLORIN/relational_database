#!/bin/bash
echo -e "\n~~~~~ MY SALON ~~~~~\n"
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"
echo -e "Welcome to My Salon, how can I help you?\n"

MAIN_MENU() {
  if [[ $1 ]]
    then
      echo -e "\n$1"
    fi
  SERVICES_AVAILABLE=$($PSQL "SELECT service_id, name FROM services")
  echo "$SERVICES_AVAILABLE" | while read ID BAR NAME
    do
      echo "$ID) $NAME"
    done
  read SERVICE_ID_SELECTED
  # invalid request
  if [[ ! $SERVICE_ID_SELECTED =~ ^[0-9]+$ ]]
    then
      # send to main menu
      MAIN_MENU "Input a Valid Number."
  else
    SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED")
    # service requested not found
    if [[ -z $SERVICE_NAME ]]
      then
        # send to main menu
        MAIN_MENU "I could not find that service. What would you like today?"
    else
      echo -e "\nWhat's your phone number?"
      read CUSTOMER_PHONE
      CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")
      if [[ -z $CUSTOMER_NAME ]]
        then
          echo -e "\nI don't have a record of that phone number.\nYour Name please"
          read CUSTOMER_NAME
          # add customer to database
          INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
      fi
      echo -e "\nWhat time would you like your $SERVICE_NAME, $CUSTOMER_NAME?" | sed 's/  / /'
      read SERVICE_TIME
      # add new appointment
      CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
      INSERT_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")
      echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME." | sed 's/  / /'
    fi
  fi
}

MAIN_MENU
