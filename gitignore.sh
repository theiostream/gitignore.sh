#!/bin/bash

# gitignore.sh! The best way to have your quick gitignore templates placed!
# All templates are by the folks who contributed to http://github.com/github/gitignore

function printUsage {
	echo "
	USAGE:
	gitignore.sh -n [NAME-OF-TEMPLATE] -> gets template to current directory.
	gitignore.sh -a [FILE-TO-IGNORE] [ANOTHER-FILE] ... -> creates .gitignore file on current directory with specified parameters.
	
	-r -> Remove current .gitignore on directory.
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

if [ "$1" = "-r" ]; then
	rm -f `pwd`/.gitignore
fi

if [ "$1" = "-a" ]; then
	if [ "$2" = "" ]; then
		printUsage
	fi
	
	for arg in $@; do
		if [ $arg = "-a" ]; then
			continue
		fi
		
		if [ -e "`pwd`/.gitignore" ]; then
			echo "`cat .gitignore`
$arg">.gitignore
		else
			echo "$arg">.gitignore
		fi
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
			# echo "OSX might hide your .gitignore files on Finder. But they are there."
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