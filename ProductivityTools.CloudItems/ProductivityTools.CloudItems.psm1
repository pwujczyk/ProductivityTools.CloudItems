function InitResources(){
		[cmdletbinding()]
	param(
		[string]$profile
	)
	Create-ResourceGroup -Profile $profile -Verbose 
	Create-StorageAccount -Profile $profile  -Verbose
	Create-StorageContainer -Profile $profile  -Verbose
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
		Compress-7Zip -Path $fileInfo.FullName -Password $password -ArchiveFileName $fileName -Verbose
	}
	else
	{
		Compress-7Zip -Path $fileInfo.FullName -ArchiveFileName $fileName -Verbose
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

function Push-ItemToTheCloud(){
	[cmdletbinding()]
	param(
		[string]$Profile,
		[string]$Path,
		[switch]$Compress,
		[switch]$UsePassword
	)
	
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
	Get-AzureBlobStorageFiles -Profile "$Profile"
}

function Remove-ItemFromTheCloud()
{
	[cmdletbinding()]
	param(
		[string]$Profile,
		[string]$Name
	)
	Remove-AzureBlobStorageFile -Profile $Profile -Name $Name
}

function Remove-AllItemsFromTheCloud()
{
	[cmdletbinding()]
	param(
		[string]$Profile
	)
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

