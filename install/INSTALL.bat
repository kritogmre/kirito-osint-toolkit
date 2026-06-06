@echo off
chcp 65001 > nul
cls

:: ─────────────────────────────────────────────
::  ETAPE 1 — Droits administrateur
:: ─────────────────────────────────────────────
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo  [!] Droits administrateur requis.
    echo  [!] Relancement automatique...
    echo.
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

:: ─────────────────────────────────────────────
::  ETAPE 2 — Verifier WSL
:: ─────────────────────────────────────────────
wsl echo ok >nul 2>&1
if %errorlevel% neq 0 goto INSTALL_WSL
goto CHECK_UBUNTU

:INSTALL_WSL
cls
echo.
echo  +------------------------------------------+
echo  ^|   WSL non detecte — Installation...      ^|
echo  +------------------------------------------+
echo.
echo  Installation de WSL2 en cours...
wsl --install
echo.
echo  +------------------------------------------+
echo  ^|  IMPORTANT : Redemarrez votre PC         ^|
echo  ^|  puis relancez INSTALL.bat               ^|
echo  +------------------------------------------+
echo.
pause
exit /b

:: ─────────────────────────────────────────────
::  ETAPE 3 — Verifier Ubuntu
:: ─────────────────────────────────────────────
:CHECK_UBUNTU
wsl --list --quiet 2>nul | findstr /i "Ubuntu" >nul 2>&1
if %errorlevel% neq 0 goto INSTALL_UBUNTU
goto CHECK_DEPS

:INSTALL_UBUNTU
cls
echo.
echo  Ubuntu non detecte — Installation...
wsl --install -d Ubuntu
echo.
echo  Attendez la fin de l installation Ubuntu,
echo  puis relancez INSTALL.bat
echo.
pause
exit /b

:: ─────────────────────────────────────────────
::  ETAPE 4 — Dependances WSL (python, pip, pipx, git...)
:: ─────────────────────────────────────────────
:CHECK_DEPS
cls
echo.
echo  Verification des dependances WSL...
echo.
wsl -d Ubuntu sh -c "command -v python3 > /dev/null 2>&1 && command -v pip3 > /dev/null 2>&1 && command -v pipx > /dev/null 2>&1 && command -v git > /dev/null 2>&1"
if %errorlevel% neq 0 goto INSTALL_DEPS
echo  [OK] Dependances deja installees.
goto MENU

:INSTALL_DEPS
echo  Installation des dependances de base...
echo.
wsl -d Ubuntu sh -c "sudo apt-get update -y && sudo apt-get install -y python3 python3-pip python3-venv pipx git curl wget && pipx ensurepath && echo 'Dependances OK'"
if %errorlevel% neq 0 (
    echo.
    echo  [!] Erreur lors de l installation des dependances.
    echo  [!] Verifiez votre connexion internet.
    pause
    exit /b
)
echo.
echo  [OK] Dependances installees.

:: ─────────────────────────────────────────────
::  MENU PRINCIPAL
:: ─────────────────────────────────────────────
:MENU
cls
type "%~dp0menu.sh" | wsl -d Ubuntu sh -c "tr -d '\r' > /tmp/_menu.sh && sh /tmp/_menu.sh header"
echo.
set /p CHOICE=    Votre choix [1-4] :

if "%CHOICE%"=="1" goto INSTALL_ALL
if "%CHOICE%"=="2" goto CHECK
if "%CHOICE%"=="3" goto FIX
if "%CHOICE%"=="4" goto EXIT
goto MENU

:INSTALL_ALL
cls
type "%~dp0menu.sh" | wsl -d Ubuntu sh -c "tr -d '\r' > /tmp/_menu.sh && sh /tmp/_menu.sh install"
echo.
pause
goto MENU

:CHECK
cls
type "%~dp0check_tools.sh" | wsl -d Ubuntu sh -c "tr -d '\r' > /tmp/_check.sh && sh /tmp/_check.sh"
echo.
pause
goto MENU

:FIX
cls
type "%~dp0check_tools.sh" | wsl -d Ubuntu sh -c "tr -d '\r' > /tmp/_check.sh && sh /tmp/_check.sh"
echo.
pause
goto MENU

:EXIT
type "%~dp0menu.sh" | wsl -d Ubuntu sh -c "tr -d '\r' > /tmp/_menu.sh && sh /tmp/_menu.sh bye"
timeout /t 2 >nul
exit
