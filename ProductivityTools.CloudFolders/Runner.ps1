clear
cd $PSScriptRoot
Import-Module .\ProductivityTools.CloudBlobs.psm1 -Force

#Push-FileToTheCloud -Profile "AzureCloudFoldersTest" -Path "checklist.jpg" -Compress
Push-FileToTheCloud -Profile "AzureCloudFoldersTest" -Path "checklist.jpg" -Compress -UsePassword