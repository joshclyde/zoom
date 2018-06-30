#!/usr/bin/env bash

function smartCommit() {
  # TODO: have a helpful man page
  if [ "$1" = "-h" ]; then
    echo "This script does smart commits :)"
    return
  fi

  # TODO: create an option to set the user's default name so they don't need to enter it every commit
  # TODO: color current user's name
  read -p "Partner (in additon to Josh): " partner
  if [ partner = "" ]; then
    people="Josh"
  else
    people="Josh and $partner"
  fi
  # TODO: grab ticket from branch name
  # TODO: color default ticket
  read -p "Ticket : " ticket

  # TODO: give the user the option to view a git diff if they forgot what changes they made
  read -p "Message: " commitMessage

  # should i automatically do the commit, or verify with them that the entire command is written right?
  echo `git commit -m "$people | $ticket | $commitMessage"`
}
