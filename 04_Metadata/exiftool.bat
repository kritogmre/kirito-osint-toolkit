@echo off
chcp 65001 > nul
cls
echo.
echo  +------------------------------------------+
echo  ^|  EXIFTOOL  --  Extraction metadonnees    ^|
echo  ^|  GPS, auteur, appareil, date...          ^|
echo  +------------------------------------------+
echo.
echo  [1] Analyser un fichier
echo  [2] Analyser un dossier entier
echo  [3] Extraire uniquement le GPS
echo  [4] Extraire l auteur (PDF / Word)
echo  [5] Supprimer toutes les metadonnees
echo  [6] Exporter en JSON
echo.
set /p MODE=  Choix [1-6] :
echo.
if "%MODE%"=="1" goto FILE
if "%MODE%"=="2" goto FOLDER
if "%MODE%"=="3" goto GPS
if "%MODE%"=="4" goto AUTHOR
if "%MODE%"=="5" goto STRIP
if "%MODE%"=="6" goto JSON
goto FILE

:FILE
set /p WFILE=  Chemin du fichier (ex: C:\photo.jpg) :
set WFILE=%WFILE:"=%
wsl -d Ubuntu sh -c "exiftool \"$(wslpath -u '%WFILE%')\""
goto END

:FOLDER
set /p WFOLDER=  Chemin du dossier (ex: C:\photos) :
set WFOLDER=%WFOLDER:"=%
wsl -d Ubuntu sh -c "exiftool \"$(wslpath -u '%WFOLDER%')\""
goto END

:GPS
set /p WFILE=  Chemin du fichier :
set WFILE=%WFILE:"=%
wsl -d Ubuntu sh -c "exiftool -gps:all \"$(wslpath -u '%WFILE%')\""
goto END

:AUTHOR
set /p WFILE=  Chemin du fichier (PDF ou Word) :
set WFILE=%WFILE:"=%
wsl -d Ubuntu sh -c "exiftool -author -creator -producer \"$(wslpath -u '%WFILE%')\""
goto END

:STRIP
set /p WFILE=  Chemin du fichier a anonymiser :
set WFILE=%WFILE:"=%
wsl -d Ubuntu sh -c "exiftool -all= \"$(wslpath -u '%WFILE%')\" && echo 'Metadonnees supprimees.'"
goto END

:JSON
set /p WFILE=  Chemin du fichier :
set WFILE=%WFILE:"=%
wsl -d Ubuntu sh -c "exiftool -json \"$(wslpath -u '%WFILE%')\""
goto END

:END
echo.
pause
