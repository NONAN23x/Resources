#!/bin/bash

### Variables
HADOOP_VERSION="3.3.6"

### Setting up ssh client
clear
echo "Enter the password of hadoop account below"
chsh -s /bin/bash
ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
sudo chmod 640 ~/.ssh/authorized_keys

# Escape special characters in variable values
HADOOP_HOME=/opt/hadoop
HADOOP_INSTALL=$HADOOP_HOME
HADOOP_MAPRED_HOME=$HADOOP_HOME
HADOOP_COMMON_HOME=$HADOOP_HOME
HADOOP_HDFS_HOME=$HADOOP_HOME
YARN_HOME=$HADOOP_HOME
HADOOP_COMMON_LIB_NATIVE_DIR="$HADOOP_HOME/lib/native"
PATH="$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin"

# Check if the .bashrc file is writable
if [[ -w ~/.bashrc ]]; then
  # Append the export lines to the .bashrc file
  echo "export HADOOP_HOME=$HADOOP_HOME" >> ~/.bashrc
  echo "export HADOOP_INSTALL=$HADOOP_INSTALL" >> ~/.bashrc
  echo "export HADOOP_MAPRED_HOME=$HADOOP_HOME" >> ~/.bashrc
  echo "export HADOOP_COMMON_HOME=$HADOOP_HOME" >> ~/.bashrc
  echo "export HADOOP_HDFS_HOME=$HADOOP_HOME" >> ~/.bashrc
  echo "export YARN_HOME=$HADOOP_HOME" >> ~/.bashrc
  echo "export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native" >> ~/.bashrc
  echo "export PATH=$PATH" >> ~/.bashrc
  echo "Hadoop environment variables added to ~/.bashrc."
else
  echo "Error: ~/.bashrc is not writable. Please fix permissions or use a different method."
fi

### Configuring Apache Hadoop

hadoop_env_content="export JAVA_HOME="/usr/lib/jvm/default-java/""  
hadoop_class_path="export HADOOP_CLASSPATH+="'$HADOOP_HOME/lib/*.jar'""
sudo echo $hadoop_env_content > $HADOOP_HOME/etc/hadoop/hadoop-env.sh
sudo echo $hadoop_class_path >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh

xml_content="<configuration> <property>

      <name>fs.default.name</name>

      <value>hdfs://0.0.0.0:9000</value>

      <description>The default file system URI</description>

   </property> </configuration>"
sudo echo $xml_content > $HADOOP_HOME/etc/hadoop/core-site.xml

sudo mkdir -p /home/hadoop/hdfs/{namenode,datanode}
sudo chown -R hadoop:hadoop /home/hadoop/hdfs

hdfs_site_content="<configuration> <property>

      <name>dfs.replication</name>

      <value>1</value>

   </property>


   <property>

      <name>dfs.name.dir</name>

      <value>file:///home/hadoop/hdfs/namenode</value>

   </property>


   <property>

      <name>dfs.data.dir</name>

      <value>file:///home/hadoop/hdfs/datanode</value>

   </property> </configuration>"
sudo echo $hdfs_site_content > "$HADOOP_HOME/etc/hadoop/hdfs-site.xml"

mapred_site_content="<configuration> <property>

      <name>mapreduce.framework.name</name>

      <value>yarn</value>

   </property> </configuration>"
sudo echo $mapred_site_content > $HADOOP_HOME/etc/hadoop/mapred-site.xml

yarn_site_content="<configuration> 
   <property>
      <name>yarn.nodemanager.aux-services</name>
      <value>mapreduce_shuffle</value>
   </property> </configuration>"
sudo echo $yarn_site_content > $HADOOP_HOME/etc/hadoop/yarn-site.xml

echo "Configuration is all set!"
echo "Now please reboot your system"
echo "Info: to start the framework: change into user hadoop: "
echo "sudo su - hadoop"
echo "Then run start-all.sh to start the framework"
echo "visit http://localhost:9870/ to view the web page"
echo "Info: run stop-all.sh to stop the hadoop framework"

echo "running namenode format"
hdfs namenode -format
 

