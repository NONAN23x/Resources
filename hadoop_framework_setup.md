# Hadoop Framework 3.3.6 Easy Deploy
-- -

### Step 1:
Update your Ubuntu Machine:
`sudo apt update && sudo apt upgrade`

### Step 2:
Run the dependencies Installer
`wget https://raw.githubusercontent.com/NONAN23x/Resources/main/hadoop_stuff/dependencies-install.sh | bash`

### Step 3:
Configuration of yarn-site.xml, core-site.xml, etc, etc.
`wget https://raw.githubusercontent.com/NONAN23x/Resources/main/hadoop_stuff/hadoop-configure.sh | bash`

### Step 4:
Restart your Ubuntu Machine

### Step 5:
Switch to hadoop's shell and start the dfs
`sudo su - hadoop`
`start-all.sh`

###### To close enter
`stop-all.sh`
