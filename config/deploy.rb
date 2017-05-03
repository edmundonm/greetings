# config valid only for current version of Capistrano
lock "3.8.1"

set :application, "Greetings"
set :repo_url, "git@github.com:edmundonm/greetings.git"
set :deploy_to, "/home/ubuntu/apps/Greetings"
set :branch, 'master'


append :linked_files, "config/database.yml", "config/secrets.yml"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

set :pty,             true
set :use_sudo,        false
set :stage,           :production
set :deploy_via,      :remote_cache

set :rbenv_type, :user # or :system, depends on your rbenv setup
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true  # Change to true if using ActiveRecord


namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end
  # before :start, :make_dirs
end
