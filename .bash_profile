export HISTCONTROL=erasedups
export HISTSIZE=10000
shopt -s histappend
export EDITOR=nano
export GIT_EDITOR=nano
export RAILS_ENV=development
export ENVIRONMENT=development
export CLICOLOR=1

export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"
export PATH="/usr/local/bin:$PATH"

# Functions
function get_git_branch {
 local dir=. head
 until [ "$dir" -ef / ]; do
   if [ -f "$dir/.git/HEAD" ]; then
     head=$(< "$dir/.git/HEAD")
     if [[ $head == ref:\ refs/heads/* ]]; then
       git_branch=" ${head##*/}"
     elif [[ $head != '' ]]; then
       git_branch=' (detached)'
     else
       git_branch=' (unknown)'
     fi
     return
   fi
   dir="../$dir"
 done
 git_branch=''
}

PROMPT_COMMAND="get_git_branch; $PROMPT_COMMAND"

# Prompt
green=$'\e[1;32m'
default_colors=$'\e[m'
PS1="\[$green\]\w\[\033[0m\]\$git_branch\[$green\] \\$\$default_colors\] "
