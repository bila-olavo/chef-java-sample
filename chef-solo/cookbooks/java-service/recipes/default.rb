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
  supports :manage_home => true
  comment "Java User"
  gid "users"
  home "/home/java-user"
  shell "/bin/bash"
end

%w[ "/glovo" "/glovo/logs" ].each do |path|
  directory path do
    owner 'root'
    group 'root'
    mode '0755'
    recursive true
  end
end

template "/etc/init.d/java-service" do
  owner "root"
  group "root"
  mode 0755
  source "service.erb"
  variables(
    :services_final_dir => "/glovo",
    :application => "java-service"
    :java_opts => "-Xms1024m -Xmx1024m -XX:PermSize=128M -XX:MaxPermSize=256M" 
    :artefact => "/glovo/systems-engineer-interview-1.0-SNAPSHOT.jar"
    :user => "java-user" 
  )
end

service "#{service}-service" do
  action [ :enable, :restart ]
end
