Param(
  $sourcepath,
  $newfile,
  $serverName,
  $destinations
)

net use M: $serverName\D$ /p:no

$destinationlist = @()
$destinationlist = $destinations.Split(",")

foreach ($destination in $destinationlist) {
  Copy-Item -Path "$sourcepath\$newfile" -Destination "$destination" -Force -Passthru -Verbose -Recurse
  Write-Host "$newfile file copied to $destination"
  $filesCount = ( Get-ChildItem "$destination" | Measure-Object ).Count;
  Write-Host "files count : $filesCount"
}

net use * /delete /y