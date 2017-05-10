# encoding: utf-8
# copyright: 2015, The Authors
# license: All rights reserved

title 'Windows Security'


# Schannel SSL 2.0
control 'windows-schannel-ssl2.0-client-disabled' do 
  impact 0.7 
  title 'Schannel SSL 2.0 Client disabled'
  desc 'Validate that Schannel SSL 2.0 Client is disabled for target system'
  describe registry_key('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Client') do 
    it { should exist }
    its('DisabledByDefault') { should eq 1 }
    its('Enabled') { should eq 0 }
  end
end

control 'windows-schannel-ssl2.0-server-disabled' do 
  impact 0.7 
  title 'Schannel SSL 2.0 Server disabled'
  desc 'Validate that Schannel SSL 2.0 Server is disabled for target system'
  describe registry_key('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Server') do 
    it { should exist }
    its('DisabledByDefault') { should eq 1 }
    its('Enabled') { should eq 0 }
  end
end

#Schannel SSL 3.0
control 'windows-schannel-ssl3.0-client-disabled' do 
  impact 0.7 
  title 'Schannel SSL 3.0 Client disabled'
  desc 'Validate that Schannel SSL 3.0 Client is disabled for target system'
  describe registry_key('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Client') do 
    it { should exist }
    its('DisabledByDefault') { should eq 1 }
    its('Enabled') { should eq 0 }
  end
end

control 'windows-schannel-ssl3.0-client-disabled' do 
  impact 0.7 
  title 'Schannel SSL 3.0 Server disabled'
  desc 'Validate that Schannel SSL 3.0 Server is disabled for target system'
  describe registry_key('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Server') do 
    it { should exist }
    its('DisabledByDefault') { should eq 1 }
    its('Enabled') { should eq 0 }
  end
end


#Schannel TLS 1.1
control 'windows-schannel-tls1.1-client-enabled' do 
  impact 0.7 
  title 'Schannel TLS 1.1 Client enabled'
  desc 'Validate that Schannel TLS 1. Client is enabled for target system'
  describe registry_key('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Client') do 
    it { should exist }
    its('DisabledByDefault') { should eq 0 }
    its('Enabled') { should eq 1 }
  end
end

control 'windows-schannel-tls1.1-server-enabled' do 
  impact 0.7 
  title 'Schannel TLS 1.1 Server enabled'
  desc 'Validate that Schannel TLS 1.1 Server is enabled for target system'
  describe registry_key('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server') do 
    it { should exist }
    its('DisabledByDefault') { should eq 0 }
    its('Enabled') { should eq 1 }
  end
end

#Schannel TLS 1.2
control 'windows-schannel-tls1.2-client-enabled' do 
  impact 0.7 
  title 'Schannel TLS 1.2 Client enabled'
  desc 'Validate that Schannel TLS 1.2 Client is enabled for target system'
  describe registry_key('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client') do 
    it { should exist }
    its('DisabledByDefault') { should eq 0 }
    its('Enabled') { should eq 1 }
  end
end

control 'windows-schannel-tls1.2-server-enabled' do 
  impact 0.7 
  title 'Schannel TLS 1.2 Server enabled'
  desc 'Validate that Schannel TLS 1.2 Server is enabled for target system'
  describe registry_key('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server') do 
    it { should exist }
    its('DisabledByDefault') { should eq 0 }
    its('Enabled') { should eq 1 }
  end
end

#Schannel RC4 Ciphers
control 'windows-schannel-rc4-ciphers-128_128-disabled' do 
  impact 0.7 
  title 'Schannel RC4 128/128 Ciphers disabled'
  desc 'Validate that Schannel RC4 128/128 Ciphers is disabled for target system'
  describe registry_key('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 128/128') do 
    it { should exist }
    its('Enabled') { should eq 0 }
  end
end

control 'windows-schannel-rc4-ciphers-40_128-disabled' do 
  impact 0.7 
  title 'Schannel RC4 40/128 Ciphers disabled'
  desc 'Validate that Schannel RC4 40/128 Ciphers is disabled for target system'
  describe registry_key('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 40/128') do 
    it { should exist }
    its('Enabled') { should eq 0 }
  end
end

control 'windows-schannel-rc4-ciphers-56_128-disabled' do 
  impact 0.7 
  title 'Schannel RC4 56/128 Ciphers disabled'
  desc 'Validate that Schannel RC4 56/128 Ciphers is disabled for target system'
  describe registry_key('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 56/128') do 
    it { should exist }
    its('Enabled') { should eq 0 }
  end
end