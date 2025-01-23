#!/bin/bash

# vencord
cat /mnt/c/Users/daffa/AppData/Roaming/Vencord/settings/quickCss.css > /mnt/c/Users/daffa/Documents/Config/Universal/Vencord/quickcss.css
cat /mnt/c/Users/daffa/AppData/Roaming/Vencord/settings/settings.json > /mnt/c/Users/daffa/Documents/Config/Universal/Vencord/settings.json
cp -f /mnt/c/Users/daffa/AppData/Roaming/Vencord/themes/* /mnt/c/Users/daffa/Documents/Config/Universal/Vencord/themes/

# notepad++
cp -f /mnt/c/Users/daffa/AppData/Roaming/Notepad++/themes/* /mnt/c/Users/daffa/Documents/Config/Universal/Notepad++/themes/

# ubuntu
cat ~/.bashrc > /mnt/c/Users/daffa/Documents/Config/Ubuntu/.bashrc
cat ~/custom.omp.json > /mnt/c/Users/daffa/Documents/Config/Ubuntu/custom.omp.json

# code
cat /mnt/c/Users/daffa/AppData/Roaming/Code/User/settings.json > /mnt/c/Users/daffa/Documents/Config/Universal/Code/settings.json
cat /mnt/c/Users/daffa/AppData/Roaming/Code/User/keybindings.json > /mnt/c/Users/daffa/Documents/Config/Universal/Code/keybindings.json

# homebrew
brew list > /mnt/c/Users/daffa/Documents/Config/Universal/Homebrew/brew_list.txt

# micro
cat ~/.config/micro/settings.json > /mnt/c/Users/daffa/Documents/Config/Universal/Micro/settings.json
cat ~/.config/micro/bindings.json > /mnt/c/Users/daffa/Documents/Config/Universal/Micro/bindings.json

# zen
cp -rf "/mnt/c/Users/daffa/AppData/Roaming/zen/Profiles/p1z6hl1y.Default (alpha)/chrome/"* "/mnt/c/Users/daffa/Documents/Config/Universal/Zen Browser/"

echo "------------ All updated! ------------"

# git push
git add -A
git commit -m "Config update"
git push origin config

echo "------------   Pushed 💨   ------------"
