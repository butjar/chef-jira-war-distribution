# jira_war_distribution-cookbook

Description
===========

Installs JIRA WAR and Tomcat seperatly using the following install instructions: https://confluence.atlassian.com/display/JIRA061/Installing+JIRA+on+Tomcat+6.0+or+7.0

## Supported Platforms

TODO: List your supported platforms.

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['jira_war_distribution']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

## Usage

### jira_war_distribution::default

Include `jira_war_distribution` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[jira_war_distribution::default]"
  ]
}
```

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (i.e. `add-new-recipe`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request

## License and Authors

Author:: Martin Fleischer (<martin.t.fleischer@gmail.com>)
