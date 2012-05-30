class postgresql::config {
  $config_dir = "/etc/postgresql/9.1/main"
  $data_dir = "/var/lib/postgresql/9.1/main"
  $repmgr_dir = "/var/lib/postgresql/repmgr"

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
    notify => Service["postgresql"]
  }

  file { ["${data_dir}/server.key", "${data_dir}/server.crt"]: ensure => absent }

  file { $repmgr_dir: ensure => directory, owner => postgres, group => postgres }

  file { "${repmgr_dir}/repmgr.cfg":
    ensure => file,
    content => template("postgresql/repmgr.cfg.erb"),
    owner => postgres, group => postgres, mode => 0640
  }
}
