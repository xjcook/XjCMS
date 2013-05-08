require "rvm/capistrano"
require "bundler/capistrano"

set :application, "XjCMS"
set :user, "cms"
set :use_sudo, false
set :scm, :git
set :repository,  "git@github.com:xjcook/XjCMS.git"
set :deploy_to, "/home/cms/apps"
set :deploy_via, :remote_cache
set :rvm_ruby_string, '1.9.3'
set :rvm_type, :user  # Don't use system-wide RVM 

ssh_options[:forward_agent] = true
default_run_options[:pty] = true

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

server "xjcook.net", :app, :web, :db, :primary => true

# role :web, "your web-server here"                          # Your HTTP server, Apache/etc
# role :app, "your app-server here"                          # This may be the same as your `Web` server
# role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
# role :db,  "your slave db-server here"

# make database migrations after deploy
after 'deploy:update_code', 'deploy:migrate'

# if you want to clean up old releases on each deploy uncomment this:
set :keep_releases, 5
after "deploy:restart", "deploy:cleanup"

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
