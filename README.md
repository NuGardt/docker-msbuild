# Microsoft .NET Build Tools as docker image
We created these images to deploy ASP.NET projects on docker.

## Microsoft .NET Build Tools 2013 (v12.0)
docker pull nugardt/msbuild:12.0

## Microsoft .NET Build Tools 2017 (v15.0)
docker pull nugardt/msbuild:15.0

## Microsoft .NET Build Tools 2017 (v15.5)
docker pull nugardt/msbuild:15.5

### All Build Tools docker images include:
NET Framework v4.5.2 Developer Pack  
NET Framework v4.6.2 Developer Pack   
Web Deploy v3.6  
NuGet v4.5.0

### Usage

Run from within you root source code directory (where your .SLN is).

```powershell
docker run -v "$(pwd):C:\Build\" nugardt/msbuild:15.5 msbuild C:\Build\NuGardt.Contoso.sln /t:rebuild /p:Configuration=Release /p:DeployOnBuild=true /p:PublishProfile=DockerDeploy
```
## MIT License

Copyright (c) 2018 NuGardt Software UG (haftungsbeschränkt)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
