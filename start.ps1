$serviceName = ""
$vmName = ""
$puttyPath = ""
$puttySession = ""
$username = ""

# select azure subscription
Get-AzureSubscription | Select SubscriptionID | Select-AzureSubscription

# check vm status
$state = (Get-AzureVM -ServiceName $serviceName -Name $vmName).PowerState

# start if not on
if ($state -ne "Started") {
    Get-AzureVM -ServiceName $serviceName -Name $vmName | Start-AzureVM
}

# wait until running
do {
    $state = (Get-AzureVM -ServiceName $serviceName -Name $vmName).PowerState
    Start-Sleep -s 1
} 
until ($state -eq "Started")

# start PuTTY
$putty = Start-Process -FilePath $puttyPath -ArgumentList "-load $puttySession -l $username"