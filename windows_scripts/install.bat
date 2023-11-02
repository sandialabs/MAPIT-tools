::----------------------------------------------
:: The purpose of this script is to
:: activate the MAPIT environment and run
:: MAPIT. Most of the code is focused on
:: just figuring out where Anaconda is.
:: This is done by looking at the environments
:: file, which SHOULD be in the same place for
:: conda installs.
::----------------------------------------------

:: @echo off

if NOT "%~1"=="" set http_proxy=%1
if NOT "%~1"=="" set https_proxy=%1
if NOT "%~2"=="" set up_path=%2
if "%~2"=="" set up_path=%userprofile%



curl -O https://repo.anaconda.com/miniconda/Miniconda3-latest-Windows-x86_64.exe --ssl-no-revoke
start /wait Miniconda3-latest-Windows-x86_64.exe /InstallationType=JustMe /RegisterPython=0 /S /D=%up_path%\Miniconda3

echo Creating environment
call %up_path%\Miniconda3\condabin\activate.bat
if NOT "%~2"=="" cd .\windows_scripts 
if NOT "%~1"=="" call conda config --set ssl_verify false
call conda env create -f ../requirements.yml 
if  errorlevel 1 goto ERROR
echo Install complete
PAUSE
goto EOF

:ERROR
echo Install failed
PAUSE

:EOF
