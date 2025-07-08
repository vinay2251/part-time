Param(
    $serverName,
	$serviceslist,
    $activity
  )

$servicelist = @()
$servicelist = $serviceslist.Split(",")
$servicelist = $servicelist | ForEach-Object { $_.Trim() }
$servicelist = $servicelist | ForEach-Object { """$_""" }

if ($activity -eq "stop") {
	foreach ($service in $servicelist) {
	  Write-Host "Stopping  $service"
	  Start-Process -FilePath psexec -ArgumentList "$serverName net stop $service" -Wait
	  Write-Host "Service has been stopped : ${service}"
	}
	Start-Sleep -Seconds 30
}
elseif ($activity -eq "start") {
	foreach ($service in $servicelist) {
	  Start-Process -FilePath psexec -ArgumentList "$serverName net start $service" -Wait
	  Write-Host "Restarted Service : ${service}"
	}
}
else {
	Write-Host "Please provide the valid activity"
}
