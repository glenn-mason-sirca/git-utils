#!/bin/sh
# This script will install a Git pre-push hook that prevents force pushing the master branch.
# Install in current Git repo:
# 
# Uninstall:
# rm .git/hooks/pre-push
# in each repository that you've added this to.
 
GITROOT=`git rev-parse --show-toplevel 2> /dev/null`
 
echo
echo
 
if [ "$GITROOT" == "" ]; then
	echo This does not appear to be a git repo.
	exit 1
fi
 
if [ -f "$GITROOT/.git/hooks/pre-push" ]; then
	echo There is already a pre-push hook installed. Delete it first.
	echo
	echo "    rm '$GITROOT/.git/hooks/pre-push'"
	echo
	exit 2
fi

PREPUSH_HOOK=https://raw.githubusercontent.com/glenn-mason-sirca/git-utils/master/pre-push
 
echo Downloading pre-push hook from $PREPUSH_HOOK
echo
 
curl -fL -o "$GITROOT/.git/hooks/pre-push" $PREPUSH_HOOK
if [ ! -f "$GITROOT/.git/hooks/pre-push" ]; then
	echo Error downloading pre-push script!
	exit 3
fi
 
chmod +x "$GITROOT/.git/hooks/pre-push"
 
echo "You're all set! Happy hacking!"
 
exit 0 
