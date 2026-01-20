@echo off
setlocal

:: Set the path to the dbscripts folder
set "dbscripts_folder=D:\Jenkins\QA\Auto_DB_Execution\DBScripts"

:: Database connection settings
set "server=10.10.0.166"
set "database=qaanbmy_ci_app"
set "username=devops"
set "password=Dev0p$@2023"

:: Loop through all subfolders in dbscripts
for /r "%dbscripts_folder%" %%f in (*.sql) do (
    echo Executing SQL file: %%f
    
    :: Execute SQL file and print output to console
    mysql -h %server% -u %username% -p%password% %database% < "%%f"
    
    :: Check for errors and stop execution if any occur
    if not %ERRORLEVEL% equ 0 (
        echo ERROR: Failed to execute %%f. Stopping script.
        exit /b %ERRORLEVEL%
    )
    
    echo SUCCESS: %%f executed successfully.
    echo.
)

pause
