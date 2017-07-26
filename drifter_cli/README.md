Drifter CLI
===========

This is a first mockup of a command-line interface for managing drifter projects. It is based on the authors' need to update the configuration files in a drifter project and updated with ideas from the issue https://github.com/liip/drifter/issues/156.

Status
------
This is work in progress.

Usage
-----

    drifter <command> option

Examples:

    drifter help
    drifter help update
    drifter update

Adding a command to the CLI
---------------------------

To write a command for the drifter CLI, create a bash script in the directory `drifter_cli`. Use the naming convention

    cmd_<commandname>.sh

Inside this file you should write at least three functions that will be called by the drifter CLI:

0. `description_<commandname>`
0. `help_<commandname>`
0. `cmd_<commandname>`

You should never execute code directly in the shell script, but wrap all your work in functions that are called from `cmd_<commandname>`

Todo
----

0. Integrate install.sh into the new drifter CLI
0. Improve code
0. Test
