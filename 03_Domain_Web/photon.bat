@echo off
chcp 65001 > nul
cls
echo.
echo  +------------------------------------------+
echo  ^|  PHOTON  --  Web Crawler OSINT           ^|
echo  ^|  Emails, URLs, cles API, fichiers...     ^|
echo  +------------------------------------------+
echo.
set /p URL=  URL cible (ex: https://exemple.com) :
if "%URL%"=="" goto END
echo.
set /p DEPTH=  Profondeur de crawl [1-3, defaut 2] :
if "%DEPTH%"=="" set DEPTH=2
echo.
wsl -d Ubuntu sh -c "export PATH=$HOME/.local/bin:/usr/local/bin:$PATH && python3 ~/Photon/photon.py -u '%URL%' -l '%DEPTH%' -o ~/photon_results"
echo.
echo  Resultats dans : ~/photon_results/
echo.
:END
pause
