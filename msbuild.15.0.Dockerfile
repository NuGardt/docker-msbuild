FROM microsoft/windowsservercore:10.0.14393.2007
SHELL ["powershell.exe", "-ExecutionPolicy", "Bypass", "-Command"]

LABEL maintainer "kevin@nugardt.com"; \
LABEL lastupdate "2018-02-05"; \
LABEL version "2018.02.05"; \
LABEL author "Kevin Gardthausen"; \
LABEL vendor "NuGardt Software UG (haftungsbeschränkt)"; \
LABEL homepage "http://www.nugardt.com;" \
LABEL description "Microsoft .NET Build Tools 2017 (v15.0) with NuGet v4.5.0, Web Deploy v3.5, Developer Packs v4.5.2, 4.6.2 and .Net Core v1.1.7 and v2.1.4 SDK."; \
LABEL license MIT license; \
LABEL comment based on alexellisio/msbuild:12.0 and https://blogs.msdn.microsoft.com/heaths/2017/09/18/installing-build-tools-for-visual-studio-2017-in-a-docker-container/;

# Download log collection utility
RUN $ErrorActionPreference = 'Stop'; \
	$ProgressPreference = 'SilentlyContinue'; \
	$VerbosePreference = 'Continue'; \
	Invoke-WebRequest -Uri https://aka.ms/vscollect.exe -OutFile C:\collect.exe

# Download NuGardt v4.5.0
RUN $ErrorActionPreference = 'Stop'; \
	$ProgressPreference = 'SilentlyContinue'; \
	$VerbosePreference = 'Continue'; \
	New-Item -Path C:\nuget -Type Directory | Out-Null; \
	[System.Environment]::SetEnvironmentVariable('PATH', "\"${env:PATH};C:\nuget\"", 'Machine'); \
	Invoke-WebRequest -Uri "https://dist.nuget.org/win-x86-commandline/v4.5.0/nuget.exe" -OutFile C:\nuget\nuget.exe; 

# Download and install .Net 4.5.2 Developer Pack
RUN $ErrorActionPreference = 'Stop'; \
	$ProgressPreference = 'SilentlyContinue'; \
	$VerbosePreference = 'Continue'; \
	Invoke-WebRequest "https://download.microsoft.com/download/4/3/B/43B61315-B2CE-4F5B-9E32-34CCA07B2F0E/NDP452-KB2901951-x86-x64-DevPack.exe" -OutFile "$env:TEMP\NDP452-KB2901951-x86-x64-DevPack.exe" -UseBasicParsing; \
	$p = Start-Process -Wait -PassThru -FilePath "$env:TEMP\NDP452-KB2901951-x86-x64-DevPack.exe" -ArgumentList "/install","/quiet"; \
	rm "$env:TEMP\NDP452-KB2901951-x86-x64-DevPack.exe"

# Download and install .Net 4.6.2 Developer Pack
RUN $ErrorActionPreference = 'Stop'; \
	$ProgressPreference = 'SilentlyContinue'; \
	$VerbosePreference = 'Continue'; \
	Invoke-WebRequest "https://download.microsoft.com/download/E/F/D/EFD52638-B804-4865-BB57-47F4B9C80269/NDP462-DevPack-KB3151934-ENU.exe" -OutFile "$env:TEMP\NDP462-DevPack-KB3151934-ENU.exe" -UseBasicParsing; \
	$p = Start-Process -Wait -PassThru -FilePath "$env:TEMP\NDP462-DevPack-KB3151934-ENU.exe" -ArgumentList "/install","/quiet"; \
	if ($ret = $p.ExitCode) { c:\collect.exe; throw ('Install failed with exit code 0x{0:x}' -f $ret) }; \
	rm "$env:TEMP\NDP462-DevPack-KB3151934-ENU.exe"

