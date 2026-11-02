#!/bin/bash

# Aliases
alias psx="ps auxwf | grep "
alias ipt="sudo /sbin/iptables"
alias ipr="ip route show"
alias ipa="ip --brief addr show"
alias ipl="ip link show"
alias ipg="ip route get"
alias aiz="apt-cache search . | fzf | cut -d' ' -f1 | xargs sudo apt-get install"
alias ts="tail -f /var/log/syslog"
alias ssns="ps -o pid,netns -ax|grep '^[0-9 ]\+$'|sort -k2|uniq -f1|awk '{print $1}'|while read a; do nsenter -n -t $a ss -lptn; done"
## dmesg with readable time
alias dmesg='dmesg -T'
alias mountc="mount|column -t"
alias ip='ip --color'
alias ipb='ip --color --brief'

# Functions
otcp() {
    echo "Omitting 127.0.0.1"
    sudo netstat -ltpn | tail -n +3 | grep -v 127.0.0.1
}

oudp() {
    echo "Omitting 127.0.0.1"
    sudo netstat -lupn | tail -n +3 | grep -v 127.0.0.1
}

gdpkg() {
	dpkg -l | grep $*
}

# Clean old kernels
clean_kernel() {
	dpkg --list | grep 'linux-image' | awk '{ print $2 }' | sort -V | sed -n '/'"$(uname -r | sed "s/\([0-9.-]*\)-\([^0-9]\+\)/\1/")"'/q;p' | xargs sudo apt-get -y purge
	dpkg --list | grep 'linux-headers' | awk '{ print $2 }' | sort -V | sed -n '/'"$(uname -r | sed "s/\([0-9.-]*\)-\([^0-9]\+\)/\1/")"'/q;p' | xargs sudo apt-get -y purge
}

# Easy way to mount iso
miso() {
	dev=$1
	if [ $# -ge 2 ]; then
		dest=$2
	else
		dest="/mnt/iso"
	fi
	sudo mount -t iso9660 $dev $dest
}
