node.default["jira"]["version"] = "6.2.4"
node.default["jira"]["jira-home"] = "/opt/jira-home"
node.default["jira"]["install-dir"] = "/opt"

# overriding tomcat default values
#node.override["tomcat"]["base_version"] = 7
#default['tomcat']['group'] = "tomcat#{node["tomcat"]["base_version"]}"
#node.override['tomcat']['config_dir'] = "/etc/tomcat#{node["tomcat"]["base_version"]}"
node.override["tomcat"]["java_options"] = '-server -Xms2048m -Xmx2048m -XX:MaxPermSize=512m -Djava.awt.headless=true'
