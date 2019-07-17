# Description: Boxstarter Script
# Author: Microsoft
# Common settings for web development with NodeJS

Disable-UAC

# Get the base URI path from the ScriptToCall value
$bstrappackage = "-bootstrapPackage"
$helperUri = $Boxstarter['ScriptToCall']
$strpos = $helperUri.IndexOf($bstrappackage)
$helperUri = $helperUri.Substring($strpos + $bstrappackage.Length)
$helperUri = $helperUri.TrimStart("'", " ")
$helperUri = $helperUri.TrimEnd("'", " ")
$helperUri = $helperUri.Substring(0, $helperUri.LastIndexOf("/"))
$helperUri += "/scripts"
write-host "helper script base URI is $helperUri"

function executeScript {
    Param ([string]$script)
    write-host "executing $helperUri/$script ..."
	iex ((new-object net.webclient).DownloadString("$helperUri/$script"))
}

#--- Setting up Windows ---
# executeScript "SystemConfiguration.ps1";
# executeScript "FileExplorerSettings.ps1";
executeScript "RemoveDefaultApps.ps1";
# executeScript "CommonDevTools.ps1";
executeScript "WSL.ps1";
executeScript "Browsers.ps1";

#--- Tools ---
# code --install-extension msjsdiag.debugger-for-chrome
# code --install-extension msjsdiag.debugger-for-edge

#--- Tools ---
choco install -y adoptopenjdk --version 8.192
choco install -y awscli --version 1.16.198
choco install -y git --version 2.22.0# git found in common dev tools
choco install -y git-flow # branching methodology
choco install -y docker-cli --version 18.09.6
choco install -y docker-compose --version 1.24.0
choco install -y docker-machine --version 0.16.1
choco install -y helm --version 2.14.2
choco install -y kubernetes-cli --version 1.15.0
choco install -y minikube --version 1.2.0 
choco install -y maven --version 3.6.1
choco install -y nodejs-lts # Node.js LTS, Recommended for most users
choco install -y postman --version 7.2.2
choco install -y springtoolsuite --version 3.9.6
choco install -y vagrant --version 2.2.5
choco install -y virtualbox --version 6.0.10
choco install -y vscode --version 1.36.1

Enable-UAC
Enable-MicrosoftUpdate
Install-WindowsUpdate -acceptEula
