set :application, "Prototypujemy.pl"
set :repository,  "git@github.com:zienek/projektuje.my.git"

set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names

set :domain, "prototypujemy.pl"

set :user, 'root'
set :applicationdir, "/root/dev/prototypujemy"

role :web, domain                          # Your HTTP server, Apache/etc
role :app, domain
# may be the same as your `Web` server
role :db,  domain, :primary => true # This is where Rails migrations will run


set :deploy_to, applicationdir
set :deploy_via, :export

ssh_options[:forward_agent] = true
ssh_options[:keys] = [File.join(ENV["HOME"], ".ssh", "prototypujemy_root_rsa")]
ssh_options[:paranoid] = false
default_run_options[:pty] = true

after "deploy:cold" do
  admin.nginx_restart
end

namespace :deploy do
  desc "Not starting as we're running passenger."
  task :start do
  end
end
# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end