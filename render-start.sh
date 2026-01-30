#!/usr/bin/env bash
set -euo pipefail

# Render Web Service (Free): Download Tomcat and run WAR on $PORT

PORT=${PORT:-8080}
TOMCAT_VERSION=10.1.28
TOMCAT_DIR="$HOME/tomcat"

# Download & extract Tomcat once
if [ ! -d "$TOMCAT_DIR" ]; then
  echo "Downloading Tomcat ${TOMCAT_VERSION}..."
  curl -fsSL "https://archive.apache.org/dist/tomcat/tomcat-10/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz" -o /tmp/tomcat.tar.gz
  mkdir -p "$TOMCAT_DIR"
  tar -xzf /tmp/tomcat.tar.gz --strip-components=1 -C "$TOMCAT_DIR"
fi

# Deploy WAR as ROOT
cp project/target/test-project.war "$TOMCAT_DIR/webapps/ROOT.war"

# Configure Tomcat to listen on $PORT
sed -i "s/port=\"8080\"/port=\"${PORT}\"/g" "$TOMCAT_DIR/conf/server.xml"

# Run Tomcat (foreground)
"$TOMCAT_DIR/bin/catalina.sh" run
