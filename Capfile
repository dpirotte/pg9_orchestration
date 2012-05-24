load 'config/vendored_puppet'

server '172.16.1.10', :db
server '172.16.1.11', :db
server '172.16.1.12', :db

task :dist_upgrade do
  sudo "apt-get -qq update"
  sudo "apt-get -qq -y dist-upgrade"
end
