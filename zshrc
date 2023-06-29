export PATH=$HOME/.meta/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH

export GOPATH=$HOME/.go

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source ~/.zsh/zshrc.sh
source ~/.asdf/asdf.sh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/dan/var/google-cloud-sdk/path.zsh.inc' ]; then source '/home/dan/var/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/dan/var/google-cloud-sdk/completion.zsh.inc' ]; then source '/home/dan/var/google-cloud-sdk/completion.zsh.inc'; fi

# added by travis gem
[ -f /home/dan/.travis/travis.sh ] && source /home/dan/.travis/travis.sh

# Terraform completions
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/terraform terraform
