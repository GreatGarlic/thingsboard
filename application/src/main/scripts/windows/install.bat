@ECHO OFF

setlocal ENABLEEXTENSIONS



@ECHO Java 1.8 found!
@ECHO Installing ${pkg.name} ...

SET loadDemo=false

if "%1" == "--loadDemo" (
    SET loadDemo=true
)

SET BASE=%~dp0
SET LOADER_PATH=%BASE%\conf,%BASE%\extensions
SET SQL_DATA_FOLDER=%BASE%\data\sql
SET jarfile=%BASE%\lib\${pkg.name}.jar
SET installDir=%BASE%\data

PUSHD %BASE%\conf

java -cp %jarfile% -Dloader.main=org.thingsboard.server.ThingsboardInstallApplication^
                    -Dinstall.data_dir=%installDir%^
                    -Dinstall.load_demo=%loadDemo%^
                    -Dspring.jpa.hibernate.ddl-auto=none^
                    -Dinstall.upgrade=false^
                    -Dlogging.config=%BASE%\install\logback.xml^
                    org.springframework.boot.loader.PropertiesLauncher

if errorlevel 1 (
   @echo ThingsBoard installation failed!
)
POPD

%BASE%${pkg.name}.exe install

@ECHO ThingsBoard installed successfully!

GOTO END

:JAVA_NOT_INSTALLED
@ECHO Java 1.8 or above is not installed
@ECHO Please go to https://java.com/ and install Java. Then retry installation.
PAUSE
GOTO END

:END


