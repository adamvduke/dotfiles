#! /bin/sh

DIRECTORY=$(cd `dirname $0` && pwd)

if [[ -e ~/.bash_profile && ! -L ~/.bash_profile ]];then
	mv ~/.bash_profile $DIRECTORY/backup/bash_profile.bak
	rm ~/.bash_profile
fi

if [[ -e ~/.bashrc && ! -L ~/.bashrc ]];then
	mv ~/.bashrc $DIRECTORY/backup/bashrc.bak
	rm ~/.bashrc
fi

if [[ -e ~/.gitconfig && ! -L ~/.gitconfig ]];then
	mv ~/.gitconfig $DIRECTORY/backup/gitconfig.bak
	rm ~/.gitconfig
fi

if [[ -e ~/.gitignore && ! -L ~/.gitignore ]];then
	mv ~/.gitignore $DIRECTORY/backup/gitignore.bak
	rm ~/.gitignore
fi

if [ -e /usr/local/etc/bash_completion.d/git-completion.bash ]; then
	if [[ -e ~/.git-completion.bash && ! -L ~/.git-completion.bash ]];then
		mv ~/.git-completion.bash $DIRECTORY/backup/git-completion.bash.bak
		rm ~/.git-completion.bash		
	fi
fi

ln -s $DIRECTORY/bash_profile ~/.bash_profile
ln -s $DIRECTORY/bashrc ~/.bashrc
ln -s $DIRECTORY/gitconfig ~/.gitconfig
ln -s $DIRECTORY/gitignore ~/.gitignore
ln -s /usr/local/etc/bash_completion.d/git-completion.bash ~/.git-completion.bash
