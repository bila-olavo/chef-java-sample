#
# Cookbook Name:: java-service
# Recipe:: default
#
# Copyright 2018, olavoqg
#
# All rights reserved - Do Not Redistribute
#
%W{ wget java-1.8.0-openjdk }.each do |package_name|
  package package_name
end

user "java-user" do
  comment "Java User"
  gid "users"
  home "/home/java-user"
  shell "/bin/bash"
end

%w[  /glovo/logs ].each do |path|
  directory path do
    owner 'java-user'
    group 'users'
    mode '0755'
    recursive true
  end
end

#need refactoring
bash 'downloadjar' do
  cwd "/glovo"
  code <<-EOH
  pip install boto3
  ./downloader.py https://s3-eu-west-1.amazonaws.com/glovo-public/systems-engineer-interview-1.0-SNAPSHOT.jar
  EOH
  action :run
end

template "/etc/init.d/java-service" do
  owner "java-user"
  group "users"
  mode 0755
  source "service.erb"
  variables(
    :services_final_dir => "/glovo",
    :application => "java-service",
    :java_opts => "-Xms1024m -Xmx1024m -XX:PermSize=128M -XX:MaxPermSize=256M",
    :artefact => "/glovo/systems-engineer-interview-1.0-SNAPSHOT.jar",
    :user => "java-user" 
  )
end

cron 'chef-cron' do
  hour '*'
  minute '*'
  command 'chef-solo -c /glovo/solo.rb -j /glovo/execution.json'
  action :create
end


service "java-service" do
  action [ :enable, :start ]
end
