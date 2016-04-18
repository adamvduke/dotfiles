# User created .bashrc
# Author Adam Duke

# set higher file limits
ulimit -Sn 8192

#mperham's git completion/colors
git_completion=`brew --prefix git`/etc/bash_completion.d/git-completion.bash
if [ -f $git_completion ] ; then source $git_completion; fi

source `brew --prefix git`/etc/bash_completion.d/git-prompt.sh
export GIT_PS1_SHOWCOLORHINTS='1'
export GIT_PS1_SHOWDIRTYSTATE='1'
export GIT_PS1_SHOWUPSTREAM='auto'
export PROMPT_COMMAND='__git_ps1 "\[\e[0;35m\]\w\[\e[0m\]" "\\\$ "'

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

if type nvim &> /dev/null; then
  export EDITOR=nvim
else
  export EDITOR=vim
fi

#unhide ~/Library
chflags nohidden ~/Library/

#add /usr/local/bin and /usr/local/sbin to the path before /usr/bin
export PATH=/usr/local/bin:/usr/local/sbin:$PATH

#add bin in user's home directory to the PATH
export PATH=$PATH:~/bin

#add NODE_PATH environment variable
export NODE_PATH=/usr/local/share/npm/bin

# add NODE_PATH to the PATH for node executables
export PATH=$PATH:$NODE_PATH

#alias section
alias ll='ls -lrthGa'
alias gs='clear && git status'
alias spec='rspec'
alias be='bundle exec'

# Quick way to rebuild the Launch Services database and get rid
# of duplicates in the Open With submenu.
alias fixopenwith='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user'

alias removeswpfiles='find ~/.vim -name "*.swp" -exec rm {} ";"'

# history stuff
# Append to the history file, don't overwrite it
shopt -s histappend

# Save multi-line commands as one command
shopt -s cmdhist

# Huge history. Doesn't appear to slow things down, so why not?
HISTSIZE=500000
HISTFILESIZE=100000

# Avoid duplicate entries
HISTCONTROL="erasedups:ignoreboth"

# Don't record some commands
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"

# Useful timestamp format
HISTTIMEFORMAT='%F %T '

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

#rbenv
eval "$(rbenv init -)"

#docker-machine
function eval_docker_machine_env() {
  docker_running=$(which docker-machine && ps -ef | grep VirtualBox | grep -v grep && docker-machine ls | grep dev)
  if [[ "$?" == "0" ]]
  then
    eval "$(docker-machine env dev)"
  fi
}

function docker_machine_up() {
  docker-machine start dev && eval_docker_machine_env
}

function docker_machine_down() {
  docker-machine stop dev
}

eval_docker_machine_env

#convenience functions for resetting docker state
function remove_docker_containers() {
  docker stop $(docker ps -qa)
  docker rm $(docker ps -qa)
}

function remove_docker_images() {
  docker rmi $(docker images -qa)
}

function scorch_docker() {
  remove_docker_containers
  remove_docker_images
}

# if fzf exists, then source it
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# if bashrc.local exists, then source it
[ -f ~/.bashrc.local ] && source ~/.bashrc.local
