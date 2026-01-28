@echo off
setlocal enabledelayedexpansion

:: ============================================================================
:: Script pour compiler et déployer le Test-Project
:: ============================================================================

:: === Variables à adapter ===
set "TEST_PROJECT_DIR=%~dp0"
if "%TEST_PROJECT_DIR:~-1%"=="\" set "TEST_PROJECT_DIR=%TEST_PROJECT_DIR:~0,-1%"
set "FRAMEWORK_DIR=D:\L3\GProjet\Vroomer\framework"
set "PROJECT_NAME=project"
set "TOMCAT_HOME=D:\Progtool\apache-tomcat-10.1.28"
set "JAVA_HOME=C:\Program Files\Java\jdk-17"

:: === Construction du Framework (appel du script) ===
echo Lancement de la compilation du framework...
call "%FRAMEWORK_DIR%\script.bat"
if !errorlevel! neq 0 (
    echo Erreur lors de la compilation du framework.
    pause
    exit /b 1
)
echo Framework compile.

:: === Variables calculées (ne pas modifier) ===
set "PATH=%JAVA_HOME%\bin;%PATH%"
set "BUILD_DIR=%TEST_PROJECT_DIR%\build"
set "WEB_INF_LIB_DIR=%TEST_PROJECT_DIR%\src\main\webapp\WEB-INF\lib"
set "FRAMEWORK_JAR=%WEB_INF_LIB_DIR%\framework.jar"
set "TEST_CLASSES_DIR=%TEST_PROJECT_DIR%\src\main\webapp\WEB-INF\classes"
set "WAR_FILE_NAME=%PROJECT_NAME%.war"
set "DEPLOY_DIR=%TOMCAT_HOME%\webapps"

:: Construction du Classpath
set "FULL_CLASSPATH=%FRAMEWORK_JAR%"
for %%j in ("%TOMCAT_HOME%\lib\*.jar") do (
    set "FULL_CLASSPATH=!FULL_CLASSPATH!;%%j"
)

:: ============================================================================
:: 1. Nettoyage
:: ============================================================================
echo Nettoyage des anciens builds du projet de test...
if exist "%BUILD_DIR%" (
    rd /s /q "%BUILD_DIR%"
)
if exist "%TEST_CLASSES_DIR%" (
    rd /s /q "%TEST_CLASSES_DIR%"
)
if exist "%DEPLOY_DIR%\%WAR_FILE_NAME%" (
    del /f /q "%DEPLOY_DIR%\%WAR_FILE_NAME%"
)
if exist "%DEPLOY_DIR%\%PROJECT_NAME%" (
    rd /s /q "%DEPLOY_DIR%\%PROJECT_NAME%"
)

mkdir "%BUILD_DIR%"
mkdir "%TEST_CLASSES_DIR%"
if not exist "%DEPLOY_DIR%" (
    mkdir "%DEPLOY_DIR%"
)

echo Nettoyage termine.

:: ============================================================================
:: 2. Compilation du Projet de Test
:: ============================================================================
echo Compilation du projet de test...
set "TEST_SOURCES_FILE=%BUILD_DIR%\test_sources.txt"
dir /s /b "%TEST_PROJECT_DIR%\src\main\java\*.java" > "%TEST_SOURCES_FILE%"
for %%A in ("%TEST_SOURCES_FILE%") do set "FileSize=%%~zA"
if !FileSize! gtr 0 (
    javac -d "%TEST_CLASSES_DIR%" -cp "!FULL_CLASSPATH!" -parameters @"%TEST_SOURCES_FILE%"
    if !errorlevel! neq 0 (
        echo Erreur lors de la compilation du projet de test.
        pause
        exit /b 1
    )
)
echo Projet de test compile.

:: ============================================================================
:: 3. Création du WAR
:: ============================================================================
echo Creation du fichier %WAR_FILE_NAME%...
cd "%TEST_PROJECT_DIR%\src\main\webapp"
jar -c -f "%BUILD_DIR%\%WAR_FILE_NAME%" .
if !errorlevel! neq 0 (
    echo Erreur lors de la creation du WAR.
    cd "%TEST_PROJECT_DIR%"
    pause
    exit /b 1
)
cd "%TEST_PROJECT_DIR%"
echo Fichier WAR cree dans le dossier build.

:: ============================================================================
:: 4. Déploiement du WAR
:: ============================================================================
echo Deploiement du WAR vers Tomcat...
copy /Y "%BUILD_DIR%\%WAR_FILE_NAME%" "%DEPLOY_DIR%" > nul
if !errorlevel! neq 0 (
    echo Erreur lors de la copie du WAR vers Tomcat.
    pause
    exit /b 1
)
echo Fichier WAR copie dans Tomcat/webapps.

:: ============================================================================
:: 5. Redémarrage de Tomcat
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
