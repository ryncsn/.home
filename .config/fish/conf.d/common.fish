alias .. "cd .."
alias ... "cd ../.."
alias .... "cd ../../.."
alias ..... "cd ../../../.."

alias la "ls -Gla"

alias lsd 'ls -l | grep "^d"'
alias ls 'ls --color="auto"'
alias ll 'ls -ahlF'
alias l 'ls -CF'

alias grepc 'grep --color="always"'
alias lessc 'less -R'

set -x -g PATH /usr/local/bin $PATH
set -x -g PATH /usr/local/sbin $PATH
set -x -g PATH $HOME/.local/bin $PATH
set -x -g PATH $HOME/.local/sbin $PATH
