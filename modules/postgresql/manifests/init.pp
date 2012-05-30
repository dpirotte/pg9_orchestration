class postgresql {
  include postgresql::install
  include postgresql::config
  include postgresql::superuser

  Class["postgresql::install"] -> Class["postgresql::config"] -> Class["postgresql::superuser"]
}
