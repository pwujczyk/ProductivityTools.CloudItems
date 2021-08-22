clear
cd $PSScriptRoot
Import-Module .\ProductivityTools.CloudFolders.psm1 -Force

Push-FileToTheCloud -Profile "AzureCloudFoldersTest" -Path "checklist.jpg"