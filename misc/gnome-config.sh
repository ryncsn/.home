#!/bin/sh

gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-1 "['<Super>F1']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-2 "['<Super>F2']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-3 "['<Super>F3']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-4 "['<Super>F4']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-5 "['<Super>F5']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-6 "['<Super>F6']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-7 "['<Super>F7']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-8 "['<Super>F8']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-9 "['<Super>F9']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-10 "['<Super>F12']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1 "['<Super>1']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-2 "['<Super>2']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-3 "['<Super>3']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-4 "['<Super>4']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-5 "['<Super>5']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-6 "['<Super>q']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-7 "['<Super>w']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-8 "['<Super>e']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-9 "['<Super>r']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-10 "['<Super>t']"
gsettings set org.gnome.shell.app-switcher current-workspace-only true
gsettings set org.gnome.mutter dynamic-workspaces false
gsettings set org.gnome.desktop.wm.preferences num-workspaces 10
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding.custom0 binding '<Super>Return'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding.custom0 command 'gnome-terminal'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding.custom0 name 'Terminal'

