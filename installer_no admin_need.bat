@echo off

:: Get the directory where the batch file is located (this script's folder)
set SCRIPT_DIR=%~dp0

:: Display current working directory
echo Installing Nuke Tools from %SCRIPT_DIR%

:: Path to the correct .nuke folder in the user's home directory
set NUKEDIR=%USERPROFILE%\.nuke

:: Display the full .nuke path
echo .nuke folder is located at: %NUKEDIR%

:: Check if the .nuke folder exists
if not exist "%NUKEDIR%" (
    echo .nuke folder not found. Creating .nuke folder.
    mkdir "%NUKEDIR%"
)

:: Create the Nuke_Tools_Extensions folder if it does not exist
if not exist "%NUKEDIR%\Nuke_Tools_Extensions" (
    echo Creating the Nuke_Tools_Extensions folder...
    mkdir "%NUKEDIR%\Nuke_Tools_Extensions"
)

:: Print the folder where files will be copied
echo Copying files to: %NUKEDIR%\Nuke_Tools_Extensions

:: Copy Recent_Projects.py or Recent_Projects.pyc
if exist "%SCRIPT_DIR%Recent_Projects.py" (
    copy "%SCRIPT_DIR%Recent_Projects.py" "%NUKEDIR%\Nuke_Tools_Extensions\Recent_Projects.py"
    echo Recent_Projects.py copied.
) else if exist "%SCRIPT_DIR%Recent_Projects.pyc" (
    copy "%SCRIPT_DIR%Recent_Projects.pyc" "%NUKEDIR%\Nuke_Tools_Extensions\Recent_Projects.pyc"
    echo Recent_Projects.pyc copied.
) else (
    echo WARNING: No Recent_Projects.py or Recent_Projects.pyc found. Skipping this file.
)

:: Copy Render_History.py or Render_History.pyc
if exist "%SCRIPT_DIR%Render_History.py" (
    copy "%SCRIPT_DIR%Render_History.py" "%NUKEDIR%\Nuke_Tools_Extensions\Render_History.py"
    echo Render_History.py copied.
) else if exist "%SCRIPT_DIR%Render_History.pyc" (
    copy "%SCRIPT_DIR%Render_History.pyc" "%NUKEDIR%\Nuke_Tools_Extensions\Render_History.pyc"
    echo Render_History.pyc copied.
) else (
    echo WARNING: No Render_History.py or Render_History.pyc found. Skipping this file.
)

:: Copy the nuke_Logo.png
if exist "%SCRIPT_DIR%nuke_Logo.png" (
    copy "%SCRIPT_DIR%nuke_Logo.png" "%NUKEDIR%\Nuke_Tools_Extensions\nuke_Logo.png"
    echo nuke_Logo.png copied.
) else (
    echo WARNING: nuke_Logo.png not found. Skipping this file.
)

:: Add the import command to the Nuke menu.py file
echo Adding the import commands to the Nuke menu.py...

:: Path to the Nuke menu.py file
set MENU_FILE=%USERPROFILE%\.nuke\menu.py

:: Check if menu.py exists, create it if it does not
if not exist "%MENU_FILE%" (
    echo menu.py file not found, creating a new one...
    echo import sys >> "%MENU_FILE%"
    echo import os >> "%MENU_FILE%"
    echo. >> "%MENU_FILE%"
)

:: Append the updated import commands and menu setup to menu.py
echo # Path to custom tools >> "%MENU_FILE%"
echo nuke_tools_path = os.path.join(os.path.expanduser("~"), ".nuke", "Nuke_Tools_Extensions") >> "%MENU_FILE%"
echo sys.path.append(nuke_tools_path) >> "%MENU_FILE%"
echo import Recent_Projects >> "%MENU_FILE%"
echo. >> "%MENU_FILE%"
echo # Import the specific function from Render_History >> "%MENU_FILE%"
echo from Render_History import show_render_history >> "%MENU_FILE%"
echo. >> "%MENU_FILE%"
echo # Add command to open Render History >> "%MENU_FILE%"
echo nuke.menu('Nuke').addCommand('Render History', show_render_history, 'ctrl+r') >> "%MENU_FILE%"

:: Finished message
echo Installation complete! Your Nuke Tools are now installed and the import commands have been added to the menu.py.
pause
