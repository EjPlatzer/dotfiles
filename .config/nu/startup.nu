# Load common functions
source ~/.config/nu/scripts/common-functions.nu

# Reset path from config file, removing transient items
pathvar reset

# Load fnm vars and path
fnm env | lines | last 6 | str find-replace 'export ' '' | str find-replace -a '"' '' | split column = | rename name value | load-env
pathvar append $"($nu.env.FNM_MULTISHELL_PATH)/bin"
