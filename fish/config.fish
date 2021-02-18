set -g -x PATH /usr/local/bin $PATH
source ~/.config/fish/aliases.fish

# Android Studio
set --export ANDROID $HOME/Library/Android;
set --export ANDROID_HOME $ANDROID/sdk;
set -gx PATH $ANDROID_HOME/tools $PATH;
set -gx PATH $ANDROID_HOME/tools/bin $PATH;
set -gx PATH $ANDROID_HOME/platform-tools $PATH;
set -gx PATH $ANDROID_HOME/emulator $PATH

set --export JAVA_HOME /Applications/Android\ Studio.app/Contents/jre/jdk/Contents/Home;
set -gx PATH $JAVA_HOME/bin $PATH;

# Completions
function make_completion --argument-names alias command
    echo "
    function __alias_completion_$alias
        set -l cmd (commandline -o)
        set -e cmd[1]
        complete -C\"$command \$cmd\"
    end
    " | .
    complete -c $alias -a "(__alias_completion_$alias)"
end

make_completion g 'git'

# Set ls color
set -Ux LSCOLORS gxfxbEaEBxxEhEhBaDaCaD

# Readline colors
set -g fish_color_autosuggestion 555 yellow
set -g fish_color_command 5f87d7
set -g fish_color_comment 808080
set -g fish_color_cwd 87af5f
set -g fish_color_cwd_root 5f0000
set -g fish_color_error 870000 --bold
set -g fish_color_escape af5f5f
set -g fish_color_history_current 87afd7
set -g fish_color_host 5f87af
set -g fish_color_match d7d7d7 --background=303030
set -g fish_color_normal normal
set -g fish_color_operator d7d7d7
set -g fish_color_param 5f87af
set -g fish_color_quote d7af5f
set -g fish_color_redirection normal
set -g fish_color_search_match --background=purple
set -g fish_color_status 5f0000
set -g fish_color_user 5f875f
set -g fish_color_valid_path --underline

set -g fish_color_dimmed 555
set -g fish_color_separator 999

# Git prompt status
set -g __fish_git_prompt_showdirtystate 'yes'
set -g __fish_git_prompt_showupstream auto

# Set Vi Mode
set fish_key_bindings fish_user_key_bindings

# Status Chars
#set __fish_git_prompt_char_dirtystate '*'
set __fish_git_prompt_char_upstream_equal ''
set __fish_git_prompt_char_upstream_ahead '↑'
set __fish_git_prompt_char_upstream_behind '↓'
set __fish_git_prompt_color_branch yellow
set __fish_git_prompt_color_dirtystate 'red'

set __fish_git_prompt_color_upstream_ahead ffb90f
set __fish_git_prompt_color_upstream_behind blue

# Local prompt customization
set -e fish_greeting

set -g fish_pager_color_completion normal
set -g fish_pager_color_description 555 yellow
set -g fish_pager_color_prefix cyan
set -g fish_pager_color_progress cyan

status --is-interactive; and source (pyenv init -|psub)

export GPG_TTY=(tty)
direnv hook fish | source
