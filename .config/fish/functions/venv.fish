function venv
    if test -d .venv
        source .venv/bin/activate.fish
    else
        virtualenv ./.venv
    end
end
