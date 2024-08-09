PROMPT="%{$fg[cyan]%}%c%{$reset_color%} %(?:%{$fg_bold[green]%}%1{➜%}:%{$fg_bold[red]%}%1{➜%})"
PROMPT+=' $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}%1{✗%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
