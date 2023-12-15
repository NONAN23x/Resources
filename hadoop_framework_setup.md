# Hadoop Framework 3.3.6 Easy Deploy

This guide utilises my two magical scripts: **dependencies-install.sh** and **hadoop-configure.sh** and leverages them both to for the deployment of Apache Hadoop Framework

-- -
### Step 1:
Update your Ubuntu Machine:
(Enter your password when prompted and hit enter)

```sudo apt update && sudo apt upgrade```

-- -
### Step 2:
Run the dependencies installer 
- Installs OpenSSH, Java
- Downloads/Unpacks and places Hadoop 3.3.6 in the '/opt/hadoop/' directory

```wget https://raw.githubusercontent.com/NONAN23x/Resources/main/hadoop_stuff/dependencies-install.sh && chmod +x dependencies-install.sh && ./dependencies-install.sh```

- If this command is successful, you'll see hadoop user's prompt, if yes then proceed to step 3

-- -
### Step 3:
- This is the second part of the proccess, here configuration of yarn-site.xml, core-site.xml, would be handled automatically by the script.
- You only need to enter your user or hadoop user's password when prompted.

```wget https://raw.githubusercontent.com/NONAN23x/Resources/main/hadoop_stuff/hadoop-configure.sh && chmod +x hadoop-configure.sh && ./hadoop-configure.sh```

- Now reboot your computer

-- -
### Step 4:
- Make sure you are the hadoop user, then start the dfs

`sudo su - hadoop`
`start-all.sh`

- Visit [this](http://localhost:9870/) link to view the webpage

###### To close enter
`stop-all.sh`
