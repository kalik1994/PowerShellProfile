function processYtMovies
{
	$feedFolder = "D:\Global Cache\FromNetDownloadedUsingPluginForFirefox"
	$destFolder = "D:\MusicRepo\New"
	$videos = ls $feedFolder
	
	foreach ($video in $videos)
	{
		$fileNameHelper = $video -replace "- YouTube", ""
		$fileNameHelper2 = $fileNameHelper -replace " ", ""
		$fileNameHelper3 = $fileNameHelper2 -replace ".mkv", ""
		
		$filePath = "$feedFolder" + "\" + "$video"
		$fileNewName = "$fileNameHelper3" + ".mp3"
		$fileNewPath = "$destFolder" + "\" + "$fileNewName"
		
		write-host "Processing file [$video] : -newName [$fileNewName] -destinationPath [$destFolder] ."
		write-host "Invoking command: ffmpeg -i $filePath -acodec libmp3lame $fileNewPath.mp3"
		ffmpeg -i "$filePath" -acodec libmp3lame "$fileNewPath"
		
		$testCreate = test-path "$fileNewPath"
		
		if($testCreate)
		{
			write-host "File [$video] sucesfully processed. Deleting in progress..."
			remove-item "$filePath" -Force -Confirm:$False
			$testDelete = test-path "$filePath"
			if(!$testDelete)
			{
				write-host "File was deleted sucesfully."
			} else {
				write-host "There was problems with deleting file."
			}
		} else
		{
			write-host "There was some error during processing file [$video]."
			return 3
		}
	}
}

