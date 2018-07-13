#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

alias smartcommit="${DIR}/smartcommit.sh"
alias c="${DIR}/smartcommit.sh"

# zoom is in a function instead of an alias because it wouldn't allow the script to execute cd when it wasn't a function
function zoom() {
  . "${DIR}/zoom.sh"
}
alias z="zoom"
