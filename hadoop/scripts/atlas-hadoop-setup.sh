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

mkdir -p /opt/hadoop/logs
chown -R hdfs:hadoop /opt/hadoop/
chmod g+w /opt/hadoop/logs

su -c "ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa" hdfs
su -c "cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys" hdfs
su -c "chmod 0600 ~/.ssh/authorized_keys" hdfs

su -c "ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa" yarn
su -c "cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys" yarn
su -c "chmod 0600 ~/.ssh/authorized_keys" yarn

echo "ssh" > /etc/pdsh/rcmd_default

echo "export JAVA_HOME=${JAVA_HOME}" >> ${HADOOP_HOME}/etc/hadoop/hadoop-env.sh

cat <<EOF > /etc/ssh/ssh_config
Host *
   StrictHostKeyChecking no
   UserKnownHostsFile=/dev/null
EOF

cat <<EOF > ${HADOOP_HOME}/etc/hadoop/core-site.xml
<configuration>
  <property>
    <name>fs.defaultFS</name>
    <value>hdfs://${HOSTNAME}:9000</value>
  </property>
</configuration>
EOF

cat <<EOF > ${HADOOP_HOME}/etc/hadoop/hdfs-site.xml
<configuration>
  <property>
    <name>dfs.data.dir</name>
    <value>/data</value>
  </property>

  <property>
    <name>dfs.name.dir</name>
    <value>/name</value>
  </property>

  <property>
    <name>dfs.ha.automatic-failover.enabled</name>
    <value>false</value>
  </property>
  <property>
    <name>dfs.replication</name>
    <value>1</value>
  </property>
  <property>
    <name>dfs.permissions</name>
    <value>false</value>
  </property>
</configuration>
EOF

cat <<EOF > ${HADOOP_HOME}/etc/hadoop/yarn-site.xml
<configuration>
  <property>
    <name>yarn.resourcemanager.ha.enabled</name>
    <value>true</value>
  </property>
  <property>
    <name>yarn.nodemanager.aux-services</name>
    <value>mapreduce_shuffle</value>
  </property>
  <property>
    <name>yarn.nodemanager.env-whitelist</name>
    <value>JAVA_HOME,HADOOP_COMMON_HOME,HADOOP_HDFS_HOME,HADOOP_CONF_DIR,CLASSPATH_PREPEND_DISTCACHE,HADOOP_YARN_HOME,HADOOP_MAPRED_HOME</value>
  </property>
</configuration>
EOF

