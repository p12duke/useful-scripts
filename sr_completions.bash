#!/usr/bin/env bash
_echoarg_completions()
{
    local cur="${COMP_WORDS[COMP_CWORD]}"

    # Example suggestions (you can customize this list)
		local options="$(ls $HOME/script_logs/)"
				COMPREPLY+=( $(compgen -W "${options}" -- "$cur") )
}

complete -F _echoarg_completions script_journal.sh  -v


