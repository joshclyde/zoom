#!/usr/bin/env bash

# array commands
# "${!array[@]}"
#   list of indices {0, 1, 2, ..., x}
# "${array[$i]}"
#   specific element in array 

function zoom() {
  # this is the root of the directory tree
  ROOT="/Users/joshclyde/stuff/";

  # # z
  # #   cd into "ROOT"
  # if [ -z "$1" ]
  # then
  #   echo "🚀  Zooooooming to your home directory..."
  #   cd $ROOT
  #   return
  # fi

  if [ 0 -eq $(($#)) ]
  then
    echo "🚀  Zooooooming to $ROOT/ ..."
    cd $ROOT
    return
  fi

  shopt -s nullglob
  array=($(ls "$ROOT/"))
  shopt -u nullglob # Turn off nullglob to make sure it doesn't interfere with anything later

  # create layers
  layers=()
  for i in "${!array[@]}"
  do
    layers+=(1)
  done
  # echo "'${1}'"
  # echo "'${2}'"
  searching=true
  while [ "$searching" = true ]
  do
    # find the directory with the least amount of directories inside it
    curr_index=0
    curr_length=10000
    for i in "${!array[@]}"
    do
      shopt -s nullglob
      curr_dir=($(ls "$ROOT/${array[$i]}"))
      shopt -u nullglob # Turn off nullglob to make sure it doesn't interfere with anything later
      if [ "${#curr_dir[@]}" -lt "$curr_length" ]
      then
        curr_length=${#curr_dir[@]}
        curr_index=$i
      fi
    done

    # echo "'${!layers[$curr_index]}'"
    # check if need to go to next layer
    currFolder=`basename ${array[$curr_index]}`
    # echo "$currFolder"
    # echo "${!layers[$curr_index]}"
    # echo ""

    # for i in "${!array[@]}"
    # do
    #   echo "${array[$i]}    ${layers[$i]}"
    # done
    # echo ""
    if [[ $currFolder =~ .*${!layers[$curr_index]}.* ]]
    then
      layer=$((${layers[$curr_index]} + 1))
      # echo "add layer"
      # echo "$currFolder"
    else
      layer=${layers[$curr_index]}
    fi

    # check if the number of arguments have been fulfilled
    if [ "$layer" -ge $(($# + 1)) ]
    then
      echo "🚀  Zooooooming to $ROOT/${array[$curr_index]} ..."
      PROJ="$ROOT/${array[$curr_index]}"
      cd $PROJ
      searching=false
    else
      # tear apart directory
      shopt -s nullglob
      all_dirs=($(ls "$ROOT/${array[$curr_index]}"))
      shopt -u nullglob # Turn off nullglob to make sure it doesn't interfere with anything later"
      dirs=()
      # for each thing inside the directory
      for i in "${!all_dirs[@]}"
      do
        # if current thing is directory
        if [[ -d "$ROOT/${array[$curr_index]}${all_dirs[$i]}" ]]
        then
          array+=("${array[$curr_index]}${all_dirs[$i]}")
          layers+=("$layer")
        fi
      done
      array=( "${array[@]:0:$curr_index}" "${array[@]:$(($curr_index + 1))}" )
      layers=( "${layers[@]:0:$curr_index}" "${layers[@]:$(($curr_index + 1))}" )
      # searching=false
      thing=$(printf '%s\n' "${array[@]}")
      # echo "$thing"
    fi
  done
}