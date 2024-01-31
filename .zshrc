# Set up the prompt
autoload -Uz promptinit
promptinit
prompt adam1

setopt histignorealldups sharehistory

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

# oh-my-posh (and maybe other stuff)
export PATH="$HOME/.local/bin:$PATH"
# eval "$(oh-my-posh init zsh)"
eval "$(oh-my-posh init zsh --config https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/robbyrussell.omp.json)"

# fnm
export PATH="$HOME/.local/share/fnm:$PATH"
# eval "`fnm env`"
# use node version from .nvmrc on cd if available
eval "$(fnm env --use-on-cd)"

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Search through command history with up/down arrow keys
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

# exclude duplicates from command history
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS

# custom command "watch <filename>" will use bat to display the files contents and watch for changes
# very useful for watching log files
watch() {
  if [ -z "$1" ]; then
    echo "Usage: watch <filename>"
    return 1
  fi

  tail -f "$1" | bat --paging=never -l log
}

# custom command aliases
alias p="swpm"

# Cookie-AI-CLI: AI command not found handler
command_not_found_handler(){
    ai "zsh: command not found: $@"
    return 127
}

# swpm package.json script autocompletion
_swpm_scripts() {
    local package_file="package.json"
    if [[ -f $package_file ]]; then
        local -a scripts
        scripts=(${(f)"$(node -e "const package = require('./$package_file'); console.log(Object.keys(package.scripts).join('\n'));")"})
        compadd -a scripts
    fi
}

compdef _swpm_scripts swpm

# fzf -- keybinds to change directory + fuzzy find files and dirs
export FZF_DEFAULT_COMMAND='fd --max-depth 1 --strip-cwd-prefix --hidden --follow --exclude .git --exclude .DS_Store --exclude .Trash'
export FZF_DEFAULT_OPTS='--height 60% --layout=reverse --preview-window=right:50%'

# preview directory tree for alt-c
export FZF_ALT_C_OPTS="--preview '[[ -d {} ]] && tree -C {} || echo {} is not a directory'"
# preview files for ctrl-t ~ if image, render image with viu, else show bat output
export FZF_CTRL_T_OPTS="--bind 'enter:execute-silent(zsh -c \"code {+} & disown\")+abort' --preview 'if [[ -f {} && -r {} ]]; then if file --mime-type -b {} | grep -qE '^image/'; then viu -w 15 -h 10 {}; else bat --style=numbers --color=always --line-range :500 {}; fi; else echo {} is not a file; fi'"

# alt c fuzzy find directories and cd into them ~ exclude .git and .Trash ~ show .. as first option
export FZF_ALT_C_COMMAND='(echo ".."; fd --type d --max-depth 5 --strip-cwd-prefix --follow --exclude .git --exclude .Trash)'
# ctrl t fuzzy find files and open them in vim ~ exclude .git and .Trash
export FZF_CTRL_T_COMMAND='fd --type f --strip-cwd-prefix --follow --exclude .git --exclude .DS_Store --exclude .Trash'export PATH=$PATH:/usr/local/go/bin

source /usr/share/doc/fzf/examples/key-bindings.zsh
