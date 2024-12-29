#!/bin/bash

# Variables
TOMCAT_VERSION="10.1.14"  # Adjust as needed
TOMCAT_USER="tomcat"
INSTALL_DIR="/opt/tomcat"
TOMCAT_URL="https://downloads.apache.org/tomcat/tomcat-10/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz"
SYSTEMD_FILE="/etc/systemd/system/tomcat.service"

# Check if run as root
if [ "$(id -u)" -ne 0 ]; then
  echo "This script must be run as root!" >&2
  exit 1
fi

echo "Installing Apache Tomcat version $TOMCAT_VERSION..."

# Create Tomcat user
if ! id -u $TOMCAT_USER >/dev/null 2>&1; then
  echo "Creating user $TOMCAT_USER..."
  useradd -r -m -U -d "$INSTALL_DIR" -s /bin/false $TOMCAT_USER
fi

# Download and install Tomcat
echo "Downloading Tomcat..."
mkdir -p "$INSTALL_DIR"
wget -qO- "$TOMCAT_URL" | tar -xz -C "$INSTALL_DIR" --strip-components=1

# Set permissions
echo "Setting permissions for $TOMCAT_USER..."
chown -R $TOMCAT_USER:$TOMCAT_USER "$INSTALL_DIR"
chmod -R 755 "$INSTALL_DIR"

chown -R tomcat:tomcat /opt/tomcat

chmod +x /opt/tomcat/bin/*.sh

# Configure systemd service
echo "Creating systemd service file..."
cat <<EOF > $SYSTEMD_FILE
[Unit]
Description=Apache Tomcat Web Application Container
After=network.target

[Service]
Type=forking

User=$TOMCAT_USER
Group=$TOMCAT_USER

Environment=JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
Environment=CATALINA_PID=$INSTALL_DIR/temp/tomcat.pid
Environment=CATALINA_HOME=$INSTALL_DIR
Environment=CATALINA_BASE=$INSTALL_DIR

ExecStart=$INSTALL_DIR/bin/startup.sh
ExecStop=$INSTALL_DIR/bin/shutdown.sh

User=tomcat
Group=tomcat

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd, enable and start Tomcat
echo "Enabling and starting Tomcat service..."
systemctl daemon-reload
systemctl enable tomcat
systemctl start tomcat

# Final message
if systemctl is-active --quiet tomcat; then
  echo "Tomcat installed and running successfully!"
else
  echo "Tomcat installation failed. Check logs for details."
fi