# Concentration of all my dotfiles

Installable via:

```
# Vim
ln -s $(pwd)/dotvimrc ~/.vimrc
ln -s $(pwd)/vimrc ~/.vim_runtime

# Tmux
ln -s $(pwd)/tmux.conf ~/.tmux.conf

# Zsh
ln -s $(pwd)/dotzsh ~/.zsh
ln -s $(pwd)/zshrc ~/.zshrc

# Xdefaults
ln -s $(pwd)/Xdefaults ~/.Xdefault
xrdb ~/.Xdefaults

# Git
echo "[include]" >> ~/.gitconfig
echo "path = $(pwd)/gitconfig" >> ~/.gitconfig

# Gdb
echo "source $(pwd)/gdb-dashboard/.gdbinit" >> ~/.gdbinit

# Midnight Commander
ln -f -s $(pwd)/mc ~/.config/mc
```
