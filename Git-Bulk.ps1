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
	[String]$command="",
	[Bool]$verbose=$true,
	[Bool]$forcedexecution=$false
)

[String]$gitfolder="\.git"

# Function to log message in case verbose mode has been set to $true
# Operates with three arguments at most
# $args[0] - the format string, the message that contains 2 placeholders at most
# $args[1] - the value of the first placeholder
# $args[2] - the value of the second placeholder
function Write-Host-If-Verbose
{
	If($verbose -eq $true)
	{
		Write-Host($args[0] -f $args[1], $args[2]) -ForegroundColor Cyan
	}
}

# Get all directories and hidden directories recursively within the given directory
Get-ChildItem -Recurse -Attributes Directory,Directory+Hidden -Path $targetpath | % {
	[String]$fullFolderName = $_.FullName
	[String]$fullGitFolderPath = "$fullFolderName$gitfolder"
	
	# If the current folder contains the .git folder, then it is a git repository
	If (Test-Path($fullGitFolderPath))
	{
		# If we are in a git repository, and we've got a command available we should run the given command
		If ($command -ne "")
		{
			#Save current path
			Push-Location $targetpath

			#Change location to the git repositories folder
			Set-Location -Path $fullFolderName

			#If forced execution has been set, run command
			If($forcedexecution -eq $true)
			{
				#If verbose mode have been set, log info
				Write-Host-If-Verbose "Running command ({0}) in {1}" $command $fullFolderName
				Invoke-Expression($command)
			}
			#If forced execution hasn't been set, ask user if he/she wants to run the command for the current repository
			Else
			{
				[Bool]$isValidInput = $false
				While (-Not $isValidInput)
				{
					[String]$runCommand = Read-Host -Prompt "Would you like to run command ($command) on $fullFolderName repository? (Yes (y), No (n), Cancel (c))"
					If ($runCOmmand.ToLower() -eq "y")
					{
						#If verbose mode have been set, log info
						$isValidInput = $true
						Write-Host-If-Verbose "Running command ({0}) in {1}" $command $fullFolderName
						Invoke-Expression($command)
					}
					ElseIf ($runCOmmand.ToLower() -eq "n")
					{
						#If verbose mode have been set, log info
						$isValidInput = $true
						Write-Host-If-Verbose "Skipping the running of command ({0}) in {1}" $command $fullFolderName
					}
					ElseIf ($runCOmmand.ToLower() -eq "c")
					{
						#If verbose mode have been set, log info
						$isValidInput = $true
						Write-Host-If-Verbose "Cancel running command ({0}) on repositories of following directory: {1}" $command $targetpath 
						Pop-Location
						Exit
					}
					Else
					{
						#Invalid input, user should try again
						Write-Host("Invalid input({0})! Please choose a valid option." -f $runCOmmand) -ForegroundColor Yellow 
					}
				}
			}
			#Get back to the original location
			Pop-Location
		}
		Else
		{
			Write-Host("No command provided to run in {0}" -f $fullFolderName) -ForegroundColor Magenta 
		}
	}
}
