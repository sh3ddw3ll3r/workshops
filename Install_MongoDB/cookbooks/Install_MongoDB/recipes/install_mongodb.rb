
mongo_repo_file = '/etc/yum.repos.d/mongodb.repo'

template mongo_repo_file do
  source 'mongodb.repo.erb'
end

yum_package 'mongodb-org'