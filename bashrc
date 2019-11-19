alias activate="source .venv/bin/activate"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias v="vim"
alias gdel="git branch -D"
alias gb="git branch"
alias gs="git status"
alias ga="git add"
alias gc="git commit -m"
alias gd="git diff"
alias python="python3"
export HISTSIZE=
export HISTFILESIZE=
export HISTFILE=$HOME/.bash_eternal_history
export PROMPT_COMMAND="history -a; history -c; history -r; ${PROMPT_COMMAND}"
function gpush() {
    force=false
    current_branch=$(git rev-parse --abbrev-ref HEAD)
    push_command="git push origin $current_branch"
    if [[ $1 = "-f" ]] || [[ $1 = "--force" ]]; then
        force=true
    fi
    if [[ $current_branch == 'master' ]] && [[ $force = "false" ]]; then
        echo "${RED}ERROR${RESET}: Can't push to master. Use -f (--force)."
        return
    fi
    echo $push_command
    $push_command
}
