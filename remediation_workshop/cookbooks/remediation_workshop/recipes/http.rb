#
# Cookbook Name:: gts_cto_gpo
# Recipe:: http
#
# Copyright (c) 2017 Eric Hunsberger, All Rights Reserved.

registry_key 'HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\HTTP\Parameters' do
  action :create
end

# Set HTTP MaxFieldLength and MaxRequestBytes
http_values = ['MaxFieldLength', 'MaxRequestBytes']
http_values.each do |i|
  powershell_script i do
    code <<-EOH
      Set-ItemProperty -Path 'HKLM:\\System\\CurrentControlSet\\Services\\HTTP\\Parameters' -Name #{i} -Value 65534
    EOH
    not_if {
      registry_data_exists?(
        'HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\HTTP\Parameters',
        {
          :name => '#{i}', 
          :type => :dword, 
          :data => 65534 
        }
      )
    }
  end
end

# powershell_script 'http-maxrequestbytes' do
#   code <<-EOH
#   powershell code
#   EOH
#   not_if {
#     registry_data_exists?(
#       'HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\HTTP\Parameters',
#       {
#         :name => 'MaxRequestBytes', 
#         :type => :dword, 
#         :data => 65534 
#       }
#     )
#   }
# end
