#!/bin/bash

# gitignore.sh! The best way to have your quick gitignore templates placed!
# All templates are by the folks who contributed to http://github.com/github/gitignore

function printUsage {
	echo "
	gitignore.sh -- USAGE:
	gitignore.sh -n [NAME-OF-TEMPLATE]
	
	-u -> Update git repository
	-i -> Display available templates
	-h -> Display this help text.
	"
}

if [ "$1" = "" ]; then
	printUsage
fi

if [ "$1" = "-h" ]; then
	printUsage
fi

if [ "$1" = "-i" ]; then
	for f in ~/Library/gitignore/*; do
		FILENAME=${f##*/gitignore/}
		echo ${FILENAME%%.*}
	done
fi

if [ "$1" = "-n" ]; then
	if [ "$2" = "" ]; then
		printUsage
	else
		SUCCESSFUL=0
		
		for f in ~/Library/gitignore/*; do
			FILENAME=${f##*/gitignore/}
			if [ ${FILENAME%%.*} = $2 ]; then
				cp ~/Library/gitignore/$FILENAME `pwd`
				mv -v `pwd`/$FILENAME `pwd`/.gitignore
				SUCCESSFUL=1
				break
			fi
		done
		
		if [ $SUCCESSFUL = 1 ]; then
			echo "Moved template $2.gitignore to `pwd`"
			echo "OSX might hide your .gitignore files on Finder. But they are there."
		else
			echo "No template $2 found."
		fi
	fi
fi

if [ "$1" = "-u" ]; then
	cd ~/Library/gitignore
	git pull
	mv -v ./Global/* .
	rm -rf ./Global
fi