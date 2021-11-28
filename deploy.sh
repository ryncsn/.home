#!/bin/bash

OS=$(uname -s)

_checkPwd(){
    if [[ ! $(pwd) == */.home ]]; then
        echo "This is script is only used for fast deploy of my own env files"
        return 1
    fi
}

_checkTools(){
    local _ret=0 _tools _installer

    case "$OS" in
        Darwin )
            if ! command -v brew &> /dev/null; then
                echo "Homebrew required."
                exit 1
            fi
            # TODO: use rustup
            _tools=( "git" "curl" "vim" "bison" "fish" "cmake" "shellcheck" "npm" "ctags" "make" "kubectl" "podman" "wget" "curl" "htop"  "python" "iftop" "flex" "perl" "ansible" "tmux" "pipenv" "helm" "rustup-init" "starship" )
            _installer=( "brew" "install" )
            ;;
        Linux )
            # XXX: This only work on Fedora
            # TODO: use rustup
            local _tools=( "git" "curl" "vimx,vim-X11" "fedpkg" "bison" "sed" "sh,bash" "fish" "rustc" "cmake" "g++" "realpath,coreutils" "dirname,coreutils" "shellcheck,ShellCheck" "npm" "chsh,util-linux-user" "ctags" "make" "kubectl,kubernetes-client" "podman" "wget" "curl" "htop" "strace" "python" "iotop" "iftop" "flex" "perl" "ansible" "tmux" "pipenv" "cargo" "starship"
    ",openssl-devel" ",elfutils-devel" ",ncurses-devel" )
            _installer=( "sudo" "dnf" "install" "-y" )
            ;;
        * )
            echo "Unknown OS $OS"
            ;;
    esac

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
        echo "${_installer[@]}" "${_inst[@]}"
        "${_installer[@]}" "${_inst[@]}" || {
            echo "Failed to install missing packages, please install them manually:"
            echo "${_inst[@]}"
            exit 1
        }
    fi
}

_symLink(){
    local _src=$1
    local _dst=$2
    local _baseDir

    _baseDir=$(dirname "$_dst")
    mkdir -p "$_baseDir"

    if [[ ! -f $_dst ]]; then
        ln -sf "$_src" "$_dst"
        echo "$_dst linked to $_src"
    else
        if [[ ! -L $_dst ]]; then
            echo "$_dst is a file, create a backup and replace with a linkt to $_src"
            mv "$_dst" "$_dst.bak"
            ln -s "$_src" "$_dst"
        else
            echo "$_dst already exists, skipping."
        fi
    fi
}

_deployInstall(){
    if [[ ! -d ~/.local/share/omf ]]; then
        echo "Installing Oh-my-fish..."
        # TODO: Hardening
        curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/HEAD/functions/fisher.fish | source && fisher install jorgebucaran/fisher
        fish -c "omf install bobthefish"
    fi

    if [[ ! -f ~/.config/fish/functions/fzf_key_bindings.fish ]]; then
        echo "Installing fzf..."
        git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
        ~/.fzf/install --all
    fi

    if [[ ! -d ~/.vim/bundle/Vundle.vim/.git ]]; then
        echo "Installing Theme..."
        git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    fi
}

_do_syncDotFiles() {
    local _root=$1
    pushd "$_root" || { echo "Failed pushd $_root"; exit 1;}
    while IFS= read -r -d '' i; do
        i=${i#./}
        if [ "$(basename "$i")" = ".gitkeep" ]; then
            i=$(dirname "$i")
            mkdir -p "$HOME/$i";
        else
            _symLink "$HOME/.home/$_root/$i" "$HOME/$i"
        fi
    done < <(find . -type f \
        -not -path "./.git/*" \
        -not -path "./deploy.sh" \
        -not -path "./misc/*" \
        -not -path "./distros/*" \
        -print0)
    popd || { echo "Failed popd $_root"; exit 1;}
}

_syncDotFiles() {
    _do_syncDotFiles .
    case "$OS" in
        Darwin )
            _do_syncDotFiles ./distros/macos
            ;;
        Linux )
            # XXX: This only work on Fedora
            _do_syncDotFiles ./distros/fedora
            ;;
        * )
            echo "Unknown OS $OS"
            ;;
    esac
}

_rebuildYCM() {
    pushd "$HOME/.vim/bundle/YouCompleteMe" || echo "YCM not installed" && exit 1
    git submodule update --init --recursive
    ./install.py --clang-completer --rust-completer --ts-completer
    popd || exit 1
}

_vimDeploy() {
    vim +"PluginInstall" +"qall!"
}

_vimUpdate() {
    vim +"PluginUpdate" +"qall!"
}

_getHelm() {
    # TODO: Hardening
    if ! command -v brew &> /dev/null; then
        curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | \
            HELM_INSTALL_DIR=$HOME/.local/bin USE_SUDO=false bash
    fi
}

_helmDeploy() {
    helm repo add jenkins https://charts.jenkins.io
    helm repo add ceph-csi https://ceph.github.io/csi-charts
}

_helmUpdate() {
    "$HOME/.local/bin/helm" repo update
}

_doUpdate() {
    _syncDotFiles
    _checkTools

    # Misc updates:
    fish -c "omf update"

    _getHelm
    _helmUpdate

    _vimUpdate
    _rebuildYCM
}

_doDeploy(){
    _syncDotFiles
    _checkTools

    _getHelm
    _helmDeploy

    _deployInstall

    _vimDeploy
    _rebuildYCM

    echo "Now go install Nerf Font"
}

_checkPwd || exit 1

case $1 in
    sync-dot-files )
        _syncDotFiles
        ;;
    update )
        _doUpdate
        ;;
    * )
        _doDeploy
        ;;
esac
