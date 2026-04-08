alias gistash "git stash"
alias gimerge "git merge"
alias giclone "git clone"
alias gistatus "git status"
alias giclean "git clean"
alias giconfig "git config"
alias girevert "git revert"
alias giswitch "git switch"
alias girestore "git restore"
alias gilog "git log"
alias gidiff "git diff"
alias girebase "git rebase"
alias gishow "git show"
alias gigrep "git grep"
alias gicheckout "git checkout"
alias gicherry-pick "git cherry-pick"
alias gibranch "git branch"
alias giblame "git blame"
alias gicommit "git commit"
alias gifetch "git fetch"
alias gireset "git reset"
alias gipush "git push"
alias gipull "git pull"
alias giadd "git add"

function girename
    set -l files (git grep -l "$argv[1]" | sort -u)
    if test (count $files) -eq 0
        echo "No files found containing: $argv[1]"
        return 1
    end
    for file in $files
        sed -i "s/\b$argv[1]\b/$argv[2]/g" $file
    end
    echo "Replaced '$argv[1]' with '$argv[2]' in (count $files) file(s)"
end
