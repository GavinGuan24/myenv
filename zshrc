############################ Gavin 自定义 #############################
############################### varables
# terminal 配色
#export PS1='\[\e[35m\]\u\[\e[30m\]@\[\e[32m\]\h \[\e[36m\]\w\[\e[31m\] \$ \[\e[0m\]'
export PS1="%{%F{magenta}%}%n%{%f%}@%{%F{yellow}%}%m%{%F{blue}%} %c %{%F{red}%}%% %{%f%}"
## homebrew 源
export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles
# Java & Maven
export JAVA_HOME=/usr/local/jdk/Home
export MAVEN_HOME=/usr/local/maven
export PATH=$PATH:$JAVA_HOME/bin:$MAVEN_HOME/bin
# fabric
export PATH=$PATH:/usr/local/hyperledger_fabric/bin
# golang
export GOROOT=/usr/local/go
export GOPATH=/Users/gavinguan/gitStore/go_path
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
# rust
export RUSTUP_DIST_SERVER=https://mirrors.ustc.edu.cn/rust-static
export RUSTUP_UPDATE_ROOT=https://mirrors.ustc.edu.cn/rust-static/rustup
export RUSTUP_HOME=/usr/local/rust/rustup
export CARGO_HOME=/usr/local/rust/cargo
export PATH=$PATH:/usr/local/rust/cargo/bin
# node.js
export NODE_HOME=/usr/local/node_home
export PATH=$PATH:$NODE_HOME/bin
# graphviz
export PATH=$PATH:/usr/local/opt/graphviz/bin
# my bin
export PATH=$PATH:/usr/local/gavin_bin
# fzf
export FZF_DEFAULT_OPTS='--height 100% --layout=reverse --border --keep-right'
export FZF_DEFAULT_COMMAND='fd --type f'
# my env
export Idea=/Applications/IntelliJ\ IDEA.app
export IdeaCE=/Applications/IntelliJ\ IDEA\ CE.app
export Sublime=/Applications/Sublime\ Text.app
export VSCodium=/Applications/VSCodium.app
export iTerm=/Applications/iTerm.app
############################### alias
# ls alias
alias ls="ls -G"
alias ll="ls -laG"
# git alias
alias gClean="git add -A && git reset --hard"
alias gCommit="git add -A && git commit -m"
alias gPush="git push"
alias gTree='git log --graph --decorate --date=format:"%Y-%m-%d %H:%M:%S" --pretty=format:"%Cgreen%h%Creset %C(yellow)%s %Cred%d%Creset %C(cyan)%cd %Cblue%cn"'
alias stashsave="git add -A && git stash save"
alias stashlist="git stash list"
alias stashapply="git stash apply"
alias stashdrop="git stash drop"
# iTerm alias
alias iterm='open . -a $iTerm'
############################### methods
# smart open
so () {
    if [[ $1 =~ "\.(java|xml)$" ]]; then
        open $1 -a $IdeaCE
    elif [[ $1 =~ "\.(rs|toml)$" ]]; then
        open $1 -a $IdeaCE
    elif [[ $1 =~ "\.(go)$" ]]; then
        open $1 -a $VSCodium
    elif [[ $1 =~ "\.(c|cpp)$" ]]; then
        open $1 -a $Sublime
    elif [[ $1 =~ "\.(txt|config|sql|md|log)$" ]]; then
        open $1 -a $Sublime
    elif [[ $1 =~ "\.(lock|gitignore)$" ]]; then
        open $1 -a $Sublime
    else
        open $1
    fi
}
# git checkout <branch>
gitco() {
	git status 2>/dev/null 1>/dev/null
	if [[ $? == 0 ]]; then
        gitStat=`git status -s`
        if [[ $gitStat != '' ]]; then 
            echo "interrupted: changes in working tree"
            return
        fi
		git checkout $(git for-each-ref --format='%(refname:short)' refs/heads/ | fzf --height 40%)
	else
		echo `pwd`" isn't a git repository"
	fi
}
# text search, ripgrep & fzf, $1: pattern
hit () {
    rg -in $@ | fzf --bind 'ctrl-o:execute(fzf_ctrl_o {})' -m --preview 'fzf_hit_pv {}' --preview-window down:15
}
# mrq
mrqd () {
    if [[ $1 == '' ]]; then
        echo "please type \$id"
        return
    fi
    mrq -id $1 | fzf -m | mrq -mvnId
}
