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
Option (100% gratuite) — Web Service Native
1. Placez deux scripts à la racine du repo:
  - `render-build.sh` (build Maven)
  - `render-start.sh` (démarrage Tomcat sur `$PORT`)
2. Créez un nouveau "Web Service" sur Render à partir du repo GitHub.
3. Configurez:
  - **Root Directory**: `.` (racine du repo)
  - **Build Command**: `./render-build.sh`
  - **Start Command**: `./render-start.sh`
  - **Environment**: Java (17)
  - **Environment Variables** (si DB): `SPRING_DATASOURCE_URL`, `SPRING_DATASOURCE_USERNAME`, `SPRING_DATASOURCE_PASSWORD`
4. Déployez. Render exécutera le build, téléchargera Tomcat, et lancera l'app sur le port public.

Note: Nous n'utilisons pas Docker ni render.yaml pour éviter le compte payant.

  ## 4.1. Tests locaux (optionnels)
  Vous pouvez toujours tester avec un Tomcat local en déposant `project/target/test-project.war` dans `webapps`.

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
 - Déploiement gratuit recommandé: Web Service Render + scripts bash
- Vérifiez l'URL publique fournie par Render
