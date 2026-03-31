source ~/mycodespace/useful-scripts/script_journal.sh

_scj_completions()
{
    local cur="${COMP_WORDS[COMP_CWORD]}"

    # Example suggestions (you can customize this list)
		local options="$(ls ~/script_logs/)"
				COMPREPLY+=( $(compgen -W "${options}" -- "$cur") )
}

complete -F _scj_completions sr -n  sr -v


