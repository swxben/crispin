@echo off
call "%VS100COMNTOOLS%vsvars32.bat"
mkdir log
mkdir lib\net40
mkdir nupkg_archive

msbuild.exe /ToolsVersion:4.0 "src\swxben.reporting\swxben.reporting.csproj" /p:configuration=Release
.nuget\nuget.exe pack swxben.fop.nuspec
.nuget\nuget.exe pack swxben.reporting.nuspec
.nuget\nuget.exe pack swxben.reporting.razor.nuspec

echo *** Ready to upload to nuget.org ***
pause

for %%f in (*.nupkg) do (
	.nuget\nuget.exe push %%f
)

copy *.nupkg nupkg_archive\
del *.nupkg

pause


