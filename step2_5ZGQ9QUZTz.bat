@echo off
setlocal enabledelayedexpansion

:: Set paths
set "SOURCE_BASE=C:\Users\Administrator\Downloads\pam_db_extract\arconpamdb_mysql-PAM_Developer\ARCOSDB"
set "DEST_BASE=E:\Executor\MySQL_Utility\Vault_Executor_MySQL\DBScript"
set "LOG_FILE=%~dp0copy_log.txt"

:: List of folders to copy (source folder names include the numeric prefix)
set "FOLDERS=1.SchemaChanges 2.Functions 3.Views 4.Procedures 5.DataScripts"

:: Logging start
echo ============================================== > "%LOG_FILE%"
echo Script started at %DATE% %TIME% >> "%LOG_FILE%"
echo Cleaning destination folder: %DEST_BASE% >> "%LOG_FILE%"

:: Delete all contents of destination
rmdir /s /q "%DEST_BASE%" 2>>"%LOG_FILE%"
mkdir "%DEST_BASE%" 2>>"%LOG_FILE%"

:: Loop through folders
for %%F in (%FOLDERS%) do (
    set "SRC=%SOURCE_BASE%\%%F"
    set "FOLDER_NAME=%%~nF"
    set "DEST=%DEST_BASE%\!FOLDER_NAME!"

    echo Copying from !SRC! to !DEST! >> "%LOG_FILE%"
    
    if exist "!SRC!" (
        xcopy /E /I /Y "!SRC!" "!DEST!" >> "%LOG_FILE%" 2>&1
        if errorlevel 1 (
            echo ERROR: Failed to copy !SRC! >> "%LOG_FILE%"
        ) else (
            echo SUCCESS: Copied to !DEST! >> "%LOG_FILE%"
        )
    ) else (
        echo WARNING: Source folder not found: !SRC! >> "%LOG_FILE%"
    )
)

echo All folder copy operations completed. >> "%LOG_FILE%"
echo Script finished at %DATE% %TIME% >> "%LOG_FILE%"
echo ============================================== >> "%LOG_FILE%"
