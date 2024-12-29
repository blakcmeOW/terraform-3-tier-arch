#!/bin/bash
# Variables
CASSANDRA_VERSION="4.1"
REPO_URL="https://downloads.apache.org/cassandra/debian"
JAVA_PACKAGE="openjdk-11-jdk"

# Check if run as root
if [ "$(id -u)" -ne 0 ]; then
  echo "This script must be run as root!" >&2
  exit 1
fi

echo "Installing Apache Cassandra version $CASSANDRA_VERSION..."

# Update and install prerequisites
echo "Updating package list and installing dependencies..."
apt-get update -y
apt-get install -y gnupg curl lsb-release "$JAVA_PACKAGE"

# Add Cassandra repository
echo "Adding Cassandra repository..."
curl -fsSL "$REPO_URL/KEYS" | gpg --dearmor -o /usr/share/keyrings/cassandra.gpg
echo "deb [signed-by=/usr/share/keyrings/cassandra.gpg] $REPO_URL $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/cassandra.list

# Update package list and install Cassandra
echo "Installing Cassandra..."
apt-get update -y
apt-get install -y cassandra

# Enable and start Cassandra service
echo "Enabling and starting Cassandra service..."
systemctl enable cassandra
systemctl start cassandra

# Check service status
if systemctl is-active --quiet cassandra; then
  echo "Cassandra installed and running successfully!"
else
  echo "Cassandra installation failed. Check logs for details."
fi