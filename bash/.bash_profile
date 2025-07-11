trap clear EXIT

if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

if type welcome &>/dev/null; then
    welcome
fi

[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"