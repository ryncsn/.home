alias .. "cd .."
alias ... "cd ../.."
alias .... "cd ../../.."
alias ..... "cd ../../../.."

alias ls 'ls --color=always'
alias lsd 'ls -l | grep "^d"'
alias ll 'ls -ahlF'
alias l 'ls -CF'
alias la "ls -Gla"

alias grepc 'grep --color="always"'
alias lessc 'less -R'

set -x -g PATH /usr/local/bin $PATH
set -x -g PATH /usr/local/sbin $PATH
set -x -g PATH $HOME/.local/bin $PATH
set -x -g PATH $HOME/.local/sbin $PATH
