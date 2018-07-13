#!/usr/bin/env bash

# absolute path to directory where this file is located
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DIR_CONFIG="${DIR}/config-zoom"
FILE_ROOT="${DIR_CONFIG}/root.txt"

helpManual()
{
  printf "       z      navigate to your base lerna repo"
  printf "       z -h   quick help on zoom\n"
  printf "       z -d   delete current config\n"
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


setConfigRoot()
{
  printf "You have not told zoom where your lerna repo is located.\n"
  printf "Are you currently in the base directory of your lerna repo? (y/n): "
  read yesOrNo
  if [ "$yesOrNo" = "y" ]; then
    lernaRepo=`pwd`
    echo "${lernaRepo}" > "${FILE_ROOT}"
    printf "\nLerna repo set to ${lernaRepo}\n"
  else
    printf "\nPlease navigate to your lerna repo to configure zoom\n"
  fi
  exit
}

navigateToRoot() {
  echo "🚀  Zooooooming to your lerna repo..."
  cd $ROOT
}

executeZoom()
{
  ROOT=`cat ${FILE_ROOT}`
  PACKAGES="${ROOT}"
  echo $PACKAGES

  # if no args are passed in
  if [ -z "$1" ]; then
    navigateToRoot
    exit
  fi

  shopt -s nullglob
  array=($(ls "$PACKAGES/"))
  shopt -u nullglob # Turn off nullglob to make sure it doesn't interfere with anything later

  MATCHES=()
  counter=0
  for i in "${array[@]}"
  do
    if [[ $i =~ .*$1.* && ( -z "$2" || $i =~ .*$2.* ) ]]
    then
      MATCHES+=($i)
      counter=$((counter+1))
      PROJ="$i"
    fi
  done

  if [ "$counter" -eq "0" ]
  then
    echo "None of the packages contained '$1' in their name."
    exit
  elif [ "$counter" -eq "1" ]
  then
    echo "🚀  Zooooooming to $PROJ..."
    echo $PACKAGES/$PROJ
    echo `cd $PACKAGES/$PROJ`
  else
    if [ ! -z "$2" ]
    then
      echo "$counter packages contain '$1' and '$2' in their name."
    else
      echo "$counter packages contain '$1' in their name."
    fi
    echo ""
    echo "  0 -> exit"
    counter_2=1
    for i in "${MATCHES[@]}"
    do
      echo "  $counter_2 -> $i"
      counter_2=$((counter_2+1))
    done
    read  -n 1 -p "Zoom to -> " userinput
    echo ""

    re='^[0-9]+$'
    if ! [[ $userinput =~ $re ]] ; then
      exit
    fi
    if [ "$userinput" -eq "0" ]
    then
      exit
    fi

    echo ""
    userinput=$((userinput-1))
    if [ -z "${MATCHES[$userinput]}" ]
    then
      exit
    fi
    echo "🚀  Zooooooming to ${MATCHES[$userinput]}..."
    cd $PACKAGES/${MATCHES[$userinput]}
  fi
}

# create config dir if it doesn't exist
if [ ! -d "${DIR_CONFIG}" ]; then
  mkdir "${DIR_CONFIG}"
fi

if [ "$1" = "-d" ]; then
  deleteConfig
  exit
fi

# set config if none exists
if [ ! -f "${FILE_ROOT}" ]; then
  setConfigRoot
fi

executeZoom $1 $2
