# encoding: utf-8
# copyright: 2015, The Authors
# license: All rights reserved

title 'Windows HTTP'


# Windows HTTP
control 'windows-http-settings' do 
  impact 0.7 
  title 'Windows HTTP  Settings'
  desc 'Validate Windows HTTP settings for target system'
  describe registry_key('HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\HTTP\Parameters') do 
    it { should exist }
    its('MaxFieldLength') { should eq 65534 }
    its('MaxRequestBytes') { should eq 65534 }
  end
end