# Load common functions
source ~/.config/nu/scripts/common-functions.nu

# Reset path from config file, removing transient paths
pathvar reset

# Load fnm vars and path

### load env variables
fnm env --shell bash | lines | last 6 | str find-replace 'export ' '' | str find-replace -a '"' '' | split column = | rename name value | load-env

### add dynamic fnm path
pathvar append $"($nu.env.FNM_MULTISHELL_PATH)/bin"
