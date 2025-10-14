# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

export PATH="/opt/NetLogo-7.0.0/bin:$PATH"

export EDITOR="nvim"
export VISUAL="nvim"
# enable bat to colorize man pages
export MANPAGER="sh -c 'awk '\''{ gsub(/\x1B\[[0-9;]*m/, \"\", \$0); gsub(/.\x08/, \"\", \$0); print }'\'' | bat -p -lman'"

# customizing prompt
git_branch_for_prompt() {
    git rev-parse --abbrev-ref HEAD 2>/dev/null
}

PROMPT_PURPLE='\[\033[0;35m'
PROMPT_GREEN='\[\033[0;32m'
PROMPT_CLEAR_COLOR='\[\033[0m\]'
PS1="${PROMPT_PURPLE}[ \\w]${PROMPT_GREEN}( \$(git_branch_for_prompt))\\n\\$ ${PROMPT_CLEAR_COLOR}"

alias ll="ls -al"
alias lg="lazygit"
# alias notes="nvim ~/documents/ObsidianVaults/_Obsidian"
alias t="./tmux.sh"
alias n="nvim ."
alias w="cd ~/dev-work/dgCloudAppV2/"
alias wd="cd /mnt/windows/Users/almostblue/Documents/work/"
alias wo="cd ~/documents/_Obsidian/"
alias wu="cd ~/documents/uniNotesObsidian/"
alias cat="bat" # use \cat to override this alias and use the actual cat command

alias spotify="flatpak run com.spotify.Client"

# yazi
function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}
. "$HOME/.cargo/env"
