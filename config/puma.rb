threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }.to_i
threads threads_count, threads_count

port        ENV.fetch("PORT") { 3000 }

# Specifies the `environment` that Puma will run in.
environment ENV.fetch("RAILS_ENV") { Rails.env || "production" }

# Specifies the .sock and .pid files that puma binds to
app_dir = File.expand_path("../..", __FILE__)
shared_dir = Rails.env.production? ? "#{app_dir}/shared" : 'tmp'
bind "unix://#{shared_dir}/tmp/sockets/puma.sock"
pidfile "#{shared_dir}/pids/puma.pid"

## The code in the `on_worker_boot` will be called if you are using
# clustered mode by specifying a number of `workers`.
on_worker_boot do
  require "active_record"
  ActiveRecord::Base.connection.disconnect! rescue ActiveRecord::ConnectionNotEstablished
  ActiveRecord::Base.establish_connection(YAML.load_file("#{app_dir}/config/database.yml")[rails_env])
end

# Allow puma to be restarted by `rails restart` command.
plugin :tmp_restart
