alias gilog "git log"
alias gidiff "git diff"
alias girebase "git rebase"
alias gigrep "git grep"
alias gicheckout "git checkout"
alias gicherry-pick "git cherry-pick"
alias gibranch "git branch"
alias gicommit "git commit"
alias gifetch "git fetch"

function girename
    sed -ie "s/\b$argv[1]\b/$argv[2]/g" (git grep -w $argv[1] | cut -d ":" -f 1 | sort -u)
end
