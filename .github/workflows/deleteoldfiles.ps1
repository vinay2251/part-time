Param(
  $sourcepath,
  $oldfile,
  $serverName,
  $destinations
)

net use M: $serverName\D$ /p:no

$destinationlist = @()
$destinationlist = $destinations.Split(",")

foreach ($destination in $destinationlist) {
  $filesCount = ( Get-ChildItem "$destination" | Measure-Object ).Count;
  Write-Host "files count : $filesCount"
  Remove-Item -Path "$destination\$oldfile" -Verbose -Force
  Write-Host "$oldfile file deleted from $destination"
}

net use * /delete /y
