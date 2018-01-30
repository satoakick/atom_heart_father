# atom_heart_father
This is the JPEG image resizer.  
Based on [unicorn](https://bogomips.org/unicorn/) and [Shrine](http://shrinerb.com/).

# Getting Started

rename config/settings.yml
```
root_dir: /Users/satoakick/dev/atom_heart_father # set as you like
application_dir: /Users/satoakick/dev/atom_heart_father # set as you like
```

start unicorn
```
bundle exec unicorn -c config/unicorn.rb
```

# provisioning(AWS EC2)
You can provision production environment at EC2.  
Before provision, you should set host(/etc/host or ~/.ssh/config) and key($EC2_PRIVATE_KEY) in the .bashrc  

Let's provision!
```
cd provision
./exec.sh
```

# deploy to AWS EC2
You can deploy to AWS EC2 by [capistrano](http://capistranorb.com/).  
First, you encrypt config/encrypted_secrets.yml by using [yaml_vault](https://github.com/joker1007/yaml_vault).  
Second, you decrypt config/encrypted_secrets.yml to config/secrets.yml by using [yaml_vault](https://github.com/joker1007/yaml_vault).  
Third, you deploy to EC2 setting in the config/deploy.rb and config/deploy/production.rb

