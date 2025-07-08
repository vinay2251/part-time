Param(
  $oldfile,
  $serverName,
  $destinations
)

net use M: $serverName\D$ /p:no

$destinationlist = @()
$destinationlist = $destinations.Split(",")

try {
    foreach ($destination in $destinationlist) {
      $status = Test-Path "$destination\$oldfile"
      if ("$status" -eq "False") {
      throw "Given $oldfile file not existed in $destination"
      }
    }
  }
catch {
    Write-Host -f Red "ERROR : $_"
    net use * /delete /y
    exit 1
}

net use * /delete /y
