namespace :deploy do

  desc 'Decrypt secrets file'
  task :decrypt_secrets do
    run_locally do
      Bundler.with_clean_env do
        execute "bundle exec yaml_vault decrypt config/encrypted_secrets.yml \
                 -o config/secrets.yml \
                 --cryptor=aws-kms"
      end
    end
  end

  task :upload do
    on roles(:app) do |host|
      if test "[ ! -d #{shared_path}/config ]"
        execute "mkdir -p #{shared_path}/config"
      end
      upload!('config/secrets.yml', "#{shared_path}/config/secrets.yml")
    end
  end

  desc 'clean secrets file'
  task :clean_secrets do
    run_locally do
      if test "[ -f config/secrets.yml ]"
        execute "rm config/secrets.yml"
      end
    end
  end

  task :restart do
    invoke 'unicorn:restart'
  end
end

before 'deploy:starting', 'deploy:decrypt_secrets'
before 'deploy:starting', 'deploy:upload'

after 'deploy:publishing', 'deploy:clean_secrets'
# Capistrano 3.1.0 からデフォルトで deploy:restart タスクが呼ばれなくなったので、ここに以下の1行を書く必要がある
after 'deploy:publishing', 'deploy:restart'
# bundle cleanup
after 'deploy:published', 'bundler:clean'
