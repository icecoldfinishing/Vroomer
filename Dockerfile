# -----------------------------
# Étape 1 : Build Maven
# -----------------------------
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /build

# Copier tous les dossiers nécessaires pour Maven
COPY project ./project
COPY framework ./framework

# Si tu as un parent pom à la racine, sinon tu peux ignorer
# COPY vroomer-root ./vroomer-root  

# Aller dans le dossier project
WORKDIR /build/project

# Télécharger toutes les dépendances (offline)
RUN mvn dependency:go-offline

# Build le projet (skip tests pour accélérer)
RUN mvn clean package -DskipTests

# -----------------------------
# Étape 2 : Image finale Java
# -----------------------------
FROM eclipse-temurin:17-jdk-alpine
WORKDIR /app

# Copier le jar généré
COPY --from=build /build/project/target/*.jar app.jar

# Exposer le port (Render fournit $PORT automatiquement)
EXPOSE 8080

# Lancer l'app
CMD ["java", "-jar", "app.jar"]
