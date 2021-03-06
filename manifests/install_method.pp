# Copyright 2014 Red Hat, Inc., All rights reserved.
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
#
class openshift_origin::install_method {
  stage { 'first':
    before => Stage['main'],
  }

  case $::openshift_origin::install_method {
    'none' : {}
    'yum'  : {
      class { 'openshift_origin::yum_install_method':
        stage => 'first',
      }
      Class['Openshift_origin::Yum_install_method'] ->
      Class['Openshift_origin::Oo_admin_yum_validator']
    }
    default: {}
  }
  class { 'openshift_origin::oo_admin_yum_validator':
    stage => 'first',
  }
}

