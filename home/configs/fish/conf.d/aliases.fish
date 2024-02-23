abbr vim nvim
# Archlinux update
abbr upgrade paru -Syu
# Alias to enter generic tmux session
abbr tenter tmux new -As main
# Hibernate alias
abbr hibernate systemctl hibernate
# rm interactive mode alias
abbr rm rm -I
# git aliases
abbr gs git status
abbr gl git log
abbr ga git add
abbr gp git pull
abbr gc git commit

# tar multithreading
alias tar="tar --use-compress-program=pigz"

# eza aliases
set eza_modifiers "--git --icons --color-scale --group-directories-first"
alias l="eza $eza_modifiers"
alias ls="eza $eza_modifiers -lhg"
alias ll="eza $eza_modifiers -lbhmag"
alias la="eza $eza_modifiers -a"
alias lt="eza $eza_modifiers --tree"
alias llt="eza $eza_modifiers --tree -a"
alias lx="eza $eza_modifiers -lbhHgmUa"

# Movement aliases
abbr - cd -
abbr .. cd ..
abbr ... cd ../..
abbr .... cd ../../..
abbr ..... cd ../../../..
abbr ...... cd ../../../../..
abbr ....... cd ../../../../../..
abbr ........ cd ../../../../../../..
abbr ......... cd ../../../../../../../..
abbr .......... cd ../../../../../../../../..
abbr ........... cd ../../../../../../../../../..
abbr ............ cd ../../../../../../../../../../..
abbr ............. cd ../../../../../../../../../../../..
abbr .............. cd ../../../../../../../../../../../../..
abbr ............... cd ../../../../../../../../../../../../../..
abbr ................ cd ../../../../../../../../../../../../../../..

function take --wraps mkdir --description 'Make directory and enter'
    mkdir -p $argv && cd $argv
end

function j --wraps autojump --description 'cd autojump'
    cd $(autojump $argv)
end

function pullall --description "Pull git repos within a subdirectory"
    for dir in $(find . -maxdepth 5  -type d -name .git | sed 's|/.git$||')
        cd $dir
        set_color blue
        echo "Entered $(pwd)"
        set_color normal
        git pull
        set_color green
        echo "Finished pull for repo in $dir"
        set_color normal
        cd -
    end
end

function r --wraps git --description "Navigate to git root"
    cd $(git rev-parse --show-toplevel)
end

function showme --description "Unzip provided archive into tmp directory"
    if test -z $argv
        echo "Pass file to show"
        return 1
    end
    set tmp "/tmp/workspaces/$(xxd -l3 -ps /dev/urandom)"
    mkdir -p "$tmp"
    7z x "$argv" -o"$tmp"
    cd "$tmp" || return 1
    clear && echo && echo "$argv" && ls
end

function tmp --description "Make a temporary workspace"
    set r "/tmp/workspaces/$(xxd -l3 -ps /dev/urandom)"
    mkdir -p "$r"
    echo "$r"
    cd "$r"
end

function sd
    set dirr $(find $argv | fzf-tmux -p 70%,75% --preview " [ -f {} ] && bat -f {} || eza -lah --color=always --tree {}")
    [ -d $dirr ] && cd $dirr && return
    [ -f $dirr ] && nvim $dirr && return
end
