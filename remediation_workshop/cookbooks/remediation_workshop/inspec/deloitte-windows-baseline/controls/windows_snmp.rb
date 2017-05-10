# encoding: utf-8
# copyright: 2015, The Authors
# license: All rights reserved

title 'Windows SNMP'


# Windows SNMP Managers
control 'windows-snmp-permitted-managers' do 
  impact 0.5 
  title 'Windows SNMP Permitted Managers'
  desc 'Validate Windows SNMP Permitted Managers for target system'
  describe registry_key('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SNMP\Parameters\PermittedManagers') do 
    it { should exist }
    it { should have_property_value('1', :string, 'localhost') }
    it { should have_property_value('2', :string, '10.247.160.224') }
    it { should have_property_value('3', :string, '10.248.160.224') }
    it { should have_property_value('4', :string, '10.236.160.119') }
    it { should have_property_value('5', :string, '10.237.160.109') }
    it { should have_property_value('6', :string, '10.236.160.221') }
    it { should have_property_value('7', :string, '10.247.160.208') }
    it { should have_property_value('8', :string, '10.247.160.220') }
  end
end

# Windows SNMP Communities
control 'windows-snmp-communities' do 
  impact 0.5 
  title 'Windows SNMP Communities'
  desc 'Validate Windows SNMP Communities for target system'
  describe registry_key('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SNMP\Parameters\ValidCommunities') do 
    it { should exist }
    it { should have_property_value('JK38us2Mf9A', :dword, 4) }
  end
end