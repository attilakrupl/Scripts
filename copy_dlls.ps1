<#
.SYNOPSIS
    This script copies given dlls to given output directory as a postbuild script of the current VS project. The script can be configured from VS project. The script searches for the desired dlls recursively in the directory provided by the user.
.DESCRIPTION
    The user can provide build configuration (release/debug) and platform (x86/x64).
.PARAMETER -configuration 
    The build configuration of the current build.
.PARAMETER -platform
    The platform setting of the current build.
.PARAMETER -searchdir
    The parent directory for the recursive dll search.
.PARAMETER -destinationdir
    The destination directory of the dlls.
.NOTES
    Version:        1.0
    Author:         Attila Krüpl dr.
    Creation Date:  03-12-2019
    Purpose/Change: Initial script development
#>

param
(
    [String]$configuration="release",
    [String]$platform="x64",
    [String]$searchdir=$pwd,
	[String]$destinationdir="$pwd\..\"
)

$kSDL2Dlls = @("libfreetype-6.dll","libjpeg-9.dll","libpng16-16.dll","libtiff-5.dll","libwebp-7.dll","SDL2.dll","SDL2_image.dll","SDL2_ttf.dll","zlib1.dll")

$lDllsToCopy = @()

for ($i = 0; $i -lt $kSDL2Dlls.Count; $i++)
{
	$lCurrentDll   = $kSDL2Dlls[$i]
	$lArrayOfPaths = Get-ChildItem -recurse -filter $lCurrentDll | % { $_.FullName }
	
	for ($j = 0; $j -lt $lArrayOfPaths.Count; $j++)
	{ 
		$lArrayOfPathElements = $lArrayOfPaths[$j].split('\')
		if ( ( $lArrayOfPathElements -Contains $configuration ) -and ( $lArrayOfPathElements -Contains $platform ) )
		{
			Write-Host "Copying" $lArrayOfPaths[$j] "to $destinationdir"
			Copy-Item -Path $lArrayOfPaths[$j] -Destination $destinationdir
		}
	}
}