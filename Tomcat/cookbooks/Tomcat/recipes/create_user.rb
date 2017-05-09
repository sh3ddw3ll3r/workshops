# Create the Tomcat user
user node[:tomcat][:user] do
  comment "Tomcat user"
  uid node[:tomcat][:usergid]
  gid node[:tomcat][:groupgid]
  home "/home/#{node[:tomcat][:user]}"
  shell "/bin/bash"
  password node[:tomcat][:password]
end

directory "/home/#{node[:tomcat][:user]}" do
    owner node[:tomcat][:user]
    group node[:tomcat][:group]
    mode '0700'
    action :create
end