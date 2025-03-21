setopt PROMPT_SUBST

local THEME_FILE="$ZSH_CONFIG_HOME/sources/themes/$ZSH_THEME_NAME.zsh-theme"

plugins=(git)

source "$HOME/.asdf/plugins/java/set-java-home.zsh"
source "$ZSH_CONFIG_HOME/sources/alias.sh"
source "$ZSH_CONFIG_HOME/sources/history.sh"
source "$ZSH_CONFIG_HOME/sources/completion.sh"
[ -f "$THEME_FILE" ] && source $THEME_FILE || echo "theme with name \"$ZSH_THEME_NAME\" was not found\n"
source "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

export PATH="$PATH:$HOME/.local/share/coursier/bin"
export PATH="$PATH:$JAVA_HOME/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:/usr/share/sway-contrib"
export PATH="$ASDF_DATA_DIR/shims:$PATH"

# sets home's bin folder as priority
export PATH="$HOME/bin:$HOME/bin/custom-scripts:$PATH"
