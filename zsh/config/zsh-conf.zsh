setopt notify
setopt nobeep
setopt autocd

alias tp="trash put"
alias ls="ls --color"
alias ll="ls -alF "
alias la="ls -A "
alias l="ls -CF "
alias tm="tmux"
alias mk="make"
alias mj="make -j \$(nproc)"
alias rm="echo you must use del and delclean instead of rm else use \\rm"
alias del="trash-put"
alias ip='ip --color=auto'
alias grep= "grep --color=auto"
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias grep='grep --color=auto'
alias less='less -R'
# alias bat='batcat --theme base16 -p'

function clear-screen-and-scrollback() {
    echoti civis >"$TTY"
    printf '%b' '\e[H\e[2J' >"$TTY"
    zle .reset-prompt
    zle -R
    printf '%b' '\e[3J' >"$TTY"
    echoti cnorm >"$TTY"
}
export PATH=$PATH:~/.local/bin

zle -N clear-screen-and-scrollback
bindkey "^O" accept-search
bindkey '^[^L' clear-screen-and-scrollback
bindkey -r '^L'

[ -z "$TMUX"  ] && tmux new -A -s main -D
# }}}
