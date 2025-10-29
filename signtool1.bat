@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

:: Define the base path for files
SET "basePath=D:\OneDrive - Arcon Techsolutions Pvt. Ltd\Desktop\signpurpose\f1"
SET "zipOutputPath=D:\OneDrive - Arcon Techsolutions Pvt. Ltd\Desktop\signpurpose\files"

:: Set paths for tools
SET "signtoolExe=D:\OneDrive - Arcon Techsolutions Pvt. Ltd\Desktop\Signtool\ARCONSignTool.exe"
SET "pfxPath=D:\OneDrive - Arcon Techsolutions Pvt. Ltd\Desktop\Signtool\Arcon TechSolutions Private Limited.pfx"
SET "pfxPassword=admin@2009"
SET "winrarPath=C:\Program Files\WinRAR\WinRAR.exe"

:: Loop through each DLL, EXE, and MSI file in the base path and subdirectories
for /r "%basePath%" %%F in (*.dll *.exe *.msi) do (
    SET "fileName=%%~nF"
    SET "upperFileName=!fileName:~0,5!"
    SET "upperFileName1=!fileName:~0,7!"

    :: Check name and sign silently
    if /I "!upperFileName!"=="ARCOS" (
        echo Signing file: "%%F"
        start /B "" "%signtoolExe%" sign /f "%pfxPath%" /fd "sha256" /i "DigiCert Trusted G4 Code Signing RSA4096 SHA384 2021 CA1" /p "%pfxPassword%" "%%F"
    ) 
    if /I "!upperFileName!"=="ARCON" (
        echo Signing file: "%%F"
        start /B "" "%signtoolExe%" sign /f "%pfxPath%" /fd "sha256" /i "DigiCert Trusted G4 Code Signing RSA4096 SHA384 2021 CA1" /p "%pfxPassword%" "%%F"
    )
    if /I "!upperFileName1!"=="ARC_SEC" (
        echo Signing file: "%%F"
        start /B "" "%signtoolExe%" sign /f "%pfxPath%" /fd "sha256" /i "DigiCert Trusted G4 Code Signing RSA4096 SHA384 2021 CA1" /p "%pfxPassword%" "%%F"
    )
)

:: Find the latest folder in basePath
SET "latestFolder="
FOR /D %%D IN ("%basePath%\*") DO (
    SET "latestFolder=%%~nxD"
)

:: Check if we found a folder
if not defined latestFolder (
    echo No folder found in %basePath%.
    exit /b
)

:: Create output directory if not exists
if not exist "%zipOutputPath%" (
    mkdir "%zipOutputPath%"
)

:: Create a zip file of the latest folder
SET "zipFileName=%zipOutputPath%\%latestFolder%.zip"
pushd "%basePath%"
echo Zipping the folder "%latestFolder%" to: "%zipFileName%"
"%winrarPath%" a -r "%zipFileName%" "%latestFolder%\*"
popd

:: Call the AWS automation script
echo Calling aws_automate.bat...
CALL "C:\Users\arcon\Downloads\signpurpose\aws_automate.bat"

echo.
echo Signing process completed and zip created.
pause
ENDLOCAL
