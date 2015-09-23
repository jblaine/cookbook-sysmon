#
# Cookbook Name:: sysmon
# Recipe:: default
#
# The MIT License (MIT)
# 
# Copyright (c) 2015 The Authors
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

if not node['sysmon']['accepteula']
  raise "You have not accepted the Sysmon EULA by setting node['sysmon']['accepteula'] = true"
else
  accepteula = '-accepteula'
end

windows_zipfile "#{Chef::Config.file_cache_path}/Sysmon" do
  only_if { platform?('windows') }
  not_if {::File.exists?("#{Chef::Config.file_cache_path}/Sysmon")}
  source node['sysmon']['url']
  action :unzip
  notifies :run, 'execute[Install Sysmon Service]', :immediately
end

execute 'Install Sysmon Service' do
  only_if { platform?('windows') }
  not_if 'sc query sysmon'
  command "#{Chef::Config.file_cache_path}/Sysmon/Sysmon.exe #{accepteula} -i"
end

cookbook_file "#{Chef::Config.file_cache_path}/sysmon-config.xml" do
  only_if { platform?('windows') }
  notifies :run, 'execute[Configure Sysmon]', :immediately
end

execute 'Configure Sysmon' do
  only_if { platform?('windows') }
  action :nothing
  command "#{Chef::Config.file_cache_path}/Sysmon/Sysmon.exe -c #{Chef::Config.file_cache_path}/sysmon-config.xml"
end
