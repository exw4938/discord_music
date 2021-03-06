@echo off
TITLE Music Bot

@rem This is to make sure there is some form of python in path
reg query HKCU\Environment /v PATH>tmp.txt
echo %PATH%>>tmp.txt
findstr /I /C:"python" tmp.txt > tmp.txt
set t=0
For /F %%A IN (tmp.txt) do set \a t=t+1
IF %t%==1 (
	@rem TODO have this find and register the python.exe in the users registry
	echo Please make sure Python is installed and in your PATH variable
	exit
)
del tmp.txt

@rem Checks whether or not there is a file for the bot's token
IF Not Exist token.txt (
	goto getInput
)

@rem for logging purposes
IF Not Exist log (mkdir log)

:cont
python bot\bot.py
IF ERRORLEVEL 1 goto cont
pause
exit

:getInput
set /p "input=Enter Bot Token: "
echo %input%>token.txt
goto cont
