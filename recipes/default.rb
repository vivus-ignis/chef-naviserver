#
# Cookbook Name:: naviserver
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

remote_file "Naviserver distribution, v. #{node['naviserver']['version_full']}" do
  path   "#{Chef::Config[:file_cache_path]}/naviserver-#{node['naviserver']['version_full']}.tar.gz"
  source "http://downloads.sourceforge.net/project/naviserver/naviserver/#{node['naviserver']['version']}/naviserver-#{node['naviserver']['version_full']}.tar.gz"

  not_if { ::File.exists? "#{Chef::Config[:file_cache_path]}/naviserver-#{node['naviserver']['version_full']}.tar.gz" }
end

execute "Unpack naviserver distribution" do
  command "tar xzf #{Chef::Config[:file_cache_path]}/naviserver-#{node['naviserver']['version_full']}.tar.gz"
  
  not_if  { ::File.directory? "#{Chef::Config[:file_cache_path]}/naviserver#{node['naviserver']['version']}" }
end

# cd $(WORKDIR)/naviserver-$(NS_VER) && \
# touch version_include.in && \
# ./configure --prefix=$(TARGET_DIR)/naviserver $(64MODTCL) \
#   --with-tcl=$(TARGET_DIR)/tcl/lib \
#   --with-tclinclude=$(TARGET_DIR)/tcl/include && \
# $(SED) -i "s|install-config install-doc install-examples install-notice|install-config install-examples install-notice|" Makefile && \
# make && \
# make install

# $(_NAVISERVER_MODULES_INSTALL_COOKIE): $(_NAVISERVER_INSTALL_COOKIE)
#   rm -rf  $(WORKDIR)/modules
#   #rm -f  $(WORKDIR)/naviserver-modules-$(NS_VER).tar.gz
#   cd $(WORKDIR) && $(FETCH) "http://downloads.sourceforge.net/project/naviserver/naviserver/4.99.3/naviserver-modules-4.99.3.tar.gz?use_mirror=mesh"
#   cd $(WORKDIR) && tar xzf naviserver-modules-$(NS_VER).tar.gz
#   cd $(WORKDIR)/modules/nsmemcache && \
#     NAVISERVER=$(TARGET_DIR)/naviserver make && \
#     NAVISERVER=$(TARGET_DIR)/naviserver make install
# # cd $(WORKDIR)/modules/nsdbi && \
# #   $(SED) -i "s|NAVISERVER  = /usr/local/ns|NAVISERVER  = $(TARGET_DIR)/naviserver|g" Makefile && \
# #   make && make install
# #   $(SED) -i 's|MODLIBS  =  -lmysqlclient_r|MODLIBS  =  -lmysqlclient_r -lnsdb|g' Makefile && 
#   cd $(WORKDIR)/modules/nsdbmysql && \
#     $(SED) -i 's|CFLAGS   = -I/usr/include/mysql|CFLAGS   = -I/usr/include/mysql -L/usr/lib$(64LIB)/mysql|g' Makefile && \
#     NAVISERVER=$(TARGET_DIR)/naviserver make && \
#     NAVISERVER=$(TARGET_DIR)/naviserver make install
#   cd $(WORKDIR)/modules/nsssl && NAVISERVER=$(TARGET_DIR)/naviserver make && NAVISERVER=$(TARGET_DIR)/naviserver make install
# # cd $(WORKDIR)/modules/nsgdchart && NAVISERVER=$(TARGET_DIR)/naviserver make && NAVISERVER=$(TARGET_DIR)/naviserver make install
#   cd $(WORKDIR)/modules/nsmemcache && NAVISERVER=$(TARGET_DIR)/naviserver make && NAVISERVER=$(TARGET_DIR)/naviserver make install
#   touch $@
