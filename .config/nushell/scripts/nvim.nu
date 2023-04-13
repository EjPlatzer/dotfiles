export def lvim [...args] {
  with-env ['NVIM_APPNAME' 'LazyNvim'] { nvim $args }
}
