package 'git' do
  action :install
end

include_recipe "../cookbooks/imagemagick/default.rb"

include_recipe "../cookbooks/ruby/default.rb"

include_recipe "../cookbooks/nginx/default.rb"

include_recipe "../cookbooks/user/default.rb"

directory '/var/www/' do
  mode '775'
  owner 'root'
  group 'root'
end

NGINX_NAME = "nginx"
USER_NAME = "vitaminc"
directory node[:nginx][:base_dir] do
  mode '775'
  owner NGINX_NAME
  group NGINX_NAME
end

directory node[:nginx][:base_dir] + "/shared/" do
  mode '755'
  owner USER_NAME
  group NGINX_NAME
end

directory node[:nginx][:base_dir] + "/shared/config/" do
  mode '755'
  owner USER_NAME
  group NGINX_NAME
end
