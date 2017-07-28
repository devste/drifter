# Shared functions used by more than one command

# The usage description
usage(){
    echo "
Drifter CLI - install and update drifter

Usage: ./drifter <command> [option]

Command can be
";
    for i in $CLI_COMMANDS; do
        VAR_FOR_HELP="desc_$i"
        echo "    $i - ${!VAR_FOR_HELP}";
    done
echo -en "\n";
}

# Anytime we need to abort something
echo_abort()
{
    echo -e "${RED}Aborting.${NC}"
}

# Copies all dist files to the project directory
copy_configuration(){
    echo -n -e "Copying default configuration inside the project : ${RED}"
    cp "$VIRTDIR/$REPODIR/provisioning/playbook.yml.dist" "$VIRTDIR/playbook.yml"
    cp "$VIRTDIR/$REPODIR/parameters.yml.dist" "$VIRTDIR/parameters.yml"
    cp "$VIRTDIR/$REPODIR/ansible.cfg.dist" "ansible.cfg"
    cp "$VIRTDIR/$REPODIR/Vagrantfile.dist" "Vagrantfile"
    echo -e "${GREEN}OK${NC}."
}
