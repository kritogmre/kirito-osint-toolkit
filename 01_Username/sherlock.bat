@echo off
chcp 65001 > nul
cls
echo.
echo  +------------------------------------------+
echo  ^|  SHERLOCK  --  Username Search           ^|
echo  ^|  Recherche un pseudo sur 400+ sites      ^|
echo  +------------------------------------------+
echo.
set /p TARGET=  Pseudo a rechercher :
if "%TARGET%"=="" goto END
echo.
echo  [1] Recherche simple
echo  [2] Sauvegarder les resultats dans un fichier
echo  [3] Recherche avec timeout reduit (plus rapide)
echo  [4] Plusieurs pseudos a la fois
echo.
set /p MODE=  Choix [1-4] :
echo.
if "%MODE%"=="1" goto SIMPLE
if "%MODE%"=="2" goto SAVE
if "%MODE%"=="3" goto FAST
if "%MODE%"=="4" goto MULTI
goto SIMPLE

:SIMPLE
wsl -d Ubuntu sh -c "export PATH=$HOME/.local/bin:/usr/local/bin:$PATH && sherlock '%TARGET%' --print-found"
goto END

:SAVE
wsl -d Ubuntu sh -c "export PATH=$HOME/.local/bin:/usr/local/bin:$PATH && sherlock '%TARGET%' --print-found --output ~/'%TARGET%'_sherlock.txt && echo 'Resultats sauvegardes dans ~/%TARGET%_sherlock.txt'"
goto END

:FAST
wsl -d Ubuntu sh -c "export PATH=$HOME/.local/bin:/usr/local/bin:$PATH && sherlock '%TARGET%' --print-found --timeout 5"
goto END

:MULTI
set /p TARGETS=  Autres pseudos (separes par espaces) :
wsl -d Ubuntu sh -c "export PATH=$HOME/.local/bin:/usr/local/bin:$PATH && sherlock '%TARGET%' %TARGETS% --print-found"
goto END

:END
echo.
pause
