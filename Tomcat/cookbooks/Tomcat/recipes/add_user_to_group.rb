# add Tomcat user to the Tomcat group
group node[:tomcat][:group] do
  action :modify
  members node[:tomcat][:user]
  append true
end