# encoding: utf-8
# copyright: 2015, The Authors
# license: All rights reserved

title 'Windows Timezone'


# Windows Timezone
control 'windows-timezone-information' do 
  impact 0.7 
  title 'Windows Timezone Settings'
  desc 'Validate Windows Timezone settings for target system'
  describe registry_key('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\TimeZoneInformation') do 
    it { should exist }
    its ("Default") { should eq nil }
    #it { should have_property_value('Default', :string, '') }
    it { should have_property_value('TimeZoneKeyName', :string, 'UTC') }
    it { should have_property_value('StandardStart', :binary, "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00")  }
    it { should have_property_value('StandardName', :string, '@tzres.dll,-932') }
    it { should have_property_value('StandardBias', :dword, 0) }
    it { should have_property_value('DynamicDaylightTimeDisabled', :dword, 0) }
    it { should have_property_value('DaylightStart', :binary, "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00")  }
    it { should have_property_value('DaylightName', :string, '@tzres.dll,-931') }
    it { should have_property_value('DaylightBias', :dword, 0) }
    it { should have_property_value('Bias', :dword, 0) }
    it { should have_property_value('ActiveTimeBias', :dword, 0) }
  end
end