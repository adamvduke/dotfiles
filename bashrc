# User created .bashrc
# Author Adam Duke

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

export EDITOR=vim

#unhide the ~/Library
chflags nohidden ~/Library/

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
alias be='bundle exec'

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

