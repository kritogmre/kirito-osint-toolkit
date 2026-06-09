@echo off
chcp 65001 > nul
cls
echo.
echo  +------------------------------------------+
echo  ^|  HOLEHE  --  Email OSINT                 ^|
echo  ^|  Verifie si l email est sur 120+ sites   ^|
echo  +------------------------------------------+
echo.
set /p TARGET=  Adresse email :
if "%TARGET%"=="" goto END
echo.
echo  [1] Afficher uniquement les sites trouves
echo  [2] Afficher tous les resultats
echo  [3] Sauvegarder dans un fichier
echo.
set /p MODE=  Choix [1-3] :
echo.
if "%MODE%"=="1" goto FOUND
if "%MODE%"=="2" goto ALL
if "%MODE%"=="3" goto SAVE
goto FOUND

:FOUND
wsl -d Ubuntu sh -c "export PATH=$HOME/.local/bin:/usr/local/bin:$PATH && holehe '%TARGET%' --only-used"
goto END

:ALL
wsl -d Ubuntu sh -c "export PATH=$HOME/.local/bin:/usr/local/bin:$PATH && holehe '%TARGET%'"
goto END

:SAVE
wsl -d Ubuntu sh -c "export PATH=$HOME/.local/bin:/usr/local/bin:$PATH && holehe '%TARGET%' --only-used | tee ~/holehe_results.txt && echo 'Sauvegarde dans ~/holehe_results.txt'"
goto END

:END
echo.
pause
