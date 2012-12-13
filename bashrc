# User created bashrc
# Author Adam Duke

#source .git-completion
source ~/.git-completion.bash

#set Textmate as the default EDITOR
export EDITOR='mate -w'

#set Maven environment variables
export MAVEN_OPTS="-Xmx512M -XX:MaxPermSize=128M"

#add /usr/local/bin and /usr/local/sbin to the path before /usr/bin
export PATH=/usr/local/bin:/usr/local/sbin:$PATH

#add bin in user's home directory to the PATH
export PATH=$PATH:~/bin

#add NODE_PATH environment variable
export NODE_PATH=/usr/local/lib/node_modules

# add NODE_PATH to the PATH for node executables
export PATH=$PATH:$NODE_PATH

#alias section
alias ls='ls -la'
alias gs='clear && git status'
alias spec='rspec'

# history stuff
HISTCONTROL=ignoreboth
HISTFILESIZE=10000
HISTSIZE=10000

# adding rvm
[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm
