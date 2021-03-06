##########################################################################
# Copyright 2017 ThoughtWorks, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
##########################################################################

package_path = File.join(Chef::Config[:file_cache_path], go_server_package_name)
server_directory_path = node['gocd']['server']['work_dir'].tr('/', '\\')
remote_file go_server_package_name do
  path package_path
  source go_server_package_url
end

log "Installing server to: #{server_directory_path}"

opts = []
opts << '/S'
opts << "/D=#{server_directory_path}"

windows_package 'Go Server' do
  installer_type :nsis
  source package_path
  options opts.join(' ')
end
