name 'jira_war_distribution'
description 'deploying jira war on tomcat'
run_list [
  "recipe[jira_war_distribution::default]"
]
override_attributes :tomcat => {
  :base_version =>  7
}

