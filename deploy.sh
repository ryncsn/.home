#!/bin/bash

_error() {
    echo $1; exit 1;
}

_checkPwd(){
    if [[ ! $(pwd) == */.home ]]; then
        _error "This is script is only used for fast deploy of my own env files"
    fi
}

_checkTools(){
    for i in "git" "curl" "vim" "sed" "sh" "realpath" "dirname"; do
        $(which $i &> /dev/null) || _error "'$i' is needed but not installed"
    done
}

_symLink(){
    _path="$1"
    _src="$(realpath $_path)";
    _dst="$(echo ~/)${_path#./}";
    _baseDir=$(dirname $_dst)
    mkdir -p $_baseDir
    if [[ ! -f $_dst ]]; then
        ln -s $_src $_dst
        echo "$_dst linked to $_src"
    else
        echo "$_dst already exists, skipping."
    fi
}

_Install(){
    if [[ ! -d ~/.oh-my-zsh ]]; then
        echo "Installing Oh-my-zsh..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh) sed 's/^env zsh$/d'"
    fi

    if [[ ! -d ~/.oh-my-zsh/custom/themes/powerlevel9k ]]; then
        echo "Installing Theme..."
        git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
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
    for i in $(find -type f -not -path "./deploy.sh" -not -path "./.git/*"); do
        _symLink $i
    done
}

main

#TODO
vim -c "PluginInstall"
