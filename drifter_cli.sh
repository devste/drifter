#!/bin/bash

# Drifter Command Line Interface. Helps installing and updating drfiter.
# TODO: This is only work in progress (WIP) based off the idea in
# https://github.com/liip/drifter/issues/156
# See drifter_cli/README.md for more details.

if [ -z $CLIDIR ] ;
    then CLILIBDIR="drifter_cli"
    else CLILIBDIR="$CLIDIR/drifter_cli"
fi

# Load shared files
for i in `ls ${CLILIBDIR}/_*.sh`; do
    source $i;
done

# Load commands
for i in `ls ${CLILIBDIR}/cmd_*.sh`; do
    source $i;
done

# TODO: automate this bit by parsing the file names 'drifter_cli/cmd_*.sh'
# With several values: CLI_COMMANDS="install update"
CLI_COMMANDS="update"

COMMAND=$1;
CMD_OPTION=$2;

# In order to use the list of commands in the following case, extended
# globbing has to be used.
shopt -s extglob
CLI_COMMANDS_FOR_CASE="@(`echo $CLI_COMMANDS | sed 's/\ /\|/g'`)"

case $COMMAND in
    $CLI_COMMANDS_FOR_CASE ) cmd_$COMMAND;;
    help )
        if [ -n $CMD_OPTION ] ; then help_$CMD_OPTION ; fi
        if [ -z $CMD_OPTION ] ; then usage ; fi
        ;;
    * ) usage; exit 1;;
esac

