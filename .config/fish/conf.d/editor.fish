set -x EDITOR "vim"

# Prefer Vim with X11 support on Fedora
if type -q vimx
	alias vim="vimx"
end
