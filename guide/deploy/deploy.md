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

## 3. Créer un service Web sur Render
1. Connectez-vous à Render et cliquez sur "New Web Service".
2. Connectez votre repo GitHub.
3. Configurez :
   - **Environment** : Java
   - **Build Command** : `cd project && mvn clean package`
   - **Start Command** : `java -jar $JAVA_HOME/lib/tomcat-embed-core.jar --war-file target/test-project.war` *(voir remarque ci-dessous)*
   - **Environment Variables** :
     - `JAVA_VERSION=17`
   - **Root Directory** : `project`

### Remarque importante
Render ne propose pas Tomcat "standalone" par défaut. Deux options :
- **Option 1 (recommandée)** :
  - Ajoutez la dépendance `org.apache.tomcat.embed:tomcat-embed-core` dans le `pom.xml` pour générer un JAR exécutable (Spring Boot style) ou utilisez un plugin Maven pour "packager" Tomcat avec votre WAR.
  - Modifiez le `Start Command` pour lancer Tomcat embarqué.
- **Option 2 (classique)** :
  - Utilisez un Dockerfile personnalisé (voir ci-dessous).

## 4. Exemple de Dockerfile (optionnel)
Si vous souhaitez un contrôle total, ajoutez un fichier `Dockerfile` dans `project/` :

```dockerfile
FROM tomcat:10.1-jdk17
COPY target/test-project.war /usr/local/tomcat/webapps/ROOT.war
```

Sur Render :
- **Environment** : Docker
- **Root Directory** : `project`

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
- Si besoin, adaptez le projet pour Tomcat embarqué ou Docker
- Déployez le WAR sur Render via l'interface ou Docker
- Vérifiez l'URL publique fournie par Render
