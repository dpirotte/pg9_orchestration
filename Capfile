load 'config/vendored_puppet'

server '172.16.1.10', :db
server '172.16.1.11', :db
server '172.16.1.12', :db

task :dist_upgrade do
  sudo "apt-get -s update && apt-get -y -s dist-upgrade"
end
