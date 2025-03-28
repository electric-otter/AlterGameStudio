:: Install Hoppity
git clone https://gitlab.com/kryptonitewing/hoppity.git
cd hoppity

:: Run the Hoppity installer
START /w execute.cmd

:: Confirmation message
echo Start hoppity installer

:: Move hoppity to AlterGameStudio directory
move /Y hoppity ..\AlterGameStudio

:: Confirmation message after moving
echo Hoppity has been successfully installed and moved to AlterGameStudio.
