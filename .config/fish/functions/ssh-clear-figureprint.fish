function ssh-clear-figureprint
    sed -i "/^$1.*\$/d" ~/.ssh/known_hosts
end
