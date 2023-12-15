# Hadoop Framework 3.3.6 Easy Deploy
-- -

### Step 1:
Update your Ubuntu Machine:
`sudo apt update && sudo apt upgrade`

### Step 2:
Run the dependencies Installer
`wget https://github.com/NONAN23x/Resources/dependency-installer.sh`

### Step 3:
Configuration of yarn-site.xml, core-site.xml, etc, etc.
`wget https://github.com/NONAN23x/Resources/hadoop-configure.sh`

### Step 4:
Restart your Ubuntu Machine

### Step 5:
Switch to hadoop's shell and start the dfs
`sudo su - hadoop`
`start-all.sh`

###### To close enter
`stop-all.sh`
