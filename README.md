<!--Category:PowerShell--> 
 <p align="right">
    <a href="https://www.powershellgallery.com/packages/ProductivityTools.CloudItems/"><img src="Images/Header/Powershell_border_40px.png" /></a>
    <a href="http://productivitytools.tech/cloud-blobs/"><img src="Images/Header/ProductivityTools_green_40px_2.png" /><a> 
    <a href="https://github.com/pwujczyk/ProductivityTools.CloudBlobs"><img src="Images/Header/Github_border_40px.png" /></a>
</p>
<p align="center">
    <a href="http://http://productivitytools.tech/">
        <img src="Images/Header/LogoTitle_green_500px.png" />
    </a>
</p>


# Cloud Items

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
    "Password":"Test123",
    "CdnHostname":"empty"
},
```

CdnHostname is not required, but module is based on the AzureAutomation which requires this value.

From this moment you coud use 

```powershell
Push-ItemToTheCloud -Profile "AzureCloudFoldersTest" -Path "d:\xxx.jpg" 
Push-ItemToTheCloud -Profile "AzureCloudFoldersTest" -Path "d:\xxx.jpg" -Compress
Push-ItemToTheCloud -Profile "AzureCloudFoldersTest" -Path "d:\xxx.jpg" -Compress -UsePassword 
Push-ItemToTheCloud -Profile "AzureCloudFoldersTest" -Path "d:\Directory" -Compress 
Push-ItemToTheCloud -Profile "AzureCloudFoldersTest" -Path "d:\Directory" -Compress -UsePassword 
```

If you will not provide Profile value default ProductivityTools.CloudItems.Default will be used. So if in the configuration you will name your variables ProductivityTools.CloudItems.Default you can use:

```powershell
Push-ItemToTheCloud -Path "d:\xxx.jpg" 
Push-ItemToTheCloud -Path "d:\xxx.jpg" -Compress
Push-ItemToTheCloud -Path "d:\xxx.jpg" -Compress -UsePassword 
Push-ItemToTheCloud -Path "d:\Directory" -Compress 
Push-ItemToTheCloud -Path "d:\Directory" -Compress -UsePassword 
```
![Example](Images/PushItemsExample.png)

Commans will result in:

<!--og-image-->
![Example](Images/ExampleResult.png)

To see all files on the storage you can use

```powershell
Get-ItemListFromTheCloud -Profile AzureCloudFoldersTest
```
![Example](Images/List.png)

When files are not needed you can remove it one by one or all at once.

```powershell
Remove-ItemFromTheCloud Directory.zip -Profile AzureCloudFoldersTest
Remove-AllItemsFromTheCloud -Profile AzureCloudFoldersTest

```