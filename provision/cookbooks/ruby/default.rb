package 'gcc-c++'
package 'glibc-headers'
package 'openssl-devel'
package 'readline'
package 'libyaml-devel'
package 'readline-devel'
package 'zlib'
package 'zlib-devel'
package 'libffi-devel'
package 'libxml2'
package 'libxml2-devel'
package 'libxslt'
package 'libxslt-devel'
package 'mysql-devel'

RBENV_DIR = '/usr/local/rbenv'
RBENV_SCRIPT = '/etc/profile.d/rbenv.sh'

execute "cd /usr/local && git clone git://github.com/sstephenson/rbenv.git" do
  not_if "test -d #{RBENV_DIR}"
end

execute "mkdir /usr/local/rbenv/shims" do
  command "sudo mkdir -p /usr/local/rbenv/shims"
end

execute "mkdir /usr/local/rbenv/versions" do
  command "sudo mkdir -p /usr/local/rbenv/versions"
end

remote_file RBENV_SCRIPT do
  source '../../recipes/remote_files/rbenv.sh'
end

execute "set owner and mode for #{RBENV_SCRIPT}" do
  command "chown root: #{RBENV_SCRIPT}; chmod 644 #{RBENV_SCRIPT}"
  user "root"
end

execute "mkdir #{RBENV_DIR}/plugins" do
  not_if "test -d #{RBENV_DIR}/plugins"
end

git "#{RBENV_DIR}/plugins/ruby_build" do
  repository "git://github.com/sstephenson/ruby-build.git"
end

node["rbenv"]["versions"].each do |version|
  execute "install ruby #{version}" do
    command "source #{RBENV_SCRIPT}; rbenv install #{version}"
    not_if "source #{RBENV_SCRIPT}; rbenv versions | grep #{version}"
  end
end

execute "set global ruby #{node["rbenv"]["global"]}" do
  command "source #{RBENV_SCRIPT}; rbenv global #{node["rbenv"]["global"]}; rbenv rehash"
  not_if "source #{RBENV_SCRIPT}; rbenv global | grep #{node["rbenv"]["global"]}"
end

node["rbenv"]["gems"].each do |gem|
  execute "gem install #{gem}" do
    command "source #{RBENV_SCRIPT}; gem install #{gem}; rbenv rehash"
    not_if "source #{RBENV_SCRIPT}; gem list | grep #{gem}"
  end
end
