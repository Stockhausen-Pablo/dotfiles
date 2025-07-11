# ~/.bash_logout: executed by bash(1) when login shell exits.

# read all history lines not already read from the history file and append them to the history list
history -n

clear

# when leaving the console clear the screen to increase privacy
if [ "$SHLVL" = 1 ]; then
    [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q
fi