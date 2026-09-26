function fish_prompt
    set -l red (set_color red)
    set -l white (set_color --bold white)
    set -l reset (set_color normal)

    set -l exit_code ''
    if test $status -ne 0
        set exit_code "[$white$status$reset$red]"
    end

    set -l git_info ''
    if set -l branch (git branch --show-current 2>/dev/null)
        set -l git_color "$white"
        if not git diff --quiet 2>/dev/null || not git diff --cached --quiet 2>/dev/null
            set git_color "$red"
        end
        set git_info " [$git_color$branch$reset$red]"
    end

    set -l tty_name "$TTY"
    set -l time_str (date +%H:%M)

    printf '%s\n' "$red┌[$white$USER$reset$red@$white$hostname$reset$red] [$white/dev/$tty_name$reset$red] [$white$time_str$reset$red]$git_info $exit_code"
    printf '%s ' "$red└[$white$pwd$reset$red]>$reset"
end
