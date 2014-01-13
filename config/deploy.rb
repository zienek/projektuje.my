require 'rvm/capistrano'
require 'bundler/capistrano'

#RVM and bundler settings
set :bundle_cmd, "/usr/local/rvm/gems/ruby-2.0.0-p353/gems/bundler-1.5.2/bin/bundle"
set :bundle_dir, "/usr/local/rvm/gems/ruby-2.0.0-p353/gems/"
#set :rvm_ruby_string, :local
set :rack_env, :production

#general info
set :user, 'root'
set :use_sudo, false
set :domain, 'prototypujemy.pl'
set :applicationdir, "/root/dev/prototypujemy"
set :application, "app"

set :scm, :git 
set :repository,  "git@github.com/zienek/projektuje.my.git"
set :branch, 'master'
set :git_shallow_clone, 1
set :scm_verbose, true

set :deploy_via, :remote_cache
#set :deploy_via, :export
set :deploy_to, applicationdir 

#set :host, "#{user}@#{domain}"

role :web, domain
role :app, domain
role :db,  domain, :primary => true # This is where Rails migrations will run

# ssh_options[:forward_agent] = true
# ssh_options[:keys] = [File.join('/root/', ".ssh", "id_rsa")]
# ssh_options[:paranoid] = false
# default_run_options[:pty] = true

# after "deploy:cold" do
#   admin.nginx_restart
# end


# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
 end