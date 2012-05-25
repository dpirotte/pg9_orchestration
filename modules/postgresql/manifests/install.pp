class postgresql::install {
  apt::ppa { "pitti/postgresql": }
  package { "vim": ensure => latest }
  package { ["postgresql-9.1", "postgresql-contrib-9.1"]:
    ensure => latest,
    require => Apt::Ppa["pitti/postgresql"]
  }
}
