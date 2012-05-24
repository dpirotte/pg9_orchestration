# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  database_servers = [:db1, :db2, :db3]

  database_servers.each_with_index do |db, n|
    config.vm.define db do |c|
      c.vm.host_name = db.to_s
      c.vm.box = "lucid64"
      c.vm.network :hostonly, "172.16.1.1#{n}"
    end
  end
end
