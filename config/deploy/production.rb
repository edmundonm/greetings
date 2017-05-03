set :application, 'Greetings'
set :repo_url, 'git@github.com:edmundonm/greetings.git'
set :user, 'ubuntu'
set :rbenv_ruby, '2.2.3'
set :stage, :production
server '52.53.193.231', user: 'ubuntu', roles: %w{app web db}
