class postgresql::config {
  $config_dir = "/etc/postgresql/9.1/main"

  service { "postgresql":
    ensure => running, hasrestart => true
  }

  service { "postgresql-reload":
    status => "/etc/init.d/postgresql status",
    restart => "/etc/init.d/postgresql reload"
  }

  file { "${config_dir}/pg_hba.conf":
    source => "puppet:///modules/postgresql/pg_hba.conf",
    owner => postgres, group => postgres, mode => 0640,
    notify => Service["postgresql-reload"]
  }

  file { "${config_dir}/postgresql.conf":
    ensure => present,
    content => template("postgresql/postgresql.conf.erb"),
    owner => postgres, group => postgres, mode => 0640,
    notify => Service["postgresql-reload"]
  }
}
