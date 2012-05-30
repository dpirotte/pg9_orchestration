load 'config/vendored_puppet'

default_run_options[:pty] = true

servers = %w{ db1 db2 db3 }

servers.each do |server|
  task server do
    role :server, server
  end
end

task :all do
  role :server, *servers
end

namespace :postgres do
  [:start, :stop].each do |command|
    task command do
      sudo "/etc/init.d/postgresql #{command}"
    end
  end
end

task :nuke do
  postgres.stop rescue nil
  sudo "rm -rf /var/lib/postgresql/9.1/main"
  sudo "/usr/lib/postgresql/9.1/bin/initdb -D /var/lib/postgresql/9.1/main --encoding=UTF8 --locale=en_US.UTF8", :as => "postgres"
  puppet.apply
  postgres.start
  sudo "createuser -s repmgruser", :as => "postgres"
  sudo "createdb -O repmgruser repmgrdb", :as => "postgres"
end

namespace :setup do
  task :master do
    sudo "killall -9 repmgrd || /bin/true"
    repmgr "master register"
  end

  task :standby do
    sudo "killall -9 repmgrd || /bin/true"
    sudo "/etc/init.d/postgresql stop"
    repmgr "--force standby clone #{ENV['MASTER']}"
    sudo "/etc/init.d/postgresql start"
    repmgr "standby register"
    sleep 5
    sudo "repmgrd -f /var/lib/postgresql/repmgr/repmgr.cfg --verbose", :as => "postgres"
  end
end

def repmgr(command)
  sudo "repmgr -f /var/lib/postgresql/repmgr/repmgr.cfg --verbose #{command}", :as => "postgres"
end
