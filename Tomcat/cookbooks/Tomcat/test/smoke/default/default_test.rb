# # encoding: utf-8

# Inspec test for recipe Tomcat::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/


# Ensure Tomcat is listening
describe port(8080)
  it { should_not be_listening }
end
