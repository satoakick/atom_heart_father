USER_NAME = "vitaminc"
NGINX_NAME = "nginx"
SSH_KEY = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCENMWgeDaCJ29Fr3jhI5v6dz9tYIlIuE2dMKI2ahegIpULpmoILs7IYWZnCgxMzMFDUFmQvBZiH2aGt7DeqruHL5ny8n6poqpO861mbLznPg7kFMRzYS+e3zekZNHdzft/mfEzaJjh7ean/A4hadXZCw+ky1sQfyq//AMezPH0sPIEUbrEhPpGeC2voj5a3j0xZ9BTGtAGZ1dLyaIVHrsgxiqFOAlhwW2iiTJt+yEsp7CQ44rVnuNp7mI16XDJ5oVSDLzIzwsBjQEQD6r+SUyC19d0ExIXUiGOGTjteX+6ANfIpgetIl4oHVB38nNxHwZsTmY/5Rwrv0PFxWio0D3X mhack_default"

WHEEL_GID = "10"
user USER_NAME do
  username USER_NAME
  password '$6$salt$Tiljjtk92JmZYKOcy9RD2xlm8Y5pWZ/j6qTm4tfJojIXckqCcYKl7cepdAGfUf1dahPJbhDqiK8w9YDx6LEy8.'
  #password '$6$salt$zsxi7Wpb.eWuwWf44mm2BJc9/OJ5P/Dg7uugu06M/rDf2hVCV20Nm1jFBGxARP9MBLTmh00aZ663RqKb5EYXU.'
end

user USER_NAME do
  gid NGINX_NAME
end

execute "add #{USER_NAME} to wheel" do
  only_if "id #{USER_NAME}"
  not_if "getent group wheel | grep #{USER_NAME}"
  command "usermod -aG wheel #{USER_NAME}"
end

directory "/home/#{USER_NAME}/.ssh" do
  owner USER_NAME
  group NGINX_NAME
  mode "700"
end

file "/home/#{USER_NAME}/.ssh/authorized_keys" do
  content SSH_KEY
  owner USER_NAME
  group NGINX_NAME
  mode  "600"
end

# sudo可能にする
template "/etc/sudoers" do
  source "templates/sudoers"
  mode   "440"
  owner  "root"
  group  "root"
end
