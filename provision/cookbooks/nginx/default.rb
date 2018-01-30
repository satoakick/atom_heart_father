include_recipe "nginx_build"
include_recipe "nginx_build::install"

template "/etc/nginx/nginx.conf" do
  source "templates/etc/nginx/conf.d/dynamic.conf.erb"
  mode "644"
  owner "root"
  group "root"
end
