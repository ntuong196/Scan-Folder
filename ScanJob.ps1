cd C:\C@d3\ScanFolder
#Get current .net version used
$PSVersionTable.CLRVersion

#Define var
$CurrentDir = $(get-location).Path
$AlphaFSPath = $CurrentDir + "\AlphaFS.2.2.6.0\Lib\Net40\AlphaFS.dll"
Import-Module -Name $AlphaFSPath
$testFolder = $CurrentDir + "\TestFol"
$scanFolder = "\\pbnenas01\Software"

#Load the Function
. .\Get-AlphaFSChildItem.ps1

#Check if the func is available
#ls function: | where { $_.Name -eq "Get-AlphaFSChildItem" }

#Scan the test folder
Get-ChildItem -Path $testFolder -recurse -Exclude Windows -Directory 

#Scan the test folder with long name
$dirs = [Alphaleonis.Win32.Filesystem.Directory]::EnumerateFileSystemEntries($testFolder, '*', [System.IO.SearchOption]::AllDirectories) 

| select-object FullName, LastWriteTime | export-csv -notypeinformation -delimiter '|' -path "$CurrentDir\output.csv"

ForEach ($dir in $dirs) {
      
}


#Get-ChildItem -Path $testFolder | Select-Object FullName

$dirs = Get-Childitem -Path $testFolder -Exclude Windows -Directory



ForEach ($dir in $dirs) {
    $newDir = "$dir\Documents\CIP\"
    $testPath = Test-Path -Path $newDir
        If ($testPath -eq $True) {
            Remove-Item -Path $newDir -Include st_* -Exclude STAC,upload -Recurse -Force -Verbose
        }
}

write-host dirs
Get-AlphaFSChildItem -path $testFolder -recurse | select-object FileName, FullPath, Fullsize, CreationTime, LastWriteTime | export-csv -notypeinformation -delimiter '|' -path "$CurrentDir\output.csv"

$scriptpath = $MyInvocation.MyCommand.Path
$dir = Split-Path $scriptpath
Write-host "My directory is $dir"

write-host $PSScriptRoot