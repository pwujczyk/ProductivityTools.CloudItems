function InitResources(){
		[cmdletbinding()]
	param(
		[string]$profile
	)
	Create-ResourceGroup -Profile $profile  
	Create-StorageAccount -Profile $profile  
	Create-StorageContainer -Profile $profile  
}

function ZipFile(){
	[cmdletbinding()]
	param(
		[System.IO.FileSystemInfo]$fileInfo,
		[switch]$usePassword,
		[string]$profile
	)

	Write-Verbose $fileInfo.FullName
	$fileName=[System.IO.Path]::Combine($fileInfo.Directory.FullName,$fileInfo.BaseName+".zip")

	if ($usePassword)
	{
		$password = Get-MasterConfiguration $("$profile"+":Password")
		Write-Verbose "Password which will be used to zip files: $password"
		Compress-7Zip -Path $fileInfo.FullName -Password $password -ArchiveFileName $fileName 
	}
	else
	{
		Compress-7Zip -Path $fileInfo.FullName -ArchiveFileName $fileName 
	}
	return $fileName;
	
}

function PushItem()
{
	[cmdletbinding()]
	param(
		[System.IO.FileSystemInfo]$fileInfo,
		[switch]$compress,
		[switch]$usePassword,
		[string]$profile
	)

	$path=$fileInfo.FullName;

	if($compress -or $usePassword)
	{
		$zipPath=ZipFile -fileInfo $fileInfo -usePassword:$usePassword -profile $profile
		$path=$zipPath
	}
	
	$blob=Push-FileToAzureBlobStorage -Profile $profile -Path "$path"
	Write-Verbose "Item was pushed to the cloud"

	if($compress -or $usePassword)
	{
		Write-Verbose "Zip file will be removed now"
		Remove-Item -path $zipPath
	}

	$url=$blob.BlobClient.Uri.AbsoluteUri
	return $url
}

function GetProfile(){
	[cmdletbinding()]
	param(
		[string]$Profile
	)

	Write-Verbose "Passed profile $Profile"

	if ($Profile -eq $null -or $Profile -eq "")
	{
		$Profile="ProductivityTools.CloudItems.Default"
	}
	return $Profile
}

function Push-ItemToTheCloud(){
	[cmdletbinding()]
	param(
		[string]$Profile,
		[string]$Path,
		[switch]$Compress,
		[switch]$UsePassword
	)
	$Profile=GetProfile -Profile $Profile
	$fileInfo=Get-Item $Path
	 
	#InitResources $profile
	
	$url=PushItem -fileInfo $fileInfo -compress:$Compress -profile $Profile -usePassword:$UsePassword
	Write-Host $url
}

function Get-ItemListFromTheCloud()
{
	[cmdletbinding()]
	param(
		[string]$Profile
	)

	$Profile=GetProfile -Profile $Profile
	Get-AzureBlobStorageFiles -Profile "$Profile"
}

function Remove-ItemFromTheCloud()
{
	[cmdletbinding()]
	param(
		[string]$Profile,
		[string]$Name
	)
	$Profile=GetProfile -Profile $Profile
	Remove-AzureBlobStorageFile -Profile $Profile -Name $Name
}

function Remove-AllItemsFromTheCloud()
{
	[cmdletbinding()]
	param(
		[string]$Profile
	)
	$Profile=GetProfile -Profile $Profile
	$files=Get-AzureBlobStorageFiles -Profile "$Profile"
	foreach($file in $files)
	{
		$name=Split-Path $file -leaf
		Write-Output $name

		Remove-AzureBlobStorageFile -Profile $Profile -Name  $name -Force
	}
}

Export-ModuleMember Push-ItemToTheCloud
Export-ModuleMember Get-ItemListFromTheCloud
Export-ModuleMember Remove-ItemFromTheCloud
Export-ModuleMember Remove-AllItemsFromTheCloud

