ssh_options[:keys_only] = true
ssh_options[:user_known_hosts_file] = []
ssh_options[:config] = File.join(File.dirname(__FILE__), '../ssh_config')
set :user, 'vagrant'

require 'rubygems'
require 'supply_drop'

rubylib = [
  "$RUBYLIB",
  "#{puppet_destination}/vendor/puppet-2.7.14/lib",
  "#{puppet_destination}/vendor/facter-1.6.9/lib",
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
