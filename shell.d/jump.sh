# We prefer zoxide for jump
which zoxide > /dev/null 2>/dev/null
if [ $? -eq 0 ]; then
    eval "$(zoxide init zsh)"
    alias j=z
elif [ -f /usr/share/autojump/autojump.sh ]; then
    source /usr/share/autojump/autojump.sh
fi
