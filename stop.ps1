$serviceName = ""
$vmName = ""

# close PuTTY
$putty = Get-Process -Name "putty" -ErrorAction SilentlyContinue
if ($putty) {
    Stop-Process $putty
}

# select azure subscription
Get-AzureSubscription | Select SubscriptionID | Select-AzureSubscription

# check vm status
$state = (Get-AzureVM -ServiceName $serviceName -Name $vmName).PowerState

# stop if not off
if ($state -ne "Stopped") {
    Get-AzureVM -ServiceName $serviceName -Name $vmName | Stop-AzureVM -StayProvisioned
}

# wait until shutdown
do {
    $state = (Get-AzureVM -ServiceName $serviceName -Name $vmName).PowerState
    Start-Sleep -s 1
} 
until ($state -eq "Stopped")