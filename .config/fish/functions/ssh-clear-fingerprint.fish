function ssh-clear-fingerprint
    ssh-keygen -f ~/.ssh/known_hosts -R $argv[1]
end
