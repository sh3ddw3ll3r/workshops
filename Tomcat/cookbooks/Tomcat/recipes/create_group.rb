# create a group as provided in the attributes
group node[:tomcat][:group] do
  action :create
  gid node[:tomcat][:groupgid]
end