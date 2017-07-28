desc_help="Display the help message.
        drifter help <command> display help on a specific command."
help_help="If you have come this far and realised that help itself is a normal command that can be called by help: congratulations :-)"

# If no option is passed to help, then we display the normal usage output,
# otherwise we print out the help to a command.
cmd_help(){
    if [ -z $CMD_OPTION ];
        then usage
        else help_cmd_help
    fi
}

# Print out the help to a specific command
help_cmd_help(){
    echo -e "\ndrifter $CMD_OPTION";
    VAR_FOR_HELP="help_$CMD_OPTION"
    echo "${!VAR_FOR_HELP}"
}
