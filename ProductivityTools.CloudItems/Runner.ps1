clear
cd $PSScriptRoot
Import-Module .\ProductivityTools.CloudItems.psm1 -Force
#Push-ItemToTheCloud -Profile AzureCloudGosia -Path c:\Users\pwujczyk\Downloads\wyniki_badań_20211008144600.zip
#Get-ItemListFromTheCloud
#Push-FileToTheCloud -Profile "AzureCloudFoldersTest" -Path "checklist.jpg" -Compress
#Push-FileToTheCloud -Profile "AzureCloudFoldersTest" -Path "checklist.jpg" -Compress -UsePassword
#Push-ItemToTheCloud -Profile "AzureCloudFoldersTest" -Path "d:\Directory.jpg" -Compress -UsePassword -Verbose
#Push-ItemToTheCloud -Profile "AzureCloudFoldersTest" -Path "d:\xxx.jpg" 
#Push-ItemToTheCloud -Path "d:\xxx.jpg" 
#GGet-ItemListFromTheCloud -Profile "AzureCloudFoldersTest"
#Remove-FileFromTheCloud -Profile "AzureCloudFoldersTest" -Name "xxx.zip"
#Remove-AllFilesFromTheCloud -Profile "AzureCloudFoldersTest" 
Remove-AllItemsFromTheCloud  -Profile Gosia -Verbose