# Étape 1 : build
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /build

# Copier le pom et récupérer les dépendances
COPY project/pom.xml .
RUN mvn dependency:go-offline

# Copier le dossier src
COPY project/src ./src

# Build le projet
RUN mvn clean package -DskipTests

# Étape 2 : run
FROM eclipse-temurin:17-jdk-alpine
WORKDIR /app

# Copier le jar généré
COPY --from=build /build/target/*.jar app.jar

# Exposer le port (Render fournit PORT via env)
EXPOSE 8080

# Lancer l'app
CMD ["java", "-jar", "app.jar"]
