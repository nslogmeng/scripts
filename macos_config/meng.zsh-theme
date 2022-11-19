# Put your custom themes in this folder.
# Example:

# 教程 https://prinsss.github.io/zsh-prompt-theme-customization/

NEWLINE=$'\n'
PROMPT="${FG[237]}\${(l.\$(echo $COLUMNS)..-.)}%{$reset_color%}${NEWLINE}"
PROMPT+="%(?:%{$fg_bold[green]%} :%{$fg_bold[red]%} )"
PROMPT+='%{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'

RPROMPT='%{$fg[cyan]%}[%* @%n]%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%}*%{$reset_color%}%{$fg_bold[blue]%})"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
