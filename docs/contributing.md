If you want to contribute to this project, start by forking the repo: <https://github.com/swxben/crispin>. Create an issue if applicable, create a branch in your fork, and create a pull request when it's ready.



## Building, running tests and the NuGet package

The VS2010 solution is in the root folder. Unit tests (coming up) can be run in a console using `tests.bat`. The NuGet package can be built by running `build-nuget-package.cmd`.

### Upgrading FOP, Batik and IKVM

[Apache FOP](http://xmlgraphics.apache.org/fop/) is used to convert XSL-FO into a PDF but it is written in Java, so [IKVM](http://www.ikvm.net) is used to convert FOP into a .NET assembly and to provide a Java runtime to FOP.

The IKVM dependency is managed via NuGet but the FOP assembly is created and upgraded manually. To upgrade FOP (including to support new versions of IKVM):

1. Download the latest or target version of IKVM from <http://www.ikvm.net> (you need a BIN release)
2. Download the latest binary release of Apache FOP from <http://xmlgraphics.apache.org/fop/>
3. Decompress both packages to the desktop
4. Open a console and cd to `%DESKTOP%\fop-x.xx\lib\`
5. Run: `..\..\<path to ikvm>\bin\ikvmc -out:fop-x.xx.dll *.jar ..\build\fop.jar`

A number of warnings and errors will come up, hopefully they can be ignored and the new `fop-x.xx.dll` file will be created in the current folder. Copy the DLL to the `swxben.reporting/lib` folder and update the FOP reference to the new assembly. Note that the IKVM version used to create the FOP assembly needs to match the IKVM version used by `swxben.reporting`.
