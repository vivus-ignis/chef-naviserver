#
# Cookbook Name:: naviserver
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w{ tcl tcl-devel }.each do |pkg|
  package pkg
end

remote_file "Naviserver distribution, v. #{node['naviserver']['version_full']}" do
  path   "#{Chef::Config[:file_cache_path]}/naviserver-#{node['naviserver']['version_full']}.tar.gz"
  source "http://downloads.sourceforge.net/project/naviserver/naviserver/#{node['naviserver']['version']}/naviserver-#{node['naviserver']['version_full']}.tar.gz"

  not_if { ::File.exists? "#{Chef::Config[:file_cache_path]}/naviserver-#{node['naviserver']['version_full']}.tar.gz" }
end

execute "Unpack naviserver distribution" do
  command "tar xzf #{Chef::Config[:file_cache_path]}/naviserver-#{node['naviserver']['version_full']}.tar.gz"
  cwd     Chef::Config[:file_cache_path]
  not_if  { ::File.directory? "#{Chef::Config[:file_cache_path]}/naviserver-#{node['naviserver']['version']}" }
end

is_64bit = node['kernel']['machine'] == "x86_64" ? "--enable-64bit" : ""

bash "Compile naviserver" do
  cwd "#{Chef::Config[:file_cache_path]}/naviserver-#{node['naviserver']['version']}"
  code <<-EOH
    set -x
    exec >  /var/tmp/chef-naviserver-compile.log
    exec 2> /var/tmp/chef-naviserver-compile.log
    touch version_include.in
   ./configure --prefix=#{node['naviserver']['install_prefix']}/naviserver #{is_64bit}
   sed -i "s|install-config install-doc install-examples install-notice|install-config install-examples install-notice|" Makefile
   make
   make install
  EOH

  not_if { ::File.exists? "#{node['naviserver']['install_prefix']}/naviserver/sbin/naviserver" }
end
