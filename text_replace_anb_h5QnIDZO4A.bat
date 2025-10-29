@echo off
setlocal enabledelayedexpansion

rem Set the folder where your SQL files are located
set "folder=D:\Jenkins\QA\Auto_DB_Execution\DBScripts\1.SchemaChanges"

rem Set the text to find and replace
set "find=arcosdb"
set "replace=anbmy_ci_app"

rem Loop through all .sql files in the folder
for %%F in (%folder%\*.sql) do (
    rem Use PowerShell to perform the find and replace
    powershell -Command "(Get-Content '%%F') -replace '%find%', '%replace%' | Set-Content '%%F'"
)

echo Text replacement complete!
pause

