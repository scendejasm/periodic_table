#!/bin/bash
#echo -e "\n~~~~ Periodic Table Resource Finder ~~~~\n"
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

if [[ ! $1 ]]
then
  echo -e "Please provide an element as an argument."
else
  # get atomic number 
  if [ -n "$1" ] && [ "$1" -eq "$1" ] 2>/dev/null;
  then
    ATOMIC_NUMBER="$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number=$1;")"
  else 
    if [[ ${#1} < 3 ]]
    then 
      ATOMIC_NUMBER="$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$1';")"
    else
      ATOMIC_NUMBER="$($PSQL "SELECT atomic_number FROM elements WHERE name='$1';")"
    fi
  fi
  if [[ -z $ATOMIC_NUMBER ]]
  then
  # print "I could not find that element in the database"
    echo -e "I could not find that element in the database."
  else
    SELECTED_ELEMENT=$($PSQL "SELECT e.atomic_number, e.name, e.symbol, p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius, t.type FROM elements e FULL JOIN properties p ON e.atomic_number=p.atomic_number FULL JOIN types t ON t.type_id=p.type_id WHERE e.atomic_number=$ATOMIC_NUMBER;")
    echo $SELECTED_ELEMENT | while read ATOMIC_NUMBER BAR NAME BAR SYMBOL BAR MASS BAR MELTING_POINT BAR BOILING_POINT BAR TYPE
    do
      echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
    done
  fi
  # if atomic number not found
fi

#TODO: handle Symbol input
#TODO: handle Element Name input

#TODO: crate a function to parse out Elemental info