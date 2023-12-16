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
JAVA_HOME=/usr/lib/jvm/default-java
HADOOP_HOME=/opt/hadoop
HADOOP_INSTALL=$HADOOP_HOME
HADOOP_MAPRED_HOME=$HADOOP_HOME
HADOOP_COMMON_HOME=$HADOOP_HOME
HADOOP_HDFS_HOME=$HADOOP_HOME
YARN_HOME=$HADOOP_HOME
HADOOP_COMMON_LIB_NATIVE_DIR="$HADOOP_HOME/lib/native"
PATH="$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin"
HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop 
HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib/native" 
PDSH_RCMD_TYPE=ssh



# Check if the .bashrc file is writable
if [[ -w ~/.bashrc ]]; then
  # Append the export lines to the .bashrc file
  echo "export JAVA_HOME=$JAVA_HOME" >> ~/.bashrc
  echo "export HADOOP_HOME=$HADOOP_HOME" >> ~/.bashrc
  echo "export HADOOP_INSTALL=$HADOOP_INSTALL" >> ~/.bashrc
  echo "export HADOOP_MAPRED_HOME=$HADOOP_HOME" >> ~/.bashrc
  echo "export HADOOP_COMMON_HOME=$HADOOP_HOME" >> ~/.bashrc
  echo "export HADOOP_HDFS_HOME=$HADOOP_HOME" >> ~/.bashrc
  echo "export YARN_HOME=$HADOOP_HOME" >> ~/.bashrc
  echo "export HADOOP_CONF_DIR=$HADOOP_CONF_DIR" >> ~/.bashrc
  echo "export HADOOP_OPTS=$HADOOP_OPTS" >> ~/.bashrc
  echo "export PDSH_RCMD_TYPE=$PDSH_RCMD_TYPE" >> ~/.bashrc
  echo "export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native" >> ~/.bashrc
  echo "export PATH=$PATH" >> ~/.bashrc
  echo "Hadoop environment variables added to ~/.bashrc."
else
  echo "Error: ~/.bashrc is not writable. Please fix permissions or use a different method."
fi

### Configuring Apache Hadoop

hadoop_env_content="export JAVA_HOME=$JAVA_HOME"  
# hadoop_class_path="export HADOOP_CLASSPATH+="' $HADOOP_HOME/lib/*.jar'""
sudo echo $hadoop_env_content > $HADOOP_HOME/etc/hadoop/hadoop-env.sh
# sudo echo $hadoop_class_path >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh


xml_content="<xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheelt type ="text/xsl" href="configuration.xsl"?>
<configuration> 
 <property> 
 <name>fs.defaultFS</name> 
 <value>hdfs://localhost:9000</value>  </property> 
 <property> 
<name>hadoop.proxyuser.dataflair.groups</name> <value>*</value> 
 </property> 
 <property> 
<name>hadoop.proxyuser.dataflair.hosts</name> <value>*</value> 
 </property> 
 <property> 
<name>hadoop.proxyuser.server.hosts</name> <value>*</value> 
 </property> 
 <property> 
<name>hadoop.proxyuser.server.groups</name> <value>*</value> 
 </property> 
</configuration>"
sudo echo $xml_content > $HADOOP_HOME/etc/hadoop/core-site.xml
echo "Configured core-site.xml"


sudo mkdir -p /home/hadoop/hdfs/{namenode,datanode}
sudo chown -R hadoop:hadoop /home/hadoop/hdfs


hdfs_site_content="<xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheelt type ="text/xsl" href="configuration.xsl"?>
<configuration> <property>
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
sudo echo $hdfs_site_content > $HADOOP_HOME/etc/hadoop/hdfs-site.xml
echo "configured hdfs-site.xml"


mapred_site_content="<xml version="1.0"?>
<?xml-stylesheelt type ="text/xsl" href="configuration.xsl"?>
<configuration> 
 <property> 
 <name>mapreduce.framework.name</name>  <value>yarn</value> 
 </property> 
 <property>
 <name>mapreduce.application.classpath</name> 
  
<value>$HADOOP_MAPRED_HOME/share/hadoop/mapreduce/*:$HADOOP_MAPRED_HOME/share/hadoop/mapreduce/lib/*</value> 
 </property> 
</configuration>"
sudo echo $mapred_site_content > $HADOOP_HOME/etc/hadoop/mapred-site.xml
echo "configured mapred-site.xml"


yarn_site_content="<xml version="1.0"?>
<configuration> 
 <property> 
 <name>yarn.nodemanager.aux-services</name> 
 <value>mapreduce_shuffle</value> 
 </property> 
 <property> 
 <name>yarn.nodemanager.env-whitelist</name> 
  
<value>JAVA_HOME,HADOOP_COMMON_HOME,HADOOP_HDFS_HOME,HADOOP_CONF_DIR,CLASSPATH_PREP END_DISTCACHE,HADOOP_YARN_HOME,HADOOP_MAPRED_HOME</value> 
 </property> 
</configuration>"
sudo echo $yarn_site_content > $HADOOP_HOME/etc/hadoop/yarn-site.xml
echo "configured yarn-site.xml"


echo "Now please reboot your system"
echo "Info: to start the framework: change you need to be user hadoop: (run the command below if you are not user hadoop)"
echo "sudo su - hadoop"
echo "Then run start-all.sh to start the framework"
echo "You can visit http://localhost:9870/ to view the web page"
echo "Info: run stop-all.sh to stop the hadoop framework"

echo "running namenode format"
hdfs namenode -format
 

