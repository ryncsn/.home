[[ -f "$HOME/.fzf.bash" ]] && source "$HOME/.fzf.bash"

[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

type -p starship &>/dev/null  && eval "$(starship init bash)"

# A strange workaround, when bash started by other shell, SHLVL is not increased
SHLVL=${SHLVL:-0}
if [[ $SHELL != *bash ]]; then
    SHLVL=$((SHLVL + 1))
    SHELL=$(which bash)
fi
