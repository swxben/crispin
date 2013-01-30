@echo off
call "%VS100COMNTOOLS%vsvars32.bat"
mkdir log
mkdir lib\net40
mkdir nupkg_archive

msbuild.exe /ToolsVersion:4.0 "reporting.sln" /p:configuration=Release
for %%f in (*.nuspec) do (
	.nuget\nuget.exe pack %%f
)

echo *** Ready to upload to nuget.org ***
pause

for %%f in (*.nupkg) do (
	.nuget\nuget.exe push %%f
)

copy *.nupkg nupkg_archive\
del *.nupkg

pause


