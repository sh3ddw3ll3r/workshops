# encoding: utf-8
# copyright: 2015, The Authors
# license: All rights reserved

title 'Windows WinRM'


# WinRM type
control 'windows-winrm-type' do 
  impact 0.7 
  title 'WinRM Settings type 0x10 (16)'
  desc 'Validate that WinRM Settings type 0x10 (16) for target system'
  describe registry_key('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WinRM') do 
    it { should exist }
    its('Type') { should eq 16 }
  end
end