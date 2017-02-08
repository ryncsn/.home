#!/bin/bash

PWD=$(pwd)

if [[ ! $PWD == */.home ]]; then
    echo "This is script is only used for fast deploy of my own env files"
    exit 1
fi

if [[ ! -d ~/.oh-my-zsh ]]; then
    echo "Installing Oh-my-zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
else
    echo "Oh-my-zsh already installed."
fi

if [[ ! -d ~/.oh-my-zsh/custom/themes/powerlevel9k ]]; then
    echo "Installing Theme..."
    git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
fi

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

for i in $(find -type f -not -path "./deploy.sh" -not -path "./.git/*"); do
    _symLink $i
done
