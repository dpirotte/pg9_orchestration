class hosts {
  host { "db1": ensure => present, ip => '172.16.1.10' }
  host { "db2": ensure => present, ip => '172.16.1.11' }
  host { "db3": ensure => present, ip => '172.16.1.12' }
}

class base {
  include hosts
}

node db1 {
  include base
}

node db2 {
  include base
}

node db3 {
  include base
}
