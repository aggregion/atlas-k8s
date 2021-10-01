#!/bin/bash

# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

service ssh start

if [ ! -e /data/.setupDone ]
then
  su -c "${HADOOP_HOME}/bin/hdfs namenode -format" hdfs
  touch /data/.setupDone
fi


su -c "${HADOOP_HOME}/sbin/start-dfs.sh" hdfs
su -c "${HADOOP_HOME}/sbin/start-yarn.sh" yarn

su -c "${ATLAS_SCRIPTS}/atlas-hadoop-mkdir.sh" hdfs

NAMENODE_PID=`ps -ef  | grep -v grep | grep -i "org.apache.hadoop.hdfs.server.namenode.NameNode" | awk '{print $2}'`

# prevent the container from exiting
tail --pid=$NAMENODE_PID -f /dev/null
