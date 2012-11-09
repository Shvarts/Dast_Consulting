require 'rvm/capistrano'
set :rvm_ruby_string, '1.9.3@ripple'
set :rvm_type, :system

# main details
set :application, "techripple"
set :location, "ec2-54-243-131-31.compute-1.amazonaws.com"
set :keep_releases, 10

role :web, location
role :app, location
role :db,  location, :primary => true

# server details
default_run_options[:pty] = true
ssh_options[:forward_agent] = true
set :deploy_to, "/var/www/#{application}"
set :deploy_via, :remote_cache
set :user, :giggil
set :use_sudo, false

# repo details
set :scm, :git
set :repository, "git@github.com:Giggil/Techripple.git"
set :branch, "master"
set :git_enable_submodules, 1

# tasks
namespace :deploy do
  task :start, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end

  task :stop, :roles => :app do
    # Do nothing.
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end

  desc "Copy configuration files into app directory"
  task :copy_config, :roles => :app do
    run "cp #{shared_path}/.rvmrc #{release_path}/.rvmrc"
    #run "cp #{shared_path}/.amazonrc #{release_path}/.amazonrc"
  end
end

namespace :database do
  desc "Symlink database.yml on each release"
  task :symlink_config, :roles => :app do
    run "rm #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
end


namespace :git do
  desc 'Shows a Git diff between the current version on server and latest on HEAD'
  task :diff_pending do
    local_sha = `git rev-parse --verify HEAD`
    remote_sha = capture("cd #{current_path}; git rev-parse --verify HEAD")
    puts `git diff #{remote_sha.strip} #{local_sha.strip}`
  end

  desc 'Shows a Git log between the current version on server and latest on HEAD'
    task :log_pending do
      local_sha = `git rev-parse --verify HEAD`
      remote_sha = capture("cd #{current_path}; git rev-parse --verify HEAD")
      puts `git log #{remote_sha.strip}..#{local_sha.strip}`
    end
end

after 'deploy:update_code', 'deploy:copy_config'
after 'deploy:update_code', 'database:symlink_config'


#role :web, "your web-server here"                          # Your HTTP server, Apache/etc
#role :app, "your app-server here"                          # This may be the same as your `Web` server
#role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

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