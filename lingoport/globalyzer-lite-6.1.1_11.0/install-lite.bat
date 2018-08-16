@echo off &setlocal
REM
REM The log4j.properties file needs to be "installed" on the current machine
REM by replacing ${user.home} with environment variable USERPROFILE
REM

REM
REM Make sure USERPROFILE is set
REM
IF "%USERPROFILE%"=="" (
    ECHO USERPROFILE is NOT defined - Globalyzer Lite installation failed
	goto end
	)

REM
REM Perform the replacement
REM	
set "search=${user.home}"
set "replace=%USERPROFILE%"
set "logfile=log4j.properties"
set "tmpfile=log4j.properties.tmp"
(for /f "delims=" %%i in (%logfile%) do (
    set "line=%%i"
    setlocal enabledelayedexpansion
    set "line=!line:%search%=%replace%!"
    echo(!line!
    endlocal
))>"%tmpfile%"
del /F "%logfile%"

REM
REM Change backslashes to forward slashes
REM
call :FixBackslashes "%tmpfile%" "%logfile%"
del /F "%tmpfile%"

echo Globalyzer Lite installation completed successfully
goto end

REM
REM Convert backslashes to front slash
REM
:FixBackslashes
setlocal DisableDelayedExpansion
set "search=\"
set "replace=/"
for /F "delims=" %%a in ('type %1') DO (
   set line=%%a
   setlocal EnableDelayedExpansion
   >> %2 echo(!line:%search%=%replace%!
   endlocal
)
goto :EOF

:end

