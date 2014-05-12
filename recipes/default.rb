#
# Cookbook Name:: jira_war_distribution
# Recipe:: default
#
# Copyright (C) 2014 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

package "zip"
include_recipe "apt"
include_recipe "tomcat"

jira_version = node["jira"]["version"]
jira_install_dir = node["jira"]["install-dir"]
jira_war_dir = "#{jira_install_dir}/atlassian-jira-#{jira_version}-war"
jira_lib_dir = "#{jira_war_dir}/webapp/WEB-INF/lib"
tomcat_dir = node["tomcat"]["base"]
jira_home_dir = node["jira"]["jira-home"]
war_file_name = "atlassian-jira-#{jira_version}-war.tar.gz"

if node['tomcat']['base_version'] == 6
  jira_tomcat_libraries = "jira-jars-tomcat-distribution-6.3-m03-tomcat-6x.zip"
elsif node['tomcat']['base_version'] == 7
  jira_tomcat_libraries = "jira-jars-tomcat-distribution-6.3-m03-tomcat-7x.zip"
else
  raise Chef::Application.fatal!("Only Tomcat 6 and Tomcat 7 are supoorted")
end

# Download jira war distribution
remote_file "#{Chef::Config[:file_cache_path]}/#{war_file_name}" do
  source "http://www.atlassian.com/software/jira/downloads/binary/#{war_file_name}"
end

# Download other libraries
remote_file "#{Chef::Config[:file_cache_path]}/#{jira_tomcat_libraries}" do
  source "http://www.atlassian.com/software/jira/downloads/binary/#{jira_tomcat_libraries}" 
end

# create directories
[ {:path => "#{tomcat_dir}/lib"}, {:path => jira_home_dir, :mode => 00777}, {:path => jira_install_dir, :mode => 00777} ].each do |dir|
  directory dir[:path] do
    owner dir[:owner] if dir[:owner]
    group dir[:group] if dir[:group] 
    mode dir[:mode] if dir[:mode]
  end
end

bash "unzip-jira-war" do
  user "root"
  code <<-EOH
  sudo tar -zxf #{Chef::Config[:file_cache_path]}/#{war_file_name} -C #{jira_install_dir}
  cd #{jira_war_dir}
  sed -i 's/jira.home =/ jira.home = \\/opt\\/jira-home/' #{jira_war_dir}/edit-webapp/WEB-INF/classes/jira-application.properties
  sh build.sh
  EOH
end

bash "unzip-jira-libraries-for-tomcat" do
  user "root"
  cwd tomcat_dir
  code <<-EOH
  rm -f #{jira_lib_dir}/jcl-over-slf4j-*.jar #{jira_lib_dir}/jul-to-slf4j-*.jar #{jira_lib_dir}/log4j-*.jar #{jira_lib_dir}/slf4j-api-*.jar #{jira_lib_dir}/slf4j-log4j12-*.jar
  unzip -u #{Chef::Config[:file_cache_path]}/#{jira_tomcat_libraries} -d lib/
  EOH
end

bash "deploy-jira-using-context-descriptor" do
  user "root"
  code <<-EOH
  cp #{jira_war_dir}/dist-tomcat/tomcat-6/jira.xml #{tomcat_dir}/conf/Catalina/localhost/
  EOH
end

service "tomcat" do
  action :restart
end
