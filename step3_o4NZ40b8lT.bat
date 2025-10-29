@echo off
setlocal EnableDelayedExpansion

REM Set inputs
set "path_input=E:\Executor\MySQL_Utility\Vault_Executor_MySQL\DBScript\1"
set "old_string=arcosdb"
set "new_string=arcosdb_dev_int"
set "exe_path=E:\Executor\MySQL_Utility\textReplace.exe"
set "log_file=run_text_replace.log"

REM Remove trailing spaces (via a trick with string substitution)
for /f "tokens=* delims= " %%A in ("!path_input!") do set "path_input=%%A"

REM Start logging
echo ============================================== >> "%log_file%"
echo Script started at %DATE% %TIME% >> "%log_file%"
echo Cleaned Input Path: !path_input! >> "%log_file%"
echo Old String: !old_string! >> "%log_file%"
echo New String: !new_string! >> "%log_file%"

REM Check if path exists
if not exist "!path_input!" (
    echo ERROR: Input path does not exist: !path_input! >> "%log_file%"
    echo Script failed due to missing input path. >> "%log_file%"
    echo ============================================== >> "%log_file%"
    exit /b 1
)

REM Prepare input file
set "input_file=%TEMP%\text_replace_input.txt"
(
    echo !path_input!
    echo !old_string!
    echo !new_string!
) > "!input_file!"

REM Run the tool
"%exe_path%" < "!input_file%"
set "errorcode=%ERRORLEVEL%"

if not !errorcode! == 0 (
    echo ERROR: textReplace.exe failed with error code !errorcode!. >> "%log_file%"
) else (
    echo textReplace.exe completed successfully. >> "%log_file%"
)

REM Clean up
del /f /q "!input_file!" >nul 2>&1

echo Script finished at %DATE% %TIME% >> "%log_file%"
echo ============================================== >> "%log_file%"
endlocal
