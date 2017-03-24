function ssh-clear-figureprint
    sed -i "/^$argv[1].*\$/d" ~/.ssh/known_hosts
end
