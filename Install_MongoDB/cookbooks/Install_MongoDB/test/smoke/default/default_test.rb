# # encoding: utf-8

# Inspec test for recipe Install_MongoDB::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe processes('mongod') do
  its('users') { should eq ['mongod'] }
  its('list.length') {should eq 1}
end
