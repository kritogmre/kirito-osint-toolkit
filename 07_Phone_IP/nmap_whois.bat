@echo off
chcp 65001 > nul
cls
echo.
echo  +------------------------------------------+
echo  ^|  NMAP / WHOIS  --  IP et Domain OSINT   ^|
echo  ^|  Ports, services, geo, DNS, WHOIS...    ^|
echo  +------------------------------------------+
echo.
echo  [1] WHOIS (infos domaine ou IP)
echo  [2] DNS lookup (nslookup / dig)
echo  [3] Reverse DNS (IP vers domaine)
echo  [4] Geolocalisation IP
echo  [5] NMAP scan rapide (ports courants)
echo  [6] NMAP complet (services + OS)
echo  [7] NMAP scan discret (SYN)
echo.
set /p MODE=  Choix [1-7] :
echo.
if "%MODE%"=="1" goto WHOIS
if "%MODE%"=="2" goto DNS
if "%MODE%"=="3" goto RDNS
if "%MODE%"=="4" goto GEO
if "%MODE%"=="5" goto NMAP_F
if "%MODE%"=="6" goto NMAP_FULL
if "%MODE%"=="7" goto NMAP_SYN
goto WHOIS

:WHOIS
set /p TARGET=  IP ou domaine :
wsl -d Ubuntu sh -c "whois '%TARGET%'"
goto END

:DNS
set /p TARGET=  Domaine :
wsl -d Ubuntu sh -c "dig '%TARGET%' && nslookup '%TARGET%'"
goto END

:RDNS
set /p TARGET=  Adresse IP :
wsl -d Ubuntu sh -c "dig -x '%TARGET%' +short && nslookup '%TARGET%'"
goto END

:GEO
set /p TARGET=  Adresse IP :
wsl -d Ubuntu sh -c "curl -s ipinfo.io/'%TARGET%' && echo '' && curl -s ipapi.co/'%TARGET%'/json"
goto END

:NMAP_F
set /p TARGET=  IP ou domaine :
wsl -d Ubuntu sh -c "nmap -F '%TARGET%'"
goto END

:NMAP_FULL
set /p TARGET=  IP ou domaine :
wsl -d Ubuntu sh -c "nmap -sV -O '%TARGET%'"
goto END

:NMAP_SYN
set /p TARGET=  IP ou domaine :
wsl -d Ubuntu sh -c "sudo nmap -sS '%TARGET%'"
goto END

:END
echo.
pause
