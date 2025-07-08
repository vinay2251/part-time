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
  Remove-Item -Path "$destination\$oldfile" -Verbose -Force
  Write-Host "$oldfile file deleted from $destination"
}

#$fileExtension = [System.IO.Path]::GetExtension("$oldfile")
foreach ($destination in $destinationlist) {
  Copy-Item -Path "$sourcepath\$oldfile" -Destination "$destination" -Force -Passthru -Verbose -Recurse
  Write-Host "$oldfile file copied to $destination"
}

net use * /delete /y