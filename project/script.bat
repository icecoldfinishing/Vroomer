@echo off
setlocal enabledelayedexpansion

:: ============================================================================
:: Script pour compiler le Framework, packager avec Maven, et déployer
:: ============================================================================

:: === Variables à adapter ===
set "TEST_PROJECT_DIR=%~dp0"
if "%TEST_PROJECT_DIR:~-1%"=="\" set "TEST_PROJECT_DIR=%TEST_PROJECT_DIR:~0,-1%"
set "FRAMEWORK_DIR=D:\Framework\framework"
set "PROJECT_NAME=test-project"
set "TOMCAT_HOME=D:\Progtool\apache-tomcat-10.1.28"
set "JAVA_HOME=C:\Program Files\Java\jdk-17"

:: === Variables calculées (ne pas modifier) ===
set "PATH=%JAVA_HOME%\bin;%PATH%"
set "WEB_INF_LIB_DIR=%TEST_PROJECT_DIR%\src\main\webapp\WEB-INF\lib"
set "FRAMEWORK_JAR=%WEB_INF_LIB_DIR%\framework.jar"
set "FRAMEWORK_CLASSES_DIR=%FRAMEWORK_DIR%\build\framework-classes"
set "WAR_FILE_NAME=%PROJECT_NAME%.war"
set "DEPLOY_DIR=%TOMCAT_HOME%\webapps"

:: === Construction du Framework (appel du script) ===
echo Lancement de la compilation du framework...
call "%FRAMEWORK_DIR%\script.bat"
if !errorlevel! neq 0 (
    echo Erreur lors de la compilation du framework.
    pause
    exit /b 1
)
echo Framework compile.

:: ============================================================================
:: 1. Nettoyage
:: ============================================================================
echo Nettoyage des anciens builds/deploiements...
if exist "%DEPLOY_DIR%\%WAR_FILE_NAME%" (
    del /f /q "%DEPLOY_DIR%\%WAR_FILE_NAME%"
)
if exist "%DEPLOY_DIR%\%PROJECT_NAME%" (
    rd /s /q "%DEPLOY_DIR%\%PROJECT_NAME%"
)
if not exist "%DEPLOY_DIR" (
    mkdir "%DEPLOY_DIR"
)
echo Nettoyage termine.

:: ============================================================================
:: 2. Génération du JAR du Framework et Build Maven
:: ============================================================================
echo Assurance de la presence de framework.jar dans le projet...
if exist "%FRAMEWORK_CLASSES_DIR%" (
    if not exist "%WEB_INF_LIB_DIR%" (
        mkdir "%WEB_INF_LIB_DIR%"
    )
    jar -c -f "%FRAMEWORK_JAR%" -C "%FRAMEWORK_CLASSES_DIR%" .
    if !errorlevel! neq 0 (
        echo Erreur lors de la creation/copie de framework.jar.
        pause
        exit /b 1
    )
) else (
    echo Attention: classes du framework introuvables: %FRAMEWORK_CLASSES_DIR%
)

echo Build Maven du projet (clean package)...
pushd "%TEST_PROJECT_DIR%"
mvn clean package -DskipTests
if !errorlevel! neq 0 (
    echo Erreur lors du build Maven.
    popd
    pause
    exit /b 1
)
popd
echo WAR Maven genere.

:: ============================================================================
:: 3. Déploiement du WAR
:: ============================================================================
echo Deploiement du WAR vers Tomcat...
copy /Y "%TEST_PROJECT_DIR%\target\%WAR_FILE_NAME%" "%DEPLOY_DIR%" > nul
if !errorlevel! neq 0 (
    echo Erreur lors de la copie du WAR vers Tomcat.
    pause
    exit /b 1
)
echo Fichier WAR copie dans Tomcat/webapps.

:: ============================================================================
:: 4. Redémarrage de Tomcat
:: ============================================================================
echo Redemarrage de Tomcat...
call "%TOMCAT_HOME%\bin\shutdown.bat"
echo Attente de l'arret de Tomcat...
timeout /t 5 >nul
call "%TOMCAT_HOME%\bin\startup.bat"

echo Tomcat redemarre.
echo Deploiement termine. Accedez a : http://localhost:8088/%PROJECT_NAME%/

endlocal
pause
