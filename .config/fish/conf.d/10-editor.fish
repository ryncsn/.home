set -x EDITOR "nvim"

# Prefer neovim
if type -q nvim
	alias vim="nvim"
end
