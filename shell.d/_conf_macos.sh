#!/bin/bash

encrypt() {
	passwd=$(pwqgen)
	7zz a -p$passwd $1.zip $1
	echo "password = $passwd"
}

notify() {
  osascript -e "display notification \"$1\" with title \"Notification\""
}

# Move last screenshot in current folder with $1 name
function sc() {
  last=$(/bin/ls -t ~/Desktop/ | head -n 1)
  mv ~/Desktop/"$last" $1
}
