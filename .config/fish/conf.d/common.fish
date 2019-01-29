alias .. "cd .."
alias ... "cd ../.."

alias la "ls -Gla"

# List only directories
alias lsd 'ls -l | grep "^d"'

alias ls 'ls --color="auto"'
alias ll 'ls -ahlF'
alias l 'ls -CF'

alias grepc 'grep --color="always"'

set -x -g PATH /usr/local/bin $PATH
set -x -g PATH /usr/local/sbin $PATH
