@ECHO OFF

set "targetpath=%~dp0"
set "command="
set "verbose="
set "forcedexecution="

set pathFlagActive=""
set commandFlagActive=""

FOR %%A IN (%*) DO (
	echo %%A
	IF "%%A" == "-p" (
		set pathFlagActive="true"
		echo %pathFlagActive%
	)
REM	ELSE IF %%A == "-c"(
REM		set "commandFlagActive=true"
REM	)
REM	ELSE IF %%A == "-v"(
REM		set "verbose=true"
REM	)
REM	ELSE IF %%A == "-f"(
REM		set "forcedexecution=true"
REM	)
REM	ELSE (
REM		IF %pathFlagActive% == "true" (
REM			set "targetpath==%%A"
REM			set "pathFlagActive=false"
REM			echo %targetpath%
REM			echo %pathFlagActive%
REM		)
REM		ELSE IF %commandFlagActive% == "true" (
REM			set "command==%%A"
REM			set "commandFlagActive=false"
REM			echo %command%
REM			echo %commandFlagActive%
REM		)
REM	)
)

