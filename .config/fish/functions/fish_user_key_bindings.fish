if test -e ~/.fzf/shell/key-bindings.fish
    source ~/.fzf/shell/key-bindings.fish
end

function fish_user_key_bindings
    fzf_key_bindings
end
