

# Detection Usecase 4 : Anomalous User Behavior


# Scenario Summary: 
Monitoring a user who tries to logon to system during Off-hours and attemps to access the file share,
and copy more 60+ files within a minute.

# Attack Steps:
Here, Virtual Windows 11 is the victim where universal forwarder is running,  
and  Virtual Kali Linux is the attacker.

- The Attack was simulated by Kali Linux on Windows System as follows:  
1) Attacker try to access the shared folder using smbclient    
```
smbclient //10.10.45.252/Secret -U sshuser
```
2) And tries to access or downloaad all the file.    
```
mget *
```

Tools Used:  
-Attacker Tool : smbclient
-SIEM : Splunk Free  
-Log Source : Windows Security Event Logs, Sysmon


# Event ID / Data Source Mapping:

| Source                    | EventCode | Description                                                         |
|---------------------------|-----------|---------------------------------------------------------------------|
| WinEventLog : Security    | 4624      | Successfully Logged On                                              |
| WinEventLog : Security    | 5145      | Network Share was checking whether client can be granted access     |

# Detection Query / Logic:

```spl 
- Search File access
index=* EventCode=5145
```  

```spl 
- Alert For File Burst
index=* EventCode=5145 
| bin _time span=2m
| stats count by Account_Name, Source_Address, _time
| where count >= 40
```  

```spl 
- Alert for Off-Hours Login
index=main EventCode=4624
| eval logon_hour = strftime(_time, "%H") 
| where (logon_hour < 9 OR logon_hour >= 19)
| table _time, Account_Name, host, Source_Network_Address, logon_hour
```


# Sample Alert Screenshot

1) Attacker Trying to download many file in short time  
![access1](<logs/Screenshot 2025-05-25 145135.png>)  
![access2](<logs/Screenshot 2025-05-24 201132.png>)

2) Alerts  
![alert1](<screenshots/Screenshot 2025-05-24 201006.png>)  
![alert2](<screenshots/Screenshot 2025-05-24 200717.png>)


# Analyst Notes / Recommendations:

1) What Should an Analyst do ? 

-> Investigate the event - Check User identity, what file type is been accessed,   
what is the time of file accessed in working hours or off-hours.  
-> Correlate with other events like logon during off-hours.  
-> If Suspicious - Isolate the System, Disable the user accounts.  
-> Patch the vulnerability which cause the attack to happen.  
-> Document & Report.  

# Detection Status

 -> Successfully Detected.  
 -> Alert Successfully.


