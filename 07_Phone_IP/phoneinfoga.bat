@echo off
chcp 65001 > nul
cls
echo.
echo  +------------------------------------------+
echo  ^|  PHONEINFOGA  --  Phone OSINT            ^|
echo  ^|  Pays, operateur, type de ligne...       ^|
echo  +------------------------------------------+
echo.
echo  [1] Scan d un numero
echo  [2] Scan avec export JSON
echo  [3] Lancer l interface web (port 8080)
echo.
set /p MODE=  Choix [1-3] :
echo.
if "%MODE%"=="1" goto SCAN
if "%MODE%"=="2" goto JSON
if "%MODE%"=="3" goto WEB
goto SCAN

:SCAN
echo  Format : +33612345678 (avec indicatif pays)
set /p NUMBER=  Numero :
wsl -d Ubuntu sh -c "export PATH=$HOME/.local/bin:/usr/local/bin:$PATH && phoneinfoga scan -n '%NUMBER%'"
goto END

:JSON
echo  Format : +33612345678
set /p NUMBER=  Numero :
wsl -d Ubuntu sh -c "export PATH=$HOME/.local/bin:/usr/local/bin:$PATH && phoneinfoga scan -n '%NUMBER%' -o json"
goto END

:WEB
echo  Lancement de l interface web...
echo  Ouvre http://localhost:8080 dans ton navigateur.
echo  (Ctrl+C pour arreter)
wsl -d Ubuntu sh -c "export PATH=$HOME/.local/bin:/usr/local/bin:$PATH && phoneinfoga serve -p 8080"
goto END

:END
echo.
pause
