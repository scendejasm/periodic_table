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
    echo -e "\nAtomic number is $ATOMIC_NUMBER\n"
  else
    echo not a number
  fi
  # if atomic number not found
  # print "I could not find that element in the database"
fi

#TODO: crate a function to parse out Elemental info
#TODO: handle Symbol input
#TODO: handle Element Name input
