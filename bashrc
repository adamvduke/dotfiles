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

#add NODE_PATH environment variable
export NODE_PATH=/usr/local/lib/node

#add bin in user's home directory to the PATH
export PATH=$PATH:~/bin

#add glassfish's bin directory to the PATH
export PATH=$PATH:~/Applications/glassfish3/bin

#add appengine sdk's bin directory to the PATH
export PATH=$PATH:~/.m2/repository/com/google/appengine/appengine-java-sdk/1.4.3/appengine-java-sdk-1.4.3/bin

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