# Download and install Web Deploy v3.6
RUN $ErrorActionPreference = 'Stop'; \
	$ProgressPreference = 'SilentlyContinue'; \
	$VerbosePreference = 'Continue'; \
	Invoke-WebRequest "https://download.microsoft.com/download/0/1/D/01DC28EA-638C-4A22-A57B-4CEF97755C6C/WebDeploy_amd64_en-US.msi" -OutFile "$env:TEMP\WebDeploy_amd64_en-US.msi" -UseBasicParsing; \
	$p = Start-Process -Wait -PassThru -FilePath "msiexec" -ArgumentList """/i ""$env:TEMP\WebDeploy_amd64_en-US.msi"" /quiet"""; \
	if ($ret = $p.ExitCode) { c:\collect.exe; throw ('Install failed with exit code 0x{0:x}' -f $ret) }; \
	rm "$env:TEMP\WebDeploy_amd64_en-US.msi"

# Download and install .Net Core v1.1.7 SDK
RUN $ErrorActionPreference = 'Stop'; \
	$ProgressPreference = 'SilentlyContinue'; \
	$VerbosePreference = 'Continue'; \
	Invoke-WebRequest "https://download.microsoft.com/download/4/E/6/4E64A465-F02E-43AD-9A86-A08A223A82C3/dotnet-dev-win-x64.1.1.7.exe" -OutFile "$env:TEMP\dotnet-dev-win-x64.1.1.7.exe" -UseBasicParsing; \
	$p = Start-Process -Wait -PassThru -FilePath "$env:TEMP\dotnet-dev-win-x64.1.1.7.exe" -ArgumentList "/install","/quiet"; \
	if ($ret = $p.ExitCode) { c:\collect.exe; throw ('Install failed with exit code 0x{0:x}' -f $ret) }; \
	rm "$env:TEMP\dotnet-dev-win-x64.1.1.7.exe"

# Download and install .Net Core v2.1.4 SDK
RUN $ErrorActionPreference = 'Stop'; \
	$ProgressPreference = 'SilentlyContinue'; \
	$VerbosePreference = 'Continue'; \
	Invoke-WebRequest "https://download.microsoft.com/download/1/1/5/115B762D-2B41-4AF3-9A63-92D9680B9409/dotnet-sdk-2.1.4-win-x64.exe" -OutFile "$env:TEMP\dotnet-sdk-2.1.4-win-x64.exe" -UseBasicParsing; \
	$p = Start-Process -Wait -PassThru -FilePath "$env:TEMP\dotnet-sdk-2.1.4-win-x64.exe" -ArgumentList "/install","/quiet"; \
	if ($ret = $p.ExitCode) { c:\collect.exe; throw ('Install failed with exit code 0x{0:x}' -f $ret) }; \
	rm "$env:TEMP\dotnet-sdk-2.1.4-win-x64.exe"

# Download and install Microsoft Build Tools 15
RUN $ErrorActionPreference = 'Stop'; \
	$ProgressPreference = 'SilentlyContinue'; \
	$VerbosePreference = 'Continue'; \
	Invoke-WebRequest -Uri "https://download.microsoft.com/download/3/A/B/3ABDE7FA-A349-4AF0-A3AC-0D7BB0977A32/vs_BuildTools.exe" -OutFile $env:TEMP\vs_buildtools.exe; \
	$p = Start-Process -Wait -PassThru -FilePath $env:TEMP\vs_buildtools.exe -ArgumentList '--add Microsoft.VisualStudio.Workload.MSBuildTools --add Microsoft.VisualStudio.Workload.NetCoreBuildTools --add Microsoft.VisualStudio.Workload.VCTools --add Microsoft.VisualStudio.Workload.WebBuildTools --quiet --nocache --wait --installPath C:\BuildTools'; \
	if ($ret = $p.ExitCode) { c:\collect.exe; throw ('Install failed with exit code 0x{0:x}' -f $ret) }; \
	rm "$env:TEMP\vs_buildtools.exe"

# Use shell form to start developer command prompt and any other commands specified
SHELL ["cmd.exe", "/s", "/c"]
ENTRYPOINT C:\BuildTools\Common7\Tools\VsDevCmd.bat &&

# Default to PowerShell console running within developer command prompt environment
CMD ["powershell.exe", "-nologo"]