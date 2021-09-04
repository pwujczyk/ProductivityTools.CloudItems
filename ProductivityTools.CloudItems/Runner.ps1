clear
cd $PSScriptRoot
Import-Module .\ProductivityTools.CloudItems.psm1 -Force

#Push-FileToTheCloud -Profile "AzureCloudFoldersTest" -Path "checklist.jpg" -Compress
#Push-FileToTheCloud -Profile "AzureCloudFoldersTest" -Path "checklist.jpg" -Compress -UsePassword
#Push-ItemToTheCloud -Profile "AzureCloudFoldersTest" -Path "d:\xxx.jpg" -Compress -UsePassword -Verbose
Push-ItemToTheCloud -Profile "AzureCloudFoldersTest" -Path "d:\xxx.jpg" 
#Get-FileListFromTheCloud -Profile "AzureCloudFoldersTest"
#Remove-FileFromTheCloud -Profile "AzureCloudFoldersTest" -Name "xxx.zip"
#Remove-AllFilesFromTheCloud -Profile "AzureCloudFoldersTest" 