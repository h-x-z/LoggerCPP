:: Copyright(c) 2020-present, Muhammad Usman. (https://github.com/Hazeral)
:: Distributed under the MIT License (http://opensource.org/licenses/MIT)
@echo off
set start=%time%

if not exist "bin\test_dll" mkdir "bin\test_dll"
if not exist "bin\dll\Logger.dll" echo DLL not found, run build_dll.bat& exit

echo Compiling test unit and linking dll
g++ -o bin\test_dll\Test test\Test.cpp -L.\bin\dll\ -lLogger

echo Copying dll to test unit location
copy ".\bin\dll\Logger.dll" "bin\test_dll" >nul

:: TIME MEASUREMENT
set end=%time%
set options="tokens=1-4 delims=:.,"
for /f %options% %%a in ("%start%") do set start_h=%%a&set /a start_m=100%%b %% 100&set /a start_s=100%%c %% 100&set /a start_ms=100%%d %% 100
for /f %options% %%a in ("%end%") do set end_h=%%a&set /a end_m=100%%b %% 100&set /a end_s=100%%c %% 100&set /a end_ms=100%%d %% 100

set /a hours=%end_h%-%start_h%
set /a mins=%end_m%-%start_m%
set /a secs=%end_s%-%start_s%
set /a ms=%end_ms%-%start_ms%
if %ms% lss 0 set /a secs = %secs% - 1 & set /a ms = 100%ms%
if %secs% lss 0 set /a mins = %mins% - 1 & set /a secs = 60%secs%
if %mins% lss 0 set /a hours = %hours% - 1 & set /a mins = 60%mins%
if %hours% lss 0 set /a hours = 24%hours%
if 1%ms% lss 100 set ms=0%ms%
set /a totalsecs = %hours%*3600 + %mins%*60 + %secs%
:: ----------------

echo Finished compiling in %totalsecs%.%ms% seconds
echo Running unit tests
echo ------------------

cd bin\test_dll
.\Test.exe