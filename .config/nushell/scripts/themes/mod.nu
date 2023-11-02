export def update [] nothing -> nothing {
  let known_themes = ['dracula', 'one-dark']

  $known_themes | each {|$theme_name| 
    let url = $'https://raw.githubusercontent.com/nushell/nu_scripts/main/themes/nu-themes/($theme_name).nu'
    let path = $'($env.XDG_CONFIG_HOME)/nushell/scripts/themes/($theme_name).nu'
    let theme = http get $url
    $theme | save $path -f
  }
}

export def main [] nothing -> record {
  update
}
