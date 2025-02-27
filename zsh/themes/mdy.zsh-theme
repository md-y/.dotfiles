local name_prefix="nix"
if [[ -n "$name" ]]; then
  name_prefix="$name"
fi

PROMPT="%(?:%{$fg_bold[green]%}%1{$name_prefix%} :%{$fg_bold[red]%}%1{$name_prefix%} )"
PROMPT+="%{$fg[cyan]%}%c%{$reset_color%}"
PROMPT+=' $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}%{$fg[yellow]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX=")%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}*%{$fg[yellow]%}"
