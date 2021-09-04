<!--Category:PowerShell--> 
 <p align="right">
    <a href="https://www.powershellgallery.com/packages/ProductivityTools.CloudItems/"><img src="Images/Header/Powershell_border_40px.png" /></a>
    <a href="http://productivitytools.tech/get-onedrivedirectory/"><img src="Images/Header/ProductivityTools_green_40px_2.png" /><a> 
    <a href="https://github.com/pwujczyk/ProductivityTools.CloudBlobs"><img src="Images/Header/Github_border_40px.png" /></a>
</p>
<p align="center">
    <a href="http://http://productivitytools.tech/">
        <img src="Images/Header/LogoTitle_green_500px.png" />
    </a>
</p>


# Cloud blobs

Module helps to push files and directories to the azure blob storage.
<!--more-->

I often have a need to send file to someone. I decided to use Azure as exchange platform. Tool of course need to again be convienient to use.

Module is based on the [Master Configuration](https://github.com/pwujczyk/ProductivityTools.MasterConfiguration.Cmdlet) which should contain configuration for the azure blob storage.

To use it in the master configuration file add:

```json
  
"AzureCloudFoldersTest":{
    "Location":"westeurope",
	"ResourceGroup":"cloudfolder1",
	"StorageName":"cloudfolder1",
	"SkuName":"Standard_RAGRS",
	"StorageContainerName":"files",
	"Password":"Test123"
},
```
From this moment you coud use 

```powershell
Push-FileToTheCloud -Profile "AzureCloudFoldersTest" -Path "d:\xxx.jpg" 
Push-FileToTheCloud -Profile "AzureCloudFoldersTest" -Path "d:\xxx.jpg" -Compress
Push-ItemToTheCloud -Profile "AzureCloudFoldersTest" -Path "d:\xxx.jpg" -Compress -UsePassword 
Push-ItemToTheCloud -Profile "AzureCloudFoldersTest" -Path "d:\Directory" -Compress 
Push-ItemToTheCloud -Profile "AzureCloudFoldersTest" -Path "d:\Directory" -Compress -UsePassword 
```

