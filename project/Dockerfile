FROM tomcat:10.1-jdk17

# Copie du WAR généré par Maven et déploiement comme ROOT
COPY target/test-project.war /usr/local/tomcat/webapps/ROOT.war

# Tomcat écoute par défaut sur 8080; Render mappe automatiquement le port
EXPOSE 8080
