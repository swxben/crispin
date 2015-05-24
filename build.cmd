@echo off
if exist "%VS120COMNTOOLS%vsvars32.bat" call "%VS120COMNTOOLS%vsvars32.bat" & goto VARSSET
IF EXIST "%VS110COMNTOOLS%vsvars32.bat" call "%VS110COMNTOOLS%vsvars32.bat" & goto VARSSET
IF EXIST "%VS100COMNTOOLS%vsvars32.bat" call "%VS100COMNTOOLS%vsvars32.bat" & goto VARSSET
echo "Could not detect VS version!" & goto ERROR
:VARSSET

mkdir log
mkdir lib\net40
mkdir nupkg_archive

msbuild.exe "Crispin.sln" /p:configuration=Release
if %ERRORLEVEL% neq 0 goto ERROR

for %%f in (*.nuspec) do (
	.nuget\nuget.exe pack %%f
	if %ERRORLEVEL% neq 0 goto ERROR
)

echo *** Ready to upload to nuget.org ***
pause

for %%f in (*.nupkg) do (
	.nuget\nuget.exe push %%f
	if %ERRORLEVEL% neq 0 goto ERROR
)

copy *.nupkg nupkg_archive\
del *.nupkg

:ERROR

pause


