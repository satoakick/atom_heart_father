cd ../
host="converter" # you set /etc/host or ~/.ssh/config
key=$EC2_PRIVATE_KEY

bundle exec itamae ssh --host $host -i $key -u ec2-user provision/recipes/web.rb -y provision/nodes/production.yml

cd -
