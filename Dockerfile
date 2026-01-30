# -----------------------------
# Étape 1 : Build Maven
# -----------------------------
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /build

# Copier tout le projet nécessaire pour Maven
COPY project ./project

# Aller dans le dossier project
WORKDIR /build/project

# Télécharger toutes les dépendances
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

# Exposer le port Render (il fournit $PORT)
ENV PORT=8080
EXPOSE $PORT

# Lancer l'app avec le port dynamique
CMD ["sh", "-c", "java -Dserver.port=$PORT -jar app.jar"]
