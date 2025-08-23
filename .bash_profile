# Miscellaneous but useful
export LC_COLLATE=C
alias vi="vim"
alias sed="gsed"
alias ls="gls --color"
alias sl="ls"
alias ll="ls -l"
alias la="ls -la"
alias cd..="cd .."
alias ..="cd .."
alias fuz="fzf"
alias viz='vim $(fuz)'
alias buff="pbpaste"
alias cir="circleci local execute 'Python 3.12'"

# git aliases
#alias tac="sed -e 's|/|QQQMARKQQQ|g' | tr '\\' '/' | sed -e 's|QQQMARKQQQ|\\\|g' | perl -e 'print reverse<>'"
#alias gog="git log --graph --decorate --oneline --color=ALWAYS | reverse"
alias gog="git log --graph --decorate --oneline --color=ALWAYS -10"
alias gogl="gog --all"
alias gus="git status"
alias gip="git wip"
alias gre="git rebase -i"
alias goc="git checkout"
alias gup="git up"
alias gif="git diff"
alias gic="git add -A && git commit"
alias gor="git push -u origin"

# navigation aliases
alias ..="cd .."

export PATH="/usr/local/aws/bin:/opt/local/bin:/opt/local/sbin:$PATH"

export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

parse_git_branch() {
        git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\[\033[32m\]\u@\h \[\033[33m\]\w\[\033[36m\]\$(parse_git_branch)\[\033[0m\]\$ "

alias mvc="mvn clean"
alias mvi="mvn install"
alias mvo="mvn clean install -offline"
alias mvp="mvn package"
alias mva="mvn clean deploy"

# for python and hcli development
# pip editable in compability mode to avoid working directory subfolder import shadowing (e.g. huckle subfolder folder)
# see https://github.com/pypa/setuptools/issues/3548
alias pig="pip install -e . --config-settings editable_mode=compat"
alias pub="python manage.py publish"
alias tag="python manage.py tag"
alias pyc="find . | grep -E '(/__pycache__$|\.pyc$|\.pyo$)' | xargs rm -rf"
alias pyt="python -m pytest -v"
alias gut="pyc;rm -rf build/ dist/ *.egg-info/ requirements.txt"
alias dry='if git rev-parse --show-toplevel >/dev/null 2>&1; then cd "$(git rev-parse --show-toplevel)"; gut; python manage.py dry-run; else echo "Error: Not in a git repository"; return 1; fi'

# add homebrew coreutils
export PATH="/opt/homebrew/bin/:$PATH"
export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"

# venv activation
source ~/.venv/bin/activate

# remove annoying terminal messages for bash
export BASH_SILENCE_DEPRECATION_WARNING=1

# export PYTORCH_ENABLE_MPS_FALLBACK=1
export USE_MPS=1
export USE_PYTORCH_METAL=1

# huckle and hai setup
eval $(huckle env)
source ~/.openai
source ~/.anthropic

## fzf bindings
source /opt/homebrew/Cellar/fzf/*/shell/completion.bash
source /opt/homebrew/Cellar/fzf/*/shell/key-bindings.bash

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf "$@" --preview 'tree -C {} | head -200' ;;
    *)            fzf "$@" ;;
  esac
}

# colima socket override to avoid Docker Desktop usurping the colima socket.
# export DOCKER_HOST="unix://${HOME}/.colima/default/docker.sock"

# this allows for whatever picked up the socket last (colima start or Docker Desktop launch)
# export DOCKER_HOST=

# Added by LM Studio CLI (lms)
export PATH="$PATH:${HOME}/.cache/lm-studio/bin"

hai() {
  if [ "$1" = "ls" ]; then
    huckle cli run hai ls "${@:2}" | cut -c-$COLUMNS
  else
    huckle cli run hai "$@"
  fi
}

source ~/.spacetraders
