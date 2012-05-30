class postgresql::superuser {
  file { "/var/lib/postgresql/.ssh":
    ensure => directory,
    owner => postgres,
    group => postgres,
    mode => 600
  }

  file { "/var/lib/postgresql/.ssh/id_rsa":
    ensure => file,
    source => "puppet:///modules/postgresql/id_rsa",
    owner => postgres,
    group => postgres,
    mode => 600
  }

  file { ["/var/lib/postgresql/.ssh/id_rsa.pub", "/var/lib/postgresql/.ssh/authorized_keys"]:
    ensure => file,
    source => "puppet:///modules/postgresql/id_rsa.pub",
    owner => postgres,
    group => postgres,
    mode => 600
  }


}
