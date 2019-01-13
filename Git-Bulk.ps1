<#
.SYNOPSIS
    This script runs defined command in a defined parent directory of multiple git repositories recursively.
.DESCRIPTION
    The user can either apply selected git command in present working directory, or can provide a custom path for running git command.
.PARAMETER -tragetpath 
	The path of selected parent directory, otherwise it is the current working directory
.PARAMETER -command 
	Sepcifies the git command the user is about to run for each target repository. 
#>

param
(
	[String]$targetpath=$pwd,
	[String]$command=""
)

	[String]$gitfolder="\.git"

# Get all directories and hidden directories recursively within the given directory
# If the current folder contains the .git folder, then it is a git repository
# If we are in a git repository, we should run the given command
Get-ChildItem -Recurse -Attributes Directory,Directory+Hidden -Path $targetpath | % {
	[String]$fullFolderName = $_.FullName
	[String]$fullGitFolderPath = "$fullFolderName$gitfolder"
	if (Test-Path($fullGitFolderPath))
	{
		if ($command -ne "")
		{
			Invoke-Expression($command)
		}
		else 
		{
			Write-Host("No command provided to run in {0}" -f $fullFolderName) -ForegroundColor Magenta 
		}
	}
}
