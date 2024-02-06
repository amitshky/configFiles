# customizing prompt
git_branch_for_prompt() {
	git rev-parse --abbrev-ref HEAD 2> /dev/null
}

PROMPT_PURPLE='\[\033[0;35m'
PROMPT_GREEN='\[\033[0;32m'
PROMPT_CLEAR_COLOR='\[\033[0m\]'
PS1="${PROMPT_PURPLE}[ \\w]${PROMPT_GREEN}( \$(git_branch_for_prompt))\\n\\$ ${PROMPT_CLEAR_COLOR}"

