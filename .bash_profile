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

# MacPorts
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
export MANPATH="/opt/local/share/man:$MANPATH"

# Ruby
export RUBY_DIR="/usr/local/ruby"
export PATH="$RUBY_DIR/current/bin:$PATH"
export JRUBY_HOME="$RUBY_DIR/current"

# Mysql
export MYSQL_DIR="/usr/local/mysql"
export PATH="$MYSQL_DIR/bin:$PATH"

# Postgres
export POSTGRES_DIR="/usr/local/postgres"
export PGDATA="$POSTGRES_DIR/current/data"
export PATH="$POSTGRES_DIR/current/bin:$PATH"

# Rubygems
export PATH="/Users/mike/.gem/ruby/1.8/bin:/Users/mike/projects/wieck_scripts/:$PATH"

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

##
# USAGE: call inside of a repository to search for declared dependencies.
##
function dependencies() {
  find . -name *.rb -exec egrep "gem ('|\")" {} \; | ruby -e 'puts $stdin.read.gsub(/^\s*gem/, "s.add_dependency")'
}

function sshr() {
  ssh able.wieck.com -t ssh $1
}

function mount_vm() {
  mkdir /Volumes/development
  sshfs mike@wieck-dev:/home/mike /Volumes/development -oauto_cache,reconnect,volname=Development
}

function mount_personal_vm() {
  mkdir /Volumes/development
  sshfs mike@personal-dev:/home/mike /Volumes/development -oauto_cache,reconnect,volname=Development
}

function authme()
{
  ssh $1 'cat >>.ssh/authorized_keys' <~/.ssh/id_rsa.pub
}


PROMPT_COMMAND="get_git_branch; $PROMPT_COMMAND"

# Prompt
green=$'\e[1;32m'
default_colors=$'\e[m'
PS1="\[$green\]\w\[\033[0m\]\$git_branch\[$green\] \\$\$default_colors\] "

alias ts="bundle exec thin -R config.ru -p 8080 start"

export LIVE_PATH="/home/mike/projects/ports" 
export RUBYOPT="-r~/.live.rb"
if [[ -s /Users/mike/.rvm/scripts/rvm ]] ; then source /Users/mike/.rvm/scripts/rvm ; fi

function sync_db() {
  dropdb $3; 
  createdb $3; 
  ssh $1 "pg_dump $2" | psql $3
}

export PORT_PATH="/Users/mike/projects";

# node
export PATH="/usr/local/share/npm/bin/:$PATH"
export NODE_PATH="/usr/local/lib/node/:$NODE_PATH"

export NOOK_SYNC_DIR="/Users/mike/Documents/nook/"
