# Multi-stage build: build WAR, then run on Tomcat

# Stage 1: build all modules and produce WAR
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /build
# Copy full repo (root pom + modules)
COPY . .
# Build via root aggregator to compile framework + project
RUN mvn -q -DskipTests -f ./pom.xml clean package

# Stage 2: run WAR on Tomcat 10 (Jakarta Servlet 6, Java 17)
FROM tomcat:10.1-jdk17
# Deploy the generated WAR as ROOT
COPY project/target/test-project.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
# Tomcat runs by default on 8080; Render maps $PORT automatically in Docker runtime
