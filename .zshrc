# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh


export EDITOR="emacs"
export PAGER="most"


#Set the auto completion on

setopt   auto_list auto_param_slash list_packed rec_exact
unsetopt list_beep
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors 'di=1;34'
zstyle ':completion:*' format '%F{white}%d%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' keep-prefix
zstyle ':completion:*' remote-access false
zstyle ':completion:*' completer _oldlist _complete _match _ignored \
    _list _history
zstyle ':completion:sudo:*' environ PATH="$SUDO_PATH:$PATH"

autoload -U compinit
compinit

autoload -U colors
colors

highlights='${PREFIX:+=(#bi)($PREFIX:t)(?)*==$color[red]=$color[white];$color[bold]}':${(s.:.)LS_COLORS}}

zstyle -e ':completion:*' list-colors \
    'reply=( "'$highlights'" )'



#Set some ZSH styles
zstyle ':completion:*' auto-description  'specify: %d'
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BNon, désolé, aucune entrée pour : %d%b'

 
HISTFILE=~/.zsh-histfile
HISTSIZE=2000
SAVEHIST=2000
 
# If a line starts with a space, don't save it.
setopt HIST_IGNORE_SPACE
setopt HIST_NO_STORE




# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="bop"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=$PATH:/home/bossip/bin:/usr/local/bin:/usr/bin:/bin




#Aliases
##ls, the common ones I use a lot shortened for rapid fire usage
alias ls='pwd;ls --color' #I like color
alias l='ls -lFh'     #size,show type,human readable
alias la='ls -lAFh'   #long list,show almost all,show type,human readable
alias lr='ls -tRFh'   #sorted by date,recursive,show type,human readable
alias lt='ls -ltFh'   #long list,sorted by date,show type,human readable
alias em='sudo emacs -nw' 
alias fdl='sudo fdisk -l'
alias tor='mv ~/Téléchargements/*.torrent ~/torrent/watch/; rtorrent'
alias Ll='cd ~/Latex/libre/libre/'
alias ftpp='ftp poetic.ch'
alias path='echo $PATH | tr ":" "\012" '
alias dsk='sudo losetup /dev/loop0 /media/disk/crypt.img ;sudo cryptsetup luksOpen /dev/loop0 cry; sudo mount /dev/mapper/cry /mnt/ ; thunar /mnt &'
alias udsk='sudo umount /dev/mapper/cry; sudo cryptsetup luksClose cry; sudo losetup -d /dev/loop0'
alias conj='french-conjugator --pronouns'
alias apti='sudo apt-get install'
# google calendrier
alias gcalcli='~/bin/gcalcli/gcalcli'
alias gq='gcalcli quick '
alias ga='gcalcli agenda'
alias gm='gcalcli calm'
alias gw='gcalcli calw'

alias muz='sudo sh ~/bin/muz.sh '
alias emz='em /home/bossip/.zshrc; sourcez' 
alias joom='sudo service mysqld start; apache; firefox 0.0.0.0'
alias sourcez='source ~/.zshrc'
alias update-grub='sudo grub2-mkconfig -o /boot/grub2/grub.cfg'

# dépôts git - gitlab
alias gpush='git push git@github.com:bop/libre.git'

# Alias Git
git config --global alias.last 'log -1 HEAD'
git config --global alias.unstage 'reset HEAD --'


alias mad='sshfs xpertise@ssh.alwaysdata.com: ~/alwaysd; thunar ~/alwaysd/'
alias umad='fusermount -u ~/alwaysd'


# Suffixes aliases (just type name file to open it with ...)
alias -s tex=emacs
alias -s html=chromium-browser
alias -s org=emacs

# Same as before, far more complicated : PDF viewer (just type 'file.pdf')
if [[ -x `which evince` ]]; then
    alias -s 'pdf=evince'

fi


export PYTHONPATH=~/.virtualenvs:$PYTHONPATH

#source $(which virtualenvwrapper.sh)
# petite spécialité debian (cf: /usr/share/doc/virtualenvwrapper/README.Debian)
source /etc/bash_completion.d/virtualenvwrapper
export WORKON_HOME=~/.virtualenvs

plugins=(git debian django heroku pip ssh-agent web-search)