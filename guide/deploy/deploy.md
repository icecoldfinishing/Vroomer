# Déploiement du projet sur Render

Ce guide explique comment déployer ce projet Java (WAR) sur [Render](https://render.com), un service cloud PaaS qui supporte le déploiement d'applications web Java via Tomcat.

## 1. Prérequis
- Un compte Render (https://render.com)
- Un repository GitHub contenant ce projet (ou fork)
- Le projet doit générer un fichier `.war` via Maven (`mvn package`)
- Le projet utilise Java 17 et Jakarta Servlet 6 (Tomcat 10+)

## 2. Préparer le projet
- Vérifiez que le build Maven fonctionne localement :
  ```sh
  cd project
  mvn clean package
  ```
  Le fichier `target/test-project.war` doit être généré.
- Assurez-vous que le dossier `src/main/webapp/WEB-INF/lib/` contient bien `framework.jar` (généré par le script du framework).
 - Packaging du framework:
   - Avec la configuration actuelle Maven, les classes du framework sont directement compilées et incluses dans `WEB-INF/classes` (pas de `framework.jar` requis).
   - Si vous préférez le JAR (via `framework/script.bat`), placez le fichier généré dans `src/main/webapp/WEB-INF/lib/` avant le packaging.

## 3. Créer un service Web sur Render
Option A — Docker (recommandé)
1. Ajoutez un `Dockerfile` dans `project/` (exemple plus bas).
2. Ajoutez un fichier `render.yaml` à la racine pour un déploiement en un clic.
3. Sur Render, créez un nouveau service via "Deploy from Blueprint" et sélectionnez `render.yaml`.

Option B — Native (avancé)
- Utilisez un script bash pour télécharger Tomcat, définir le port `$PORT` et lancer `catalina.sh run`. Render ne fournit pas Tomcat nativement; cette option demande plus de maintenance.

## 4. Exemple de Dockerfile (optionnel)
Si vous souhaitez un contrôle total, ajoutez un fichier `Dockerfile` dans `project/` :

```dockerfile
FROM tomcat:10.1-jdk17
COPY target/test-project.war /usr/local/tomcat/webapps/ROOT.war
```

Sur Render :
- **Environment** : Docker
- **Root Directory** : `project`

Blueprint `render.yaml` (à la racine du repo) :

```yaml
services:
  - type: web
    name: vroomer
    runtime: docker
    envVars:
      - key: SPRING_DATASOURCE_URL
        value: jdbc:postgresql://your-host:5432/pg10
      - key: SPRING_DATASOURCE_USERNAME
        value: postgres
      - key: SPRING_DATASOURCE_PASSWORD
        value: postgres
    rootDir: project
    dockerfilePath: Dockerfile
```

  ## 4.1. Tests locaux Docker (recommandés)
  Avant Render, validez en local:

  ```sh
  # Option A: depuis le dossier project
  cd project
  mvn clean package
  docker build -t vroomer-tomcat .
  docker run --rm -p 8080:8080 vroomer-tomcat
  # Ouvrir http://localhost:8080/

  # Option B: depuis la racine (si vous utilisez le Dockerfile racine)
  cd ..  # revenir à la racine si besoin
  docker build -t vroomer-tomcat .
  docker run --rm -p 8080:8080 vroomer-tomcat
  ```

## 5. Limitations et conseils
- Render n'exécute pas les scripts `.bat` Windows. Tout build doit être automatisé via Maven.
- Les dépendances du framework doivent être dans `WEB-INF/lib` ou packagées dans le WAR.
- Les fichiers de config (ex: `auth.properties`) doivent être inclus dans le WAR.
- Les accès à la base de données doivent utiliser des variables d'environnement Render.

## 6. Liens utiles
- [Render Java Docs](https://render.com/docs/deploy-java)
- [Render Docker Docs](https://render.com/docs/deploy-docker)

---

**Résumé** :
- Privilégiez un build Maven standard (`mvn package`)
- Déploiement recommandé: Docker avec `Dockerfile` + `render.yaml`
- Alternativement, script natif pour Tomcat (avancé)
- Vérifiez l'URL publique fournie par Render
