bindkey '^a' beginning-of-line
bindkey '^b' backward-char
bindkey '^d' delete-char-or-list
bindkey '^e' end-of-line
bindkey '^f' forward-char
bindkey '^g' send-break
bindkey '^h' backward-delete-char
bindkey '^i' expand-or-complete
bindkey '^l' vi-forward-char
bindkey '^n' down-line-or-history
bindkey '^p' up-line-or-history
bindkey '^r' history-incremental-search-backward
bindkey '^s' history-incremental-search-forward

# alias
alias ls='ls -G'
alias ll='ls -al'
# 3秒以上かかった処理は詳細表示
REPORTTIME=3

# ヒストリの設定
export HISTFILE=~/.zhistory
# メモリに保存される履歴の件数
export HISTSIZE=1000
# # 履歴ファイルに保存される履歴の件数
export SAVEHIST=1000000
# 重複を記録しない
setopt hist_ignore_dups
# 開始と終了を記録
setopt EXTENDED_HISTORY

#結合文字
setopt COMBINING_CHARS
#PROMPT=$'%{\e[1;32m%}%m{%n}%{\e[m%}%# '
#PROMPT=$'[%{\e[1;35m%}%n%{\e[m%}]%# '
PROMPT=$'[%{\e[1;35m%}%t%{\e[m%}]%# '
#PROMPT=$'%{\e[42m%}%n%#%{\e[m%} '
RPROMPT=$'[%{\e[1;32m%}%~%{\e[m%}]'

autoload -Uz vcs_info
#zstyle ':vcs_info:*' formats '(%s)-[%b]'
#zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
zstyle ':vcs_info:*' formats '[%b]'
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () {
	psvar=()
	LANG=en_US.UTF-8 vcs_info
	[[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
RPROMPT+="%1(v|%F{green}%1v%f|)"

setopt auto_cd auto_remove_slash auto_name_dirs
setopt extended_history hist_ignore_dups hist_ignore_space prompt_subst
setopt extended_glob list_types always_last_prompt
setopt cdable_vars sh_word_split auto_param_keys pushd_ignore_dups
setopt auto_pushd

bindkey -e

zstyle ':completing:*' format '%BCompleting %d%b'
zstyle ':completing:*' group-name
#zstyle ':completing:*' list-colors 'di=34' 'fi=0'

autoload -U compinit && compinit

function chpwd() {
#gls --color=auto
ls
}
function cdup() {
echo
cd ..
zle reset-prompt
}
zle -N cdup
#bindkey '\^' cdup
bindkey '' cdup

source ~/perl5/perlbrew/etc/bashrc

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
#vim
set -o vi
