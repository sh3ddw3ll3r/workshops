#
# Cookbook:: Tomcat
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
include_recipe 'Tomcat::install_java'
include_recipe 'Tomcat::create_group'
include_recipe 'Tomcat::create_user'
include_recipe 'Tomcat::install_tomcat'