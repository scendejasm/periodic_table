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
      ATOMIC_NUMBER="$(PSQL "SELECT atomic_number FROM elements WHERE name='$1';")"
    fi
  fi
  if [[ -z $ATOMIC_NUMBER ]]
  then
  # print "I could not find that element in the database"
    echo -e "\nSorry, we couldn't find that element in the database.\n"
  else
    echo -e "\nAtomic number is $ATOMIC_NUMBER\n"
  fi
  # if atomic number not found
fi

#TODO: handle Symbol input
#TODO: handle Element Name input

#TODO: crate a function to parse out Elemental info