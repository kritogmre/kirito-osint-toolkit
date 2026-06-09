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
echo  [1] Crawl rapide (profondeur 1)
echo  [2] Crawl normal (profondeur 2)
echo  [3] Crawl profond (profondeur 3)
echo  [4] Crawl avec delai (discret, profondeur 2)
echo.
set /p MODE=  Choix [1-4] :
echo.
if "%MODE%"=="1" goto L1
if "%MODE%"=="2" goto L2
if "%MODE%"=="3" goto L3
if "%MODE%"=="4" goto SLOW
goto L2

:L1
wsl -d Ubuntu sh -c "export PATH=$HOME/.local/bin:/usr/local/bin:$PATH && python3 ~/Photon/photon.py -u '%URL%' -l 1 -o ~/photon_out"
goto DONE

:L2
wsl -d Ubuntu sh -c "export PATH=$HOME/.local/bin:/usr/local/bin:$PATH && python3 ~/Photon/photon.py -u '%URL%' -l 2 -o ~/photon_out"
goto DONE

:L3
wsl -d Ubuntu sh -c "export PATH=$HOME/.local/bin:/usr/local/bin:$PATH && python3 ~/Photon/photon.py -u '%URL%' -l 3 -o ~/photon_out"
goto DONE

:SLOW
wsl -d Ubuntu sh -c "export PATH=$HOME/.local/bin:/usr/local/bin:$PATH && python3 ~/Photon/photon.py -u '%URL%' -l 2 --delay 2 -o ~/photon_out"
goto DONE

:DONE
echo.
echo  Resultats dans : ~/photon_out/
echo    - urls.txt     : toutes les URLs
echo    - external.txt : liens externes
echo    - emails.txt   : adresses email
echo    - files.txt    : fichiers accessibles
echo    - intel.txt    : cles, tokens, donnees sensibles
goto END

:END
echo.
pause
