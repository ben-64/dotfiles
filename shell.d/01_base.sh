#!/bin/sh

TOOLS="${TOOLS:-$HOME/Documents/tools}"
CHEATSHEETS="${CHEATSHEETS:-$HOME/Documents/cheatsheets}"

### FUNCTIONS
if_exist() {
    which $1 > /dev/null 2>/dev/null
    if [ $? -eq 0 ]; then
        eval $2
    else
        [ $# -eq 3 ] && eval $3
    fi
}

exist() {
    which $1 > /dev/null 2>/dev/null
    return $?
}

