# Add anaconda to path at the end to prefer the system's binaries

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniforge/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniforge/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Aliases
alias ls='ls -G'
alias ll='ls -lG'
alias la='ls -aG'
alias lla='ls -laG'
alias grep='grep --color=auto'
alias clear='clear -x && clear -x'

# Add coreutils to path
#PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
#PATH="/opt/homebrew/opt/findutils/libexec/gnubin:$PATH"
#PATH="/opt/homebrew/opt/grep/libexec/gnubin:$PATH"

# Add Java to path
# export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"
PATH="/Library/Java/JavaVirtualMachines/temurin-8.jdk/Contents/Home/bin:$PATH"

# Add Defects4J to path
export PATH="$PATH:/Users/linasvidz/Projects/defects4j/framework/bin"
export D4J_HOME="/Users/linasvidz/Projects/defects4j"

export PATH="$PATH:/Users/linasvidz/.local/bin"
#export DOTNET_ROOT="/opt/homebrew/opt/dotnet/libexec"
export PATH="$PATH:/Users/linasvidz/.dotnet/tools"
