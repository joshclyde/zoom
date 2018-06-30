#!/usr/bin/env bash

# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

function smartCommit() {
  # TODO: have a helpful man page
  if [ "$1" = "-h" ]; then
    echo "This script does smart commits :)"
    return
  fi

  # get branch name
  branch="$(git symbolic-ref --short HEAD)"
  # seperate branch into array delimited by /
  IFS='/'; branchArray=($branch); unset IFS;
  # get the last element in branchArray
  ticketFound=${branchArray[${#branchArray[@]}-1]}

  printf "        You: ${Green}Josh${Color_Off}\n"
  printf "     Ticket: ${Green}${ticketFound}${Color_Off}\n"
 
  printf "Partner(s)?: ${Yellow}"
  read partner
 
  printf "${Color_Off}    Ticket?: ${Yellow}"
  read ticketInput

  printf "${Color_Off}    Message: ${Yellow}"
  read message
  printf "${Color_Off}"

  echo ""

  if [ -z "$partner" ]; then
    people="Josh"
  else
    people="Josh, $partner"
  fi

  if [ -z "$ticketInput" ]; then
    ticket=$ticketFound
  else
    ticket=$ticketInput
  fi

  if [ -z "$message" ]; then
    printf "${Red}ERROR${Color_Off}: message is required\n"
    return
  fi

  echo "git commit -m \"$people | $ticket | $message\""
  echo `git commit -m "$people | $ticket | $message"`
}
