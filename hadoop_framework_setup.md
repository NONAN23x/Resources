# Hadoop Framework 3.3.6 Easy Deploy

This Guide Utilises the two magical scripts that I coded, dependencies-install.sh and hadoop-configure.sh and leverages them both to ease the deployment of Apache Hadoop Framework

-- -
### Step 1:
Update your Ubuntu Machine:
In this step it is expected that you can just copy paste the command below, enter your user's password when prompted and hit enter, after completing this step and prompt is returned, proceed to step 2

```sudo apt update && sudo apt upgrade```

-- -
### Step 2:
Run the dependencies Installer, First part of the Deployment action, use this command to setup, ssh, java and hadoop in the /opt directory
You will recieve a new prompt, if yes then this part is complete, proceed to step 3

```wget https://raw.githubusercontent.com/NONAN23x/Resources/main/hadoop_stuff/dependencies-install.sh && chmod +x dependencies-install.sh && ./dependencies-install.sh```

-- -
### Step 3:
Configuration of yarn-site.xml, core-site.xml, etc, etc.
This command single-handedly will write to the necessary config files, easing up the user's work, at the end, namenodes are formatted.

```wget https://raw.githubusercontent.com/NONAN23x/Resources/main/hadoop_stuff/hadoop-configure.sh && chmod +x hadoop-configure.sh && ./hadoop-configure.sh```

Now reboot your computer, please

-- -
### Step 4:
Make sure you're haddop user and start the dfs

`sudo su - hadoop`
`start-all.sh`

###### To close enter
`stop-all.sh`
