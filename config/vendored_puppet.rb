vagrant_gem = `gem which vagrant`.chomp
ssh_options[:keys] = File.join(ENV['HOME'], '.vagrant.d/insecure_private_key')
ssh_options[:paranoid] = false
ssh_options[:keys_only] = true
ssh_options[:user_known_hosts_file] = []
ssh_options[:config] = false
set :user, 'vagrant'

require 'rubygems'
require 'supply_drop'

rubylib = [
  "$RUBYLIB",
  "#{puppet_destination}/vendor/puppet-2.7.8/lib",
  "#{puppet_destination}/vendor/facter-1.6.4/lib",
].join(':')

path = [
  "$PATH",
  "#{puppet_destination}/vendor/puppet-2.7.8/bin",
  "#{puppet_destination}/vendor/facter-1.6.4/bin",
  "/opt/ruby/bin"
].join(':')

set :puppet_command, "env RUBYLIB=#{rubylib} PATH=#{path} puppet apply"
set :puppet_parameters, [
  "--user #{user}",
  "--group #{user}",
  "--vardir /tmp/puppet_dirs/var",
  "--confdir /tmp/puppet_dirs/etc",
  "puppet.pp"
].join(" ")

after :"puppet:update_code" do
  run "mkdir -p /tmp/puppet_dirs"
end
