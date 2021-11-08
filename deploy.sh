#!/bin/bash

_checkPwd(){
    if [[ ! $(pwd) == */.home ]]; then
        echo "This is script is only used for fast deploy of my own env files"
        exit 1
    fi
}

# XXX: This only work on Fedora
_checkTools(){
    local _ret=0
    local _tools=( "git" "curl" "vimx,vim-X11" "fedpkg" "bison" "sed" "sh,bash" "fish" "rustc" "cmake" "g++" "realpath,coreutils" "dirname,coreutils" "shellcheck,ShellCheck" "npm" "chsh,util-linux-user" "ctags" "make" "kubectl,kubernetes-client" "podman" "wget" "curl" "htop" "strace" "python" "iotop" "iftop" "flex" "perl" "ansible" "tmux" "pipenv" "cargo"
    ",openssl-devel" ",elfutils-devel" ",ncurses-devel")
    for i in ${_tools[*]}; do
        [ "${i%,*}" ] || continue
        if ! command -v "${i%,*}" &> /dev/null; then
            echo "'$i' is needed but not installed"
            _ret=1
        fi
    done

    if [[ "$_ret" -ne 0 ]]; then
        echo "Please ensure follwing tools are all installed:"
        local _inst
        _inst=( )
        for i in ${_tools[*]}; do
            _inst+=( "${i#*,}" )
        done
        echo "Trying to install missing packages...:"
        sudo dnf install "${_inst[@]}" -y || {
            echo "Failed to install missing packages, please install them manually:"
            echo "${_inst[@]}"
            exit 1
        }
    fi
}

_symLink(){
    local _path="$1" _src _dst _baseDir
    _src="$(realpath "$_path")";
    _dst="$HOME/${_path#./}";
    _baseDir=$(dirname "$_dst")
    mkdir -p "$_baseDir"
    if [[ ! -f $_dst ]]; then
        ln -s "$_src" "$_dst"
        echo "$_dst linked to $_src"
    else
        if [[ ! -L $_dst ]]; then
            echo "$_dst is a file, create a backup and replace with a linkt to $_src"
            mv "$_dst" "$_dst.bak"
            ln -s "$_src" "$_dst"
        fi
        echo "$_dst already exists, skipping."
    fi
}

_Install(){
    if [[ ! -d ~/.local/share/omf ]]; then
        echo "Installing Oh-my-fish..."
        curl -L https://get.oh-my.fish | sed -e 's/main $argv/\nset -g NONINTERACTIVE\nset -g ASSUME_YES\nmain $argv/' | fish
        fish -c "omf install bobthefish"
    fi

    if [[ ! -f ~/.config/fish/functions/fzf_key_bindings.fish ]]; then
        echo "Installing fzf..."
        git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
        ~/.fzf/install --all
    fi

    if [[ ! -d ~/.vim/bundle/Vundle.vim ]]; then
        echo "Installing Theme..."
        git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    fi
}

main(){
    _checkPwd
    _checkTools
    _Install

    while IFS= read -r -d '' i; do
        if [ "$(basename "$i")" = ".gitkeep" ]; then
            i=$(dirname "$i")
            mkdir -p "$HOME/${i#./}";
        else
            _symLink "$i"
        fi
    done < <(find . -type f -not -path "./deploy.sh" -not -path "./.git/*" -not -path "./misc/*" -print0)

    vim +"PluginInstall" +"qall"
    # vim +"PluginUpdate" +"qall"

    pushd "$HOME/.vim/bundle/YouCompleteMe"
    git submodule update --init --recursive
    ./install.py --clang-completer --rust-completer --ts-completer
    popd
}

main
