#
# Cookbook:: Install_MongoDB
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
include_recipe 'Install_MongoDB::install_mongodb'
include_recipe 'Install_MongoDB::start_mongodb'