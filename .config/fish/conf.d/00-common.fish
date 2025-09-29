alias .. "cd .."
alias ... "cd ../.."
alias .... "cd ../../.."
alias ..... "cd ../../../.."

alias la 'ls -al'
alias ll 'ls -ahlF'
alias l 'ls -CF'

alias grepc 'grep --color="always"'
alias lessc 'less -R'

for _PATH in \
	/usr/local/bin \
	/usr/local/sbin \
	$HOME/.local/bin \
	$HOME/.local/sbin \
	/home/linuxbrew/.linuxbrew/bin \
	/opt/homebrew/opt/*/libexec/gnubin \
	;
	test -d $_PATH || continue
	set -xg PATH $_PATH $PATH
end

set -xg SHELL fish
