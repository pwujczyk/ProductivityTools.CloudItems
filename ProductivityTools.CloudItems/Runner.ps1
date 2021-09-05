clear
cd $PSScriptRoot
Import-Module .\ProductivityTools.CloudItems.psm1 -Force

#Push-FileToTheCloud -Profile "AzureCloudFoldersTest" -Path "checklist.jpg" -Compress
#Push-FileToTheCloud -Profile "AzureCloudFoldersTest" -Path "checklist.jpg" -Compress -UsePassword
#Push-ItemToTheCloud -Profile "AzureCloudFoldersTest" -Path "d:\Directory.jpg" -Compress -UsePassword -Verbose
#Push-ItemToTheCloud -Profile "AzureCloudFoldersTest" -Path "d:\xxx.jpg" 
Push-ItemToTheCloud -Path "d:\xxx.jpg" 
#GGet-ItemListFromTheCloud -Profile "AzureCloudFoldersTest"
#Remove-FileFromTheCloud -Profile "AzureCloudFoldersTest" -Name "xxx.zip"
#Remove-AllFilesFromTheCloud -Profile "AzureCloudFoldersTest" 