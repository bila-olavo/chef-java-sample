#!/bin/bash
yum install git-core -y
curl -L https://www.chef.io/chef/install.sh | bash
mkdir /glovo
git clone https://github.com/bila-olavo/chef-java-sample.git /glovo
