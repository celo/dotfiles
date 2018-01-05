#
# ~/.bashrc
#

[[ $- != *i* ]] && return

colors() {
	local fgc bgc vals seq0

	printf "Color escapes are %s\n" '\e[${value};...;${value}m'
	printf "Values 30..37 are \e[33mforeground colors\e[m\n"
	printf "Values 40..47 are \e[43mbackground colors\e[m\n"
	printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

	# foreground colors
	for fgc in {30..37}; do
		# background colors
		for bgc in {40..47}; do
			fgc=${fgc#37} # white
			bgc=${bgc#40} # black

			vals="${fgc:+$fgc;}${bgc}"
			vals=${vals%%;}

			seq0="${vals:+\e[${vals}m}"
			printf "  %-9s" "${seq0:-(default)}"
			printf " ${seq0}TEXT\e[m"
			printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
		done
		echo; echo
	done
}

[[ -f ~/.extend.bashrc ]] && . ~/.extend.bashrc

[ -r /usr/share/bash-completion/bash_completion   ] && . /usr/share/bash-completion/bash_completion

if [ -f /usr/share/bash-completion/bash_completion ] && ! shopt -oq posix; then
   . /usr/share/git/completion/git-completion.bash
fi

function_exists() {
    declare -f -F $1 > /dev/null
    return $?
}
for al in `__git_aliases`; do
    alias g$al="git $al"

    complete_func=_git_$(__git_aliased_command $al)
    function_exists $complete_fnc && __git_complete g$al $complete_func
done


# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
# export PS1="\[\e[1m\]\[\033[32m\][\u@\h \[\033[00m\]\[\e[1m\]\W\[\033[32m\]]\[\e[0m\]\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "
export PS1="\[\033[01;32m\][\u@\h\[\033[01;37m\] \W\[\033[01;32m\]]\[\033[33m\]\$(parse_git_branch)\[\033[01;32m\]$\[\033[00m\] "

alias subl='subl3'
alias sublime='subl3'
alias la='ls -a'