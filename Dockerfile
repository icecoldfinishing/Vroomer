# -----------------------------
# Étape 1 : Build Maven
# -----------------------------
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /build

# Copier tout le repo (project + parent POM si tu en as)
COPY . .

# Build tout le projet multi-module
RUN mvn clean package -DskipTests

# -----------------------------
# Étape 2 : Image finale Java
# -----------------------------
FROM eclipse-temurin:17-jdk-alpine
WORKDIR /app

# Copier le jar généré du module project
COPY --from=build /build/project/target/*.jar app.jar

# Exposer le port Render (il fournit $PORT)
ENV PORT=8080
EXPOSE $PORT

# Lancer l'app avec le port dynamique
CMD ["sh", "-c", "java -Dserver.port=$PORT -jar app.jar"]
