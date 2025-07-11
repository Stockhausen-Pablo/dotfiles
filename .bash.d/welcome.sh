welcome(){
    if type -P welcome &>/dev/null; then
        command welcome
    elif type -P welcome.py &>/dev/null; then
        welcome.py
    fi
}

# Use bash version by default
alias welcome=bash_welcome

bash_welcome(){
    # Get last login info, fallback if not available
    local last_access
    last_access=$(last | head -n2 | tail -n1 | sed 's/[^ ]\+ \+[^ ]\+ \+[^ ]\+ \+//;s/ *$//')
    [[ -z "$last_access" ]] && last_access="No previous login found"

    local uptime_info="UPTIME: $(uptime -p)"
    local msg="Welcome - your last access was $last_access | $uptime_info"
    local charmap="!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_\`abcdefghijklmnopqrstuvwxyz{|}~ \t\n"

    local color_on="\033[1;33m"      # Yellow for welcome
    local color_pipe="\033[0;30m"    # Black for pipe
    local color_uptime="\033[1;36m"  # Bold cyan for uptime
    local color_off="\033[0m"

    # Find where uptime_info starts in msg
    local uptime_start
    uptime_start=$(awk -v a="$msg" -v b="$uptime_info" 'BEGIN{print index(a,b)-1}')

    printf "$color_on"
    for ((i=0; i<${#msg}; i++)); do
        # Switch color at the start of uptime_info
        if [[ $i -eq $uptime_start ]]; then
            printf "$color_off$color_uptime"
        fi
        local char="${msg:i:1}"
        # Print pipe in black
        if [[ "$char" == "|" ]]; then
            printf "$color_off$color_pipe|$color_off"
            continue
        fi
        printf " "
        local j=0
        while true; do
            local out_char
            if [ $j -gt 2 ]; then
                out_char=$char
            else
                out_char=${charmap:$((RANDOM%${#charmap})):1}
            fi
            printf "\\b%s" "$out_char"
            sleep 0.0005
            [ "$out_char" = "$char" ] && break
            ((j+=1))
        done
    done
    printf "$color_off\n"
}