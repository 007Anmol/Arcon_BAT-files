@echo off
setlocal

:: Set exact paths
set "ZIP_PATH=C:\Users\Administrator\Downloads\arconpamdb_mysql-PAM_Developer.zip"
set "DEST_PATH=C:\Users\Administrator\Downloads\pam_db_extract"

echo ========================================
echo Unzipping PAM DB Scripts
echo From: %ZIP_PATH%
echo To:   %DEST_PATH%
echo ========================================

:: Delete destination if it already exists
if exist "%DEST_PATH%" (
    echo Cleaning existing destination folder...
    rmdir /s /q "%DEST_PATH%"
)

:: Create destination folder
mkdir "%DEST_PATH%"
if errorlevel 1 (
    echo ERROR: Failed to create destination folder
    exit /b 1
)

:: Unzip using PowerShell
powershell -ExecutionPolicy Bypass -Command ^
"try { ^
    Expand-Archive -Path '%ZIP_PATH%' -DestinationPath '%DEST_PATH%' -Force; ^
    Write-Host '? Unzip completed successfully' ^
} catch { ^
    Write-Host '? Unzip failed:' $_.Exception.Message; ^
    exit 1 ^
}"

if errorlevel 1 (
    echo ERROR: Failed to unzip the archive
    exit /b 1
)

echo Done.
exit /b 0
