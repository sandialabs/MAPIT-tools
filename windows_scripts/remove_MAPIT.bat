::----------------------------------------------
:: The purpose of this script is to
:: remove the MAPIT environment -- usually in
:: case an install was broken. Most of the code is
:: focused on just figuring out where Anaconda is.
:: This is done by looking at the environments
:: file, which SHOULD be in the same place for
:: conda installs.
::----------------------------------------------

if NOT "%~1"=="" set http_proxy=%1
if NOT "%~1"=="" set https_proxy=%1
if NOT "%~2"=="" set up_path=%2
if "%~2"=="" set up_path=%userprofile%

echo off
call %up_path%\Miniconda3\condabin\activate.bat
echo removing MAPIT environment...
call conda remove --name MAPIT_env --all -y >nul 2>&1
echo removing Miniconda3...
rmdir /s /q %up_path%\Miniconda3
del .\Miniconda3-latest-Windows-x86_64.exe
echo removal complete
PAUSE
