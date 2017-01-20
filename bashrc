# User created .bashrc
# Author Adam Duke

if [ "$UNAME" == "Darwin" ]; then
  # set higher file limits
  ulimit -Sn 10240

  function disablePhotos() {
    defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool YES
  }

  # Quick way to rebuild the Launch Services database and get rid
  # of duplicates in the Open With submenu.
  alias fixopenwith='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user'
fi

if type brew &> /dev/null; then
  git_prefix=`brew --prefix git`

  #source git completion if it's there
  git_completion=$git_prefix/etc/bash_completion.d/git-completion.bash
  if [ -f $git_completion ] ; then source $git_completion; fi

  #source git prompt if it's there
  git_prompt=$git_prefix/etc/bash_completion.d/git-prompt.sh
  if [ -f $git_prompt ]; then
    source $git_prompt
    export GIT_PS1_SHOWCOLORHINTS='1'
    export GIT_PS1_SHOWDIRTYSTATE='1'
    export GIT_PS1_SHOWUPSTREAM='auto'
    export PROMPT_COMMAND='__git_ps1 "\h \[\e[0;35m\]\w\[\e[0m\]" "\\\$ "'
  fi

  #alias hub and source hub completion if it's there
  if type hub &> /dev/null; then
    alias git='hub'
    hub_completion=$git_prefix/etc/bash_completion.d/hub.bash_completion.sh
    if [ -f $hub_completion ] ; then . $hub_completion; fi
  fi
fi

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

if type nvim &> /dev/null; then
  export EDITOR=nvim
  alias vim='nvim'
else
  export EDITOR=vim
fi

#unhide ~/Library
if type chflags &> /dev/null; then
  chflags nohidden ~/Library/
fi

#add /usr/local/bin and /usr/local/sbin to the path before /usr/bin
export PATH=/usr/local/bin:/usr/local/sbin:$PATH

#add bin in user's home directory to the PATH
export PATH=$PATH:$HOME/bin

#add NODE_PATH environment variable
export NODE_PATH=/usr/local/share/npm/bin

# add NODE_PATH to the PATH for node executables
export PATH=$PATH:$NODE_PATH

# golang stuff
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

#alias section
alias ll='ls -lrthGa'
alias gs='clear && git status'
alias gbc='git branch -d `git branch --merged | grep -v master`'
alias spec='rspec'
alias be='bundle exec'

if type s3cmd &> /dev/null; then
  function giggleBytesFn() {
    s3cmd du s3://$1 | cut -d ' ' -f1 | awk '{ gb = $1 / 1024 / 1024 / 1024 ; print gb "GB" }'
  }
  alias gigglebytes=giggleBytesFn
fi

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

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

#rbenv
if type rbenv &> /dev/null; then
  eval "$(rbenv init -)"
fi

if type docker-machine &> /dev/null; then
  # docker-machine helper function
  function dm() {
    case $1 in
      recreate)
        docker-machine rm -y dev || true
        docker-machine create --driver virtualbox --virtualbox-disk-size 40000 --virtualbox-memory 5120 --virtualbox-cpu-count 2 dev
        ;;
      eval)
        running=$(which docker-machine &> /dev/null && ps -ef | grep VirtualBox | grep -v grep && docker-machine ls | grep dev)
        if [[ "$?" == "0" ]]
        then
          dm_env=$(docker-machine env dev)
          eval $dm_env
          echo $dm_env
        fi
        ;;
      up)
        docker-machine start dev && dm eval
        ;;
      down)
        docker-machine stop dev
        ;;
      status)
        docker-machine status dev
        ;;
      *)
        echo $"Usage: dm {up|down|recreate|eval|status}"
    esac
  }
fi

if type docker &> /dev/null; then
  # convenience function for resetting docker state
  function d() {
    case $1 in
      containers)
        docker stop $(docker ps -qa)
        docker rm $(docker ps -qa)
        ;;
      images)
        docker rmi $(docker images -qa)
        ;;
      implode)
        d containers
        d images
        ;;
      *)
        echo $"Usage: d {containers|images|implode}"
    esac
  }
fi

if type security &> /dev/null; then
  # https://gist.github.com/adamvduke/fe3067116edddda168e02155d9d9695f
  ### Functions for setting and getting environment variables from the OSX keychain ###
  ### Adapted from https://www.netmeister.org/blog/keychain-passwords.html ###
  # Use: keychain-environment-variable SECRET_ENV_VAR
  function keychain-environment-variable () {
    value=$(security find-generic-password -w -a ${USER} -D "environment variable" -s "${1}" 2>/dev/null)
    if [[ "$?" == "0" ]]
    then
      echo $value
    else
      echo "No value for $1" > /dev/stderr
    fi
  }

  # Use: set-keychain-environment-variable SECRET_ENV_VAR
  #   provide: super_secret_key_abc123
  function set-keychain-environment-variable () {
    cur_shell=$(ps -p $$ | awk '$1 != "PID" {print $(NF)}')

    [ -n "$1" ] || print "Missing environment variable name"

    if [ "$cur_shell" = "-bash" ]; then
      read -sp "Enter Value for ${1}: " secret
    fi
    if [ "$cur_shell" = "zsh" ]; then
      read -s "?Enter Value for ${1}: " secret
    fi

    ( [ -n "$1" ] && [ -n "$secret" ] ) || return 1
    security add-generic-password -U -a ${USER} -D "environment variable" -s "${1}" -w "${secret}"
  }

  export AWS_ACCESS_KEY_ID=$(keychain-environment-variable AWS_ACCESS_KEY_ID)
  export AWS_SECRET_ACCESS_KEY=$(keychain-environment-variable AWS_SECRET_ACCESS_KEY)
fi

# if fzf exists, then source it
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# if bashrc.local exists, then source it
[ -f ~/.bashrc.local ] && source ~/.bashrc.local
