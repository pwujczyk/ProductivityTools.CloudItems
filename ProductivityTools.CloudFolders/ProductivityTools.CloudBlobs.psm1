function InitResources(){
	Create-ResourceGroup -Profile $profile -Verbose 
	Create-StorageAccount -Profile $profile  -Verbose
	Create-StorageContainer -Profile $profile  -Verbose
}

function ZipFile(){
	[cmdletbinding()]
	param(
		[System.IO.FileInfo]$fileInfo,
		[switch]$compress,
		[switch]$usePassword
	)

	if ($compress)
	{
		Write-Verbose $fileInfo.FullName
		$fileName=[System.IO.Path]::Combine($fileInfo.Directory.FullName,$fileInfo.BaseName+".zip")
		Compress-7Zip -Path $fileInfo.FullName -ArchiveFileName $fileName -Verbose
		return $fileName;
		#Compress-7Zip -Path $path -Password ryne22s5az25w*63sce -ArchiveFileName  $name  -EncryptFilenames -Verbose
	}
	else
	{
		
	}
	
	
}

function PushItem()
{
	[cmdletbinding()]
	param(
		[System.IO.FileInfo]$fileInfo,
		[switch]$compress,
		[switch]$usePassword
	)

	$path=$fileInfo.FullName;

	if($compress)
	{
		$zipPath=ZipFile -fileInfo $fileInfo -compress:$compress
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
	$url=PushItem -fileInfo $fileInfo -compress:$Compress
	Write-Host $url

}

Export-ModuleMember Push-FileToTheCloud

