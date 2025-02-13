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

:: Remove Conda initialization from shell profiles
echo Removing Conda initialization from shell profiles...
set profileFiles=%userprofile%\.bashrc %userprofile%\.bash_profile %userprofile%\.zshrc %userprofile%\.config\powershell\profile.ps1 %userprofile%\Documents\WindowsPowerShell\profile.ps1

for %%f in (%profileFiles%) do (
    if exist %%f (
        echo Processing %%f...
        powershell -Command "Get-Content %%f | Select-String -Pattern '# >>> conda initialize >>>' -Context 0,1000 | ForEach-Object { $_.Context.PostContext | Set-Content %%f }"
    )
)

:: Remove Conda from PATH
echo Removing Conda from PATH...
setlocal enabledelayedexpansion
set "envPath=%PATH%"
set "condaPath=%up_path%\Miniconda3\Scripts"
set "newPath="
for %%i in ("!envPath:;=" "!") do (
    if /I "%%~i" neq "%condaPath%" (
        if defined newPath (
            set "newPath=!newPath!;%%~i"
        ) else (
            set "newPath=%%~i"
        )
    )
)
setx PATH "!newPath!"

:: Remove Conda configuration files
echo Removing Conda configuration files...
del %userprofile%\.condarc /Q
rmdir /S /Q %userprofile%\.conda

echo removal complete
PAUSE