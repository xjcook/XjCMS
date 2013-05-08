require "rvm/capistrano"
require "bundler/capistrano"

set :application, "XjCMS"
set :repository,  "git@github.com:xjcook/XjCMS.git"
set :scm, :git
set :user, "cms"
set :use_sudo, false
set :deploy_to, "/home/cms/apps"
set :deploy_via, :remote_cache
set :rvm_ruby_string, '1.9.3'
set :rvm_type, :user  # Don't use system-wide RVM 
set :keep_releases, 5

# SSH 
ssh_options[:forward_agent] = true  # use local keys on server
default_run_options[:pty] = true    # 

server "xjcook.net", :app, :web, :db, :primary => true
# role :web, "your web-server here"                          # Your HTTP server, Apache/etc
# role :app, "your app-server here"                          # This may be the same as your `Web` server
# role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
# role :db,  "your slave db-server here"

# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

# Skip asset compilation if unneeded
namespace :deploy do
  namespace :assets do
    task :precompile, :roles => :web, :except => { :no_release => true } do
      from = source.next_revision(current_revision)
      if capture("cd #{latest_release} && #{source.local.log(from)} vendor/assets/ app/assets/ | wc -l").to_i > 0
        run %Q{cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} #{asset_env} assets:precompile}
      else
        logger.info "Skipping asset pre-compilation because there were no asset changes"
      end
    end
  end
end

# Make symlink to database.yml
after 'deploy:update_code', 'deploy:symlink_db'

namespace :deploy do
  desc "Symlinks the database.yml"
  task :symlink_db, :roles => :app do
    run "ln -nfs #{deploy_to}/shared/config/database.yml #{release_path}/config/database.yml"
  end
end

# Make smart database migrations
after 'deploy:update_code', 'db_migrations:migrate'

namespace :db_migrations do
  task :migrate do
    from = source.next_revision(current_revision)
    if capture("cd #{latest_release} && #{source.local.log(from)} db/migrate | wc -l").to_i > 0
      run "cd #{current_release} && RAILS_ENV=#{rails_env} bundle exec rake db:migrate"
      logger.info "New migrations added - running migrations."
    else
      logger.info "Skipping migrations - there are not any new."
    end
  end
end