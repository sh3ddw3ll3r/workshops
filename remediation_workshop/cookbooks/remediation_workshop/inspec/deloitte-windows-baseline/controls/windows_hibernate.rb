# encoding: utf-8
# copyright: 2015, The Authors
# license: All rights reserved

title 'Windows Hibernate'


# you add controls here
control 'windows-hibernate-disabled' do 
  impact 0.5 
  title 'Hibernate Not Enabled'
  desc 'Validate that Windows Hibernation is disabled for target system'
  describe registry_key('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power') do 
    it { should exist }
    its('HibernateEnabled') { should eq 0 }
  end
end
