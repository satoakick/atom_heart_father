# config valid only for current version of Capistrano
lock '3.6.1'

set :application, 'atom_heart_father'
set :repo_url, 'git@github.com:satoakick/atom_heart_father.git'
set :deploy_to, '/var/www/atom_heart_father'
set :rbenv_type, :system
set :rbenv_ruby, File.read('.ruby-version').strip

# detail log
set :format, :pretty
set :log_level, :debug

set :bundle_jobs, 4

set :bundle_binstubs, -> { shared_path.join('bin') }

append :linked_files, 'config/secrets.yml'
append :linked_dirs, 'log', 'tmp/pids', 'tmp/sockets', 'vendor/bundle'

# unicorn settings
set :unicorn_pid, "#{shared_path}/tmp/pids/unicorn.pid"
set :unicorn_config_path, "config/unicorn.rb"
set :unicorn_rack_env, :deployment


# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, 'config/database.yml', 'config/secrets.yml'

# Default value for linked_dirs is []
# append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system'

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5
