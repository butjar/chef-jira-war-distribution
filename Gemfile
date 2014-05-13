source 'https://rubygems.org'

gem 'berkshelf'

group :development do
  gem "vagrant", github: "mitchellh/vagrant", tag: "v1.5.2"
end

group :plugins do
  gem "vagrant-berkshelf", github: "berkshelf/vagrant-berkshelf"
  gem "vagrant-omnibus", github: "schisamo/vagrant-omnibus"
end

gem 'test-kitchen'
gem 'kitchen-vagrant'

group :test do
  gem 'serverspec'
end
