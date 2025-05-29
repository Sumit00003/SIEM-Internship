

# Detection Usecase 2 : Lateral Movement using crackmapexec


# Scenario Summary: 

Attacker or Malicious Person attempts to scan the network with valid username and password. After finding valid IP attacker tried to access the shares via SMB and downloaded the file which contain critical passwords.

# Attack Steps:

Here, Virtual Windows 11 is the victim where universal forwarder is running,  
and Virtual Kali Linux is the attacker.  
- The Attack was simulated by Kali Linux on Windows as follows:  

1) Attacker used crackmapexec to Scan the Network of victim Machine with valid credentials:   
```
crackmapexec smb 192.168.0.0/24 -u sshuser -p  'pass'
```  
2) After finding the valid Machine for the provided credentials, used smbclient to check for Sharing Directory.  
```
smbclient -L //192.168.0.101
```  
3) Trying to see sharing direcctory Named 'Secret' and downloading critical files from it:  
```
smbclient //192.168.0.101 -U sshuser
get password.txt
```

- Tools Used:  
    - Attacker Tool : crackmapexec, smbclient.  
    - SIEM : Splunk Free  
    - Log Source : Windows Security Event Logs, Sysmon


# Event ID / Data Source Mapping:

| Source                    | EventCode | Description                      |
|---------------------------|-----------|----------------------------------|
| WinEventLog : Security    | 5156      | Windows Permitted a Connection   |
| WinEventLog : Security    | 4625      | Failed Login                     |
| WinEventLog : Security    | 4624      | Successful Login                 |
| WinEventLog : Security    | 5140      | Network Object was Accessed      |
| WinEventLog : Security    | 5145      | Network Object was Accessed      |


# Detection Query / Logic:
```spl 
- Search : Login
index=* 192.168.0.106 EventCode=4624 OR EventCode=4625
```
```spl 
- Search : Connection Attempt
index=* EventCode=3 OR EventCode=5156
```
```spl 
- Search : Network Object has been accessed
index=* EventCode=5140 OR EventCode=5145
```

# Sample Alert Screenshot

1) A Connection was permitted:   

![permits](<logs/Screenshot 2025-05-28 145134.png>)

2) Failed Login Attempt then immediately login successfully.  

![failed](<logs/Screenshot 2025-05-28 145157.png>)  
![success](<logs/Screenshot 2025-05-28 145240.png>)

3) Network shared object was accessed.  

![file_run](<logs/Screenshot 2025-05-28 145308.png>)  
![file_run](<logs/Screenshot 2025-05-28 145821.png>)  

4) Sample Logs 

![log](<logs/Screenshot 2025-05-28 144743.png>)  
![log](<logs/Screenshot 2025-05-28 145849.png>)  



# Analyst Notes / Recommendations:

* What Should an Analyst do ? 

-> Investigate and Verify the events(e.g.,Event ID = 5145) and identify the what object was access.  
-> Try to correlate it with any previous event(e.g.,Brute-Force or Enumeration).  
-> Verify if the attempts was expected, check the Source IP and at which time it occurs.  
-> Verify the access control, if the Source IP is unauthorized generate an alert in SIEM.  
-> Block or restrict the access of that IP.   
-> Document & Report.


# Detection Status

 -> Successfully Detected.  
