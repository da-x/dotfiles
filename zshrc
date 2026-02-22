export PATH=$HOME/.meta/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH

export GOPATH=$HOME/.go

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source ~/.zsh/zshrc.sh

# bun completions
[ -s "/home/dan/.bun/_bun" ] && source "/home/dan/.bun/_bun"

alias claude="/home/dan/.claude/local/claude"
