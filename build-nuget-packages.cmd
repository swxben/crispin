@echo off
echo *** Make sure you have updated the assembly and nuspec to match the release version! ***
pause

call "%VS100COMNTOOLS%vsvars32.bat"
mkdir log\
mkdir lib\net40\

msbuild.exe /ToolsVersion:4.0 "src\swxben.reporting\swxben.reporting.csproj" /p:configuration=Release
utilities\nuget.exe pack swxben.fop.nuspec
utilities\nuget.exe pack swxben.reporting.nuspec
utilities\nuget.exe pack swxben.reporting.razor.nuspec
pause