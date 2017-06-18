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
```
