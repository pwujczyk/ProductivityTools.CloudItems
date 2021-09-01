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
		[System.IO.FileInfo]$fileInfo,
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
		[System.IO.FileInfo]$fileInfo,
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
	$url=$blob.BlobClient.Uri.AbsoluteUri
	return $url
}

function PushFolderToTheCloud()
{

}

function Push-FileToTheCloud(){
	[cmdletbinding()]
	param(
		[string]$Profile,
		[string]$Path,
		[switch]$Compress,
		[switch]$UsePassword
	)
	
	$fileInfo=$(Get-ChildItem $Path)[0]
	 
	#InitResources $profile
	
	$url=PushItem -fileInfo $fileInfo -compress:$Compress -profile $Profile -usePassword:$UsePassword
	Write-Host $url

}

Export-ModuleMember Push-FileToTheCloud

