ni#Get current .net version used
$PSVersionTable.CLRVersion

#Define var
cd $PSScriptRoot
$AlphaFSPath = $PSScriptRoot + "\AlphaFS.2.2.6.0\Lib\Net40\AlphaFS.dll"
Import-Module -Name $AlphaFSPath

$testFolder = $PSScriptRoot + "\TestFolder"

#Load the Folder need to be scaned from param
$scanFolder = $args[0]
if ($null -eq $scanFolder){
    $scanFolder = read-host -Prompt "Please enter Directory need to be scaned"
    if (0 -eq $scanFolder.Length){
        $scanFolder = $testFolder
    }
}


#Load the Function
. .\Get-AlphaFSChildItem.ps1

Try {
        Write-Host "Scan $scanFolder STARTED" -foregroundcolor Green
	    Get-AlphaFSChildItem -path $scanFolder -recurse | select-object FileName, FullPath, Filesize, CreationTime, LastWriteTime | export-csv -notypeinformation -delimiter '|' -path "$PSScriptRoot\output.csv"
        Write-Host "Scan $scanFolder COMPLETED and EXPORTED!" -foregroundcolor Yellow
	}
Catch [System.UnauthorizedAccessException] {
        #Report exception.
        Write-Host "Scan $scanFolder FAILED" -foregroundcolor Red
	}