# Description of this command
desc_update="Updates the drifter configuration in your project"
help_update="
Updates the configuration files in your project directory from new dist files
in drifter. Overwrites your existing configuration, so you will have to 
manually correct differences.

The command checks the git status of your project configuration files and will
refuse to overwrite them if they are not in a clean state.
"

cmd_update(){
    update_check_files;
    update_check_file_git_status;
    update_ask_permission;
    copy_configuration;
}

# This variable needs linebreaks to work in a for loop
UPDATE_FILES="$VIRTDIR/playbook.yml
$VIRTDIR/parameters.yml
ansible.cfg
Vagrantfile"

# Check if we have the files to update. If not: drifter is probably not
# installed.
update_check_files(){
for i in $UPDATE_FILES; do
        if [ ! -e $i ]
        then
                echo -e "${RED}$i${NC} does not exist. Aborting update. Please install drifter first."
                exit 1
        fi
done
}

# Check if the files are clean in git. If not we'd overwrite uncommitted 
# edits, which could lead to surprises.
update_check_file_git_status(){
for i in $UPDATE_FILES; do
        GIT_STATUS_FILE=`git status --porcelain $i`
        if [ "$GIT_STATUS_FILE" != "" ]
        then
                echo -e "${RED}$i${NC} has a non-clean git status. Aborting update"
                exit 1
        fi
done
}

## Ask the person if they really want to update the configuration files.
update_ask_permission(){
echo "About to update the configuration files. You will have to manually review changes.\n"
read -p "Do you want to update the configuration files? [yN] " update
case $update in
        Y|y ) update_configuration; exit 0;;
        N|n|"" ) echo_abort; exit 1;;
        * ) echo "Please answer yes or no.";;
esac
}

