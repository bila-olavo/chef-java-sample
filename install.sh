#!/bin/bash
curl -L https://www.chef.io/chef/install.sh | bash
cat <<EOF > /glovo/solo.rb
file_cache_path "/glovo/chef-solo"
cookbook_path "/glovo/chef-solo/cookbooks"
EOF
cat <<EOF > /glovo/execution.json
{ "run_list": [ "recipe[java-service]" ] }
EOF
chef-solo -c /glovo/solo.rb -j /glovo/execution.json 

exit 0 