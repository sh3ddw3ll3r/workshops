def random_password
  require 'securerandom'
  password = SecureRandom.base64
  until password =~ /[A-Z]/ && password =~ /[a-z]/ && password =~ /[0-9]/
    password = SecureRandom.base64
  end
  password
end

default['sql_server']['accept_eula'] = true
default['sql_server']['version'] = '2012'
default['sql_server']['instance_name']  = 'MSSQLSERVER'
default['sql_server']['update_enabled'] = false
default_unless['sql_server']['server_sa_password'] = random_password