#
# Cookbook Name:: apache
# Recipe:: default
#
# Copyright ModCloth, Inc.
#
# All rights reserved - Do Not Redistribute
#

package 'apache' do
  action :install
end

package 'ap24-php54' do
  action :install
end

package 'php54-mysql' do
  action :install
end

package 'php54-mysqli' do
  action :install
end

package 'php54-json' do
  action :install
end

service 'apache' do
  action :enable
  supports :enable => true, :disable => true, :restart => true
end

directory '/opt/local/etc/httpd/virtual' do
  action :create
end

cookbook_file '/opt/local/etc/php.ini' do
  source 'php.ini'
  notifies :restart, resources(:service => 'apache')
end

cookbook_file '/opt/local/etc/httpd/modules.conf' do
  source 'modules.conf'
  notifies :restart, resources(:service => 'apache')
end

template '/opt/local/etc/httpd/httpd.conf' do
  source 'httpd.conf.erb'
  notifies :restart, resources(:service => 'apache')
end
