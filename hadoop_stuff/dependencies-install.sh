#!/bin/bash

# VARIABLES
HADOOP_VERSION="3.3.6"

# Functions
download_and_verify_hadoop() {

  # Combine both checks into one conditional statement
  if [[ ! -f /tmp/hadoop.tar.gz || $(stat -c %s /tmp/hadoop.tar.gz) -lt 500000000 ]]; then
    echo "Downloading Hadoop..."
    if ! wget -O /tmp/hadoop.tar.gz https://archive.apache.org/dist/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz; then
      echo "Error: Downloading Hadoop failed."
      echo "Please check your internet connection and re run the script."
      rm /tmp/hadoop.tar.gz
      exit 1
    fi
  else
    echo "Hadoop archive already exists in /tmp and meets size requirements."
  fi

  # Additional file integrity checks (optional)
  # You can add further checks here like checksum verification using tools like md5sum
  # if [[ ! md5sum /tmp/hadoop.tar.gz | grep -q 'expected_checksum' ]]; then
  #   echo "Error: File integrity mismatch."
  #   rm /tmp/hadoop.tar.gz
  #   exit 1
  # fi

  # File downloaded and verified successfully
  echo "Hadoop downloaded and verified successfully."

  # Extract Hadoop
  if ! sudo tar xvf /tmp/hadoop.tar.gz -C /usr/local/; then
    echo "Error: Extracting Hadoop failed."
    echo "Is yoru Internet OK!?"
    exit 1
  fi

  # Rename and change ownership
  if ! sudo mv /usr/local/hadoop-${HADOOP_VERSION} /usr/local/hadoop && ! sudo chown -R hadoop:hadoop /usr/local/hadoop; then
    echo "Error: Renaming or setting ownership failed."
    exit 1
  fi

}

clear
sleep 1
# Check if OpenSSH is installed
if ! dpkg -l openssh-server | grep -q '^ii'; then
  echo "Installing OpenSSH..."
  sudo apt install openssh-client openssh-server -y
else
  echo "OpenSSH is already Installed"
fi

# Check if Java is installed
if ! dpkg -l default-jdk | grep -q '^ii'; then
  echo "Installing Java..."
  sudo apt install default-jdk default-jre -y
else
  echo "Java is already Installed!"
fi

# Check if user "hadoop" exists
if ! id -u hadoop &> /dev/null; then
  echo "Creating user 'hadoop'..."
  sudo useradd -m hadoop
  sudo usermod -aG sudo hadoop
  clear
  echo "Please set a password for the hadoop account (ignore bad password warnings, if any)"
  sudo passwd hadoop
else
  echo "User 'hadoop' already exists."
fi

# Check if /usr/hadoop directory exists
if [[ ! -d /usr/local/hadoop ]]; then
  echo "Hadoop not installed or insufficient size, downloading..."
  download_and_verify_hadoop
else
  echo "/usr/local/hadoop directory already exists and meets size requirements, skipping download."
fi


# Check if extraction directory exists
if [[ ! -d /usr/local/hadoop ]]; then
  echo "Error: Extraction failed or directory missing."
  exit 1
else
  sudo mkdir -p /usr/local/hadoop/logs/
fi
echo "Hadoop successfully installed to /usr/local/hadoop"

sudo chown -R hadoop:sudo /usr/local/hadoop

sleep 3
clear
echo "You will now be logged in as hadoop user please run the second script to automate hadoop configuration setup!"
sleep 3

# Change User to hadoop
sudo su - hadoop

