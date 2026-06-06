@echo off
chcp 65001 > nul
cls
echo.
echo  +------------------------------------------+
echo  ^|  EXIFTOOL  --  Extraction metadonnees    ^|
echo  ^|  GPS, auteur, appareil, date...          ^|
echo  +------------------------------------------+
echo.
echo  Glisse un fichier ici OU entre le chemin :
set /p WFILE=  Fichier :
if "%WFILE%"=="" goto END
set WFILE=%WFILE:"=%
echo.
echo  [1] Tout afficher
echo  [2] GPS uniquement
echo  [3] Supprimer toutes les metadonnees
echo.
set /p MODE=  Choix [1/2/3] :
echo.
if "%MODE%"=="2" (
    wsl -d Ubuntu sh -c "exiftool -gps:all \"$(wslpath -u '%WFILE%')\""
) else if "%MODE%"=="3" (
    wsl -d Ubuntu sh -c "exiftool -all= \"$(wslpath -u '%WFILE%')\" && echo 'Metadonnees supprimees.'"
) else (
    wsl -d Ubuntu sh -c "exiftool \"$(wslpath -u '%WFILE%')\""
)
echo.
:END
pause
