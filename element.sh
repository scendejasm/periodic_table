#!/bin/bash
#echo -e "\n~~~~ Periodic Table Resource Finder ~~~~\n"

if [[ ! $1 ]]
then
  echo -e "Please provide an element as an argument."
else
  # get atomic number 
  if [[ $1 =~ '^[0-9]+$' ]]
  then
    echo -e "Yes $1 is a number"
  fi
# if atomic number not found
# print "I could not find that element in the database"
fi