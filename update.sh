#!/bin/bash

# This script updates the project configuration from the drifter templates.
# Use case: submodule drifter was updated and you want to use new features of drifter. 
#
# Updated configuration files should be reviewed manually.
#
# TODO: extract code copied from install.sh into common base configuration and
# adjust install.sh as well as update.sh to use the new base.

BASE=$(pwd)
VIRTDIR="virtualization"
REPODIR="drifter"

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo_abort()
{
      echo -e "${RED}Aborting.${NC}"
}


# This variable needs linebreaks to work in a for loop
UPDATE_FILES="$VIRTDIR/playbook.yml
$VIRTDIR/parameters.yml
ansible.cfg
Vagrantfile"

# The actual method to update the configuration files
update_configuration()
{
	echo -n -e "Copying default configuration inside the project : ${RED}"
	cp "$VIRTDIR/$REPODIR/provisioning/playbook.yml.dist" "$VIRTDIR/playbook.yml"
	cp "$VIRTDIR/$REPODIR/parameters.yml.dist" "$VIRTDIR/parameters.yml"
	cp "$VIRTDIR/$REPODIR/ansible.cfg.dist" "ansible.cfg"
	cp "$VIRTDIR/$REPODIR/Vagrantfile.dist" "Vagrantfile"
	echo -e "${GREEN}OK${NC}."
}

# First we check if the files to update exist.
for i in $UPDATE_FILES; do
	if [ ! -e $i ]
	then
		echo -e "${RED}$i${NC} does not exist. Aborting update. Please install drifter first."
		exit 1
	fi
done

# Then we check if the files have a clean git state (ie committed and not modified)
for i in $UPDATE_FILES; do
	GIT_STATUS_FILE=`git status --porcelain $i`
	if [ "$GIT_STATUS_FILE" != "" ]
	then
		echo -e "${RED}$i${NC} has a non-clean git status. Aborting update"
		exit 1
	fi
done

# Then get permission to update configuration files
echo "About to update the configuration files. You will have to manually review changes.\n"
read -p "Do you want to update the configuration files? [yN] " update
case $update in
	Y|y ) update_configuration; exit 0;;
	N|n|"" ) echo_abort; exit 1;;
	* ) echo "Please answer yes or no.";;
esac
