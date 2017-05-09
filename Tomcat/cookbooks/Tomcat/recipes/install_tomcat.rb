# download Tomcat from link defined in attributes
remote_file "/tmp/#{node[:tomcat][:archivefile]}" do
  source node[:tomcat][:archiveurl]
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

# create Tomcat install directory and untar downloaded archive 
bash 'extract_tomcat' do
  code <<-EOH
    mkdir -p #{node[:tomcat][:installdir]}
    tar xzf /tmp/#{node[:tomcat][:archivefile]} -C #{node[:tomcat][:installdir]} --strip-components=1
    EOH
  not_if { ::File.exist?("#{node[:tomcat][:installdir]}") }
end

# set permissions on the tomcat install directory
# https://tomcat.apache.org/tomcat-8.0-doc/security-howto.html#Non-Tomcat_settings
# set group to tomcat for tomcat installation
execute "change-owner-tomcat" do
    command "chown -R root:#{node[:tomcat][:group]} #{node[:tomcat][:installdir]}"
    user 'root'
end

# set permissions to 740 for tomcat installation
execute "change-permissions-tomcat" do
    command "chmod -R 0750 #{node[:tomcat][:installdir]}"
    user 'root'
end

# set permissions to 740 for tomcat installation
execute "change-permissions-tomcat-bin" do
    command "chmod -R 0770 #{node[:tomcat][:installdir]}/bin"
    user 'root'
end

# change ownership and permissions of work, temp and logs directories
%w{work temp logs}.each do |subdir|
    # change ownership to tomcat:tomcat for work, temp and logs directories
    execute "change-owner-#{subdir}" do
        command "chown -R #{node[:tomcat][:user]}:#{node[:tomcat][:group]} #{node[:tomcat][:installdir]}/#{subdir}"
        user 'root'
    end

    # change permissions to 770 for work, temp and logs directories
    execute "change-permissions-#{subdir}" do
        command "chmod -R 770 #{node[:tomcat][:installdir]}/#{subdir}"
        user 'root'
    end
end

# set variable for path to tomcat.service file
tomcat_service_file = '/etc/systemd/system/tomcat.service'

# build the tomcat.service file from a template
template tomcat_service_file do
  source 'tomcat.service.erb'
end

# reload systemctl to pick up the new Tomcat service
#execute "reload-systemctl" do
#    command "systemctl daemon-reload"
#    user 'root'
#end
#
## Enable Tomcat service to start on boot
#execute "enable-tomcat-on-boot" do
#    command "systemctl enable tomcat"
#    user 'root'
#end
#
## Start the new Tomcat service
#execute "start-tomcat" do
#    command "systemctl start tomcat"
#    user 'root'
#end

# no errors, but TOmcat didn't start'
# Start and enable the Tomcat service
service "tomcat" do
  action [:enable, :start]
end