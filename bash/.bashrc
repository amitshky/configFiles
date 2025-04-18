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

alias ll="ls -al"
alias lg="lazygit"
alias notes="nvim ~/documents/ObsidianVaults/_Obsidian"

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    alias nvim="~/downloads/nvim-linux-x86_64/bin/nvim" # this is temporary
elif [[ "$OSTYPE" == "msys" ]]; then # git-bash on windows
    alias mvim="NVIM_APPNAME=nvim-myconfig nvim --clean -u ~/AppData/Local/nvim-myconfig/minimal.lua" # minimal nvim config
    alias kvim="NVIM_APPNAME=nvim-myconfig nvim --clean -u ~/AppData/Local/nvim-myconfig/kickstart.lua"
    alias mynvim="NVIM_APPNAME=nvim-myconfig nvim"
fi

# customizing prompt
git_branch_for_prompt() {
    git rev-parse --abbrev-ref HEAD 2> /dev/null
}

PROMPT_PURPLE='\[\033[0;35m'
PROMPT_GREEN='\[\033[0;32m'
PROMPT_CLEAR_COLOR='\[\033[0m\]'
PS1="${PROMPT_PURPLE}[ \\w]${PROMPT_GREEN}( \$(git_branch_for_prompt))\\n\\$ ${PROMPT_CLEAR_COLOR}"

# vulkan env variables
source ~/VulkanSDK/1.3.275.0/setup-env.sh

export MOZ_ENABLE_WAYLAND=1
. "$HOME/.cargo/env"

export DOTNET_ROOT=$HOME/.dotnet
export PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools
