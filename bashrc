# User created .bashrc
# Author Adam Duke

#source .git-completion
source ~/.git-completion.bash

#set Maven environment variables
export MAVEN_OPTS="-Xmx512M -XX:MaxPermSize=128M"

#add /usr/local/bin and /usr/local/sbin to the path before /usr/bin
export PATH=/usr/local/bin:/usr/local/sbin:$PATH

#add bin in user's home directory to the PATH
export PATH=$PATH:~/bin

#add NODE_PATH environment variable
export NODE_PATH=/usr/local/share/npm/bin

# add NODE_PATH to the PATH for node executables
export PATH=$PATH:$NODE_PATH

#alias section
alias ls='ls -la'
alias gs='clear && git status'
alias spec='rspec'

# Quick way to rebuild the Launch Services database and get rid
# of duplicates in the Open With submenu.
alias fixopenwith='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user'

# history stuff
HISTCONTROL=ignoreboth
HISTFILESIZE=10000
HISTSIZE=10000

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# adding rvm
[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm

