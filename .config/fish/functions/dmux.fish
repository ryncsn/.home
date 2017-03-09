function dmux
    set PWD_LAST (pwd | rev | cut -d'/' -f 1 | rev | sed -e "s/[^a-zA-Z0-9_]/-/g")
    set PWD_HASH (pwd | sha1sum | cut -c1-8)
    set PWD_ABRV {$PWD_LAST}-{$PWD_HASH}
    tmux has-session -t $PWD_ABRV; or tmux new -s $PWD_ABRV -d; and tmux attach -t $PWD_ABRV
end
