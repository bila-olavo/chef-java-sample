#!/bin/bash
yum install git-core -y
curl -L https://www.chef.io/chef/install.sh | bash
mkdir /glovo
git clone https://github.com/bila-olavo/chef-java-sample.git /glovo
cat <<EOF > /glovo/solo.rb
file_cache_path "/glovo/chef-solo"
cookbook_path "/glovo/chef-solo/cookbooks"
EOF
cat <<EOF > /glovo/execution.json
{ "run_list": [ "recipe[java-service]" ] }
EOF
chef-solo -c /glovo/solo.rb -j /glovo/execution.json 

exit 0 