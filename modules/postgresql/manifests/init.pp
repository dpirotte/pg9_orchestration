class postgresql {
  include postgresql::install
  include postgresql::config

  Class["postgresql::install"] -> Class["postgresql::config"]
}
