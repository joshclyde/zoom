#!/usr/bin/env bash

# colors
ColorOff='\033[0m'        # Text Reset
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

# absolute path to directory where this file is located
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DIR_CONFIG="${DIR}/configSmartcommit"
FILE_NAME="${DIR_CONFIG}/name.txt"

helpManual()
{
  printf "       smartcommit      create and then execute commit\n"
  printf "       smartcommit -h   quick help on smartcommit\n"
  printf "       smartcommit -d   delete current config\n"
}

deleteConfig()
{
  printf "Delete current config (y/n): "
  read yesOrNo
  if [ "$yesOrNo" = "y" ]; then
    rm -rf "${DIR_CONFIG}"
    printf "Configs removed\n"
  else
    printf "Nothing happened\n"
  fi
}

setConfig()
{
  printf "        You: "
  read nameInput
  echo "${nameInput}" > "${FILE_NAME}"
  printf "\n"
}

createMessage()
{
  # get developer name
  name=`cat ${FILE_NAME}`
  # get branch name
  branch=`git symbolic-ref --short HEAD`
  # seperate branch into array delimited by /
  IFS='/'; branchArray=($branch); unset IFS;
  # get the last element in branchArray
  branchTicket=${branchArray[${#branchArray[@]}-1]}

  printf "        You: ${name}\n"
  printf "     Ticket: ${branchTicket}\n"

  printf "Partner(s)?: "
  read partner

  printf "    Ticket?: "
  read ticketInput

  printf "    Message: "
  read message
  echo ""

  if [ -z "$message" ]; then
    printf "${Red}ERROR${ColorOff}: message is required\n"
    exit
  fi

  people=$([ -z "$partner" ] && echo "${name}" || echo "${name}, $partner")
  ticket=$([ -z "$ticketInput" ] && echo "$branchTicket" || echo "$ticketInput")

  printf "git commit -m \"$people | $ticket | $message\"\n"
  echo `git commit -m "$people | $ticket | $message"`
}

# create config dir if it doesn't exist
if [ ! -d "${DIR_CONFIG}" ]; then
  mkdir "${DIR_CONFIG}"
fi

if [ "$1" = "-h" ]; then
  helpManual
  exit
fi

if [ "$1" = "-d" ]; then
  deleteConfig
  exit
fi

# force user to enter name if no config exists
if [ ! -f "${FILE_NAME}" ]; then
  setConfig
fi

createMessage
