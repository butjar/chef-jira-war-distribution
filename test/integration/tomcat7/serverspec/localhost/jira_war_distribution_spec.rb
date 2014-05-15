require 'spec_helper'
require 'yaml'

tomcat_version = 7

describe package("tomcat#{tomcat_version}") do
  it { should be_installed }
end

describe service("tomcat#{tomcat_version}") do
  it { should be_enabled   }
  it { should be_running   }
end

describe port(8080) do
  it { should be_listening }
end
