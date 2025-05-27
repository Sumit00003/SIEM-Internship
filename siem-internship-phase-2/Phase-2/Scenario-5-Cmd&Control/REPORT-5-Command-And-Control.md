

# Detection Usecase 5 : Command & Control (C2) Beaconing Behavior


# Scenario Summary: 
Monitoring the system for command and control server which recursivly sending http request to a rare domain.

# Attack Steps:

- The Attack was simulated by Windows itself as follows:  
1) A script was running on windows which sends http requests to an ip in every 20s.  
```
- powershell
while ($true){
    curl 10.10.17.252:8080
    Start-Sleep -Seconds 20
}
``` 

Tools Used:  
-Attacker Tool : Powershell Script
-SIEM : Splunk Free  
-Log Source : Windows Security Event Logs, Sysmon, Wireshark


# Event ID / Data Source Mapping:

| Source                    | EventCode | Description                                            |
|---------------------------|-----------|--------------------------------------------------------|
| WinEventLog : Sysmon      | 3         | Network Connection Detected                            |
| WinEventLog : Security    | 5156      | Windows Filtering platform has permitted a Connection  |


# Detection Query / Logic:
```spl 
- Search
index=* 192.168.0.104  | stats  count by _time, Source_Address, Destination_Addres
```
```spl 
- Frequency-based correlation
index=* 192.168.0.104
| bin _time span=20s
| stats count by Source_Address, Destination_Address, _time
| where count >=1
| eventstats count as freq by Destination_Address
| where freq > 3
```


# Sample Alert Screenshot

1) Connection Attempt  
![1](<screenshots/Screenshot 2025-05-25 153255.png>)  
![2](<screenshots/Screenshot 2025-05-25 153315.png>)  

2) Logs

![3](<logs/Screenshot 2025-05-25 111931.png>)  
![4](<logs/Screenshot 2025-05-25 112651.png>)  
![5](<logs/Screenshot 2025-05-25 113029.png>)


# Analyst Notes / Recommendations:

1) What Should an Analyst do ? 

-> Investigate the Events Properly - Check the rare domain is in the whitelist or not.    
-> If Suspicious - Isolate the System affected, Closed the ports and Services accessed by the external domain, Block the External Domain.    
-> Investigation - What files are accessed or modify, Check for Malware or Scripts.  
-> Eradiction - Remove if there is malware or automated scripts in system, Patch Vulnerability.  
-> Document & Report the Incident.


# Detection Status

 -> Successfully Detected.  

