function InitResources(){
	Create-ResourceGroup -Profile $profile -Verbose 
	Create-StorageAccount -Profile $profile  -Verbose
	Create-StorageContainer -Profile $profile  -Verbose
}

function PushItem()
{
	[cmdletbinding()]
	param(
		[string]$path,
		[switch]$usePassword
	)

	if($usePassword)
	{
		
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
		[string]$profile,
		[string]$Path,
		[string]$UsePassword
	)
	
	InitResources $profile
	$url=PushItem -path $Path
	Write-Host $url

}
Export-ModuleMember Push-FileToTheCloud

