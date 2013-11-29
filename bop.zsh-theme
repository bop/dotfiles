# ------------------------------------------------------------------------
# Juan G. Hurtado oh-my-zsh theme
# (Needs Git plugin for current_branch method)
# ------------------------------------------------------------------------

# Color shortcuts
RED=$fg[red]
YELLOW=$fg[yellow]
GREEN=$fg[green]
WHITE=$fg[white]
BLUE=$fg[blue]
RED_BOLD=$fg_bold[red]
YELLOW_BOLD=$fg_bold[yellow]
GREEN_BOLD=$fg_bold[green]
WHITE_BOLD=$fg_bold[white]
BLUE_BOLD=$fg_bold[blue]
CYAN=$fg[cyan]
CYAN_BOLD=$fg_bold[cyan]
RESET_COLOR=$reset_color

# Format for git_prompt_info()
ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX=""


# Format for parse_git_dirty()
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$RED%}(*)"
ZSH_THEME_GIT_PROMPT_CLEAN=""
BOP_GIT_CLEAN_COLOR="%{$fg[green]%}"
BOP_GIT_DIRTY_COLOR="%{$fg[red]%}"
BOP_GIT_AHEAD_COLOR="%{$fg[yellow]%}"

ZSH_THEME_GIT_PROMPT_CLEAN=" $BOP_GIT_CLEAN_COLOR✓"
ZSH_THEME_GIT_PROMPT_DIRTY=" $BOP_GIT_DIRTY_COLOR✗"



# Format for git_prompt_status()
ZSH_THEME_GIT_PROMPT_UNMERGED=" %{$RED%}unmerged"
ZSH_THEME_GIT_PROMPT_DELETED=" %{$RED%}deleted"
ZSH_THEME_GIT_PROMPT_RENAMED=" %{$YELLOW%}renamed"
ZSH_THEME_GIT_PROMPT_MODIFIED=" %{$YELLOW%}modified"
ZSH_THEME_GIT_PROMPT_ADDED=" %{$GREEN%}added"
ZSH_THEME_GIT_PROMPT_UNTRACKED=" %{$WHITE%}untracked"

# Format for git_prompt_ahead()
ZSH_THEME_GIT_PROMPT_AHEAD=" %{$YELLOW%}(!)"

# Format for git_prompt_long_sha() and git_prompt_short_sha()
ZSH_THEME_GIT_PROMPT_SHA_BEFORE=" %{$WHITE%}[%{$YELLOW%}"
ZSH_THEME_GIT_PROMPT_SHA_AFTER="%{$WHITE%}]"


# local time, color coded by last return code
time_enabled="%(?.%{$fg[cyan]%}.%{$fg[red]%})%*%{$reset_color%}"
time_disabled="%{$fg[cyan]%}%*%{$reset_color%}"
time=$time_enabled

# user part, color coded by privileges
local user="%(!.%{$fg[blue]%}.%{$fg_bold[white]%})%n%{$reset_color%}"

# Hostname part.  compressed and colorcoded per host_repr array
# if not found, regular hostname in default color
local host="@${host_repr[$(hostname)]:-$(hostname)}%{$reset_color%}"

# Compacted $PWD
PWD="$fg[white]$PWD%{$RESET_COLOR%}"

# PROMPT='${time} ${user}${host} ${pwd} $(git_prompt_info)'

# Prompt format
PROMPT='
${time} %{$WHITE%}${user}@$RED%m%{$CYAN%}:%~%u$(parse_git_dirty)$(git_prompt_ahead)%{$RESET_COLOR%}
$PWD
%{$YELLOW_BOLD%}>>> %{$RESET_COLOR%} '
RPROMPT='%{$fg[magenta]%}$(current_branch)$(git_prompt_short_sha)$(git_prompt_status)%{$RESET_COLOR%}'

