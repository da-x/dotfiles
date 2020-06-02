export PATH=$HOME/.meta/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH

source ~/.zsh/zshrc.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/dan/var/google-cloud-sdk/path.zsh.inc' ]; then source '/home/dan/var/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/dan/var/google-cloud-sdk/completion.zsh.inc' ]; then source '/home/dan/var/google-cloud-sdk/completion.zsh.inc'; fi

# added by travis gem
[ -f /home/dan/.travis/travis.sh ] && source /home/dan/.travis/travis.sh
