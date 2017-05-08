
# set variable for path to mongodb.repo file
mongo_repo_file = '/etc/yum.repos.d/mongodb.repo'

# build the mongodb.repo file from a template, which builds based on OS architecture (32bit vs 64 bit)
template mongo_repo_file do
  source 'mongodb.repo.erb'
end

# install mongodb
yum_package 'mongodb-org' do
  action :install
end