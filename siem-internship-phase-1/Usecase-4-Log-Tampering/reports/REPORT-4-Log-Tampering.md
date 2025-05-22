

# Detection Usecase 4 : Log Tampering Simulation


# Description: 
Monitoring a Event where Attacker Logged on into the System through sshuser user account Via SSH.
He grabs ssh keys for another user then cleared the log through PowerShell 
and logged out from the system.

# Objective:
To identify a unauthorized Log Tampering attempts from any account in the network and alert this incident.


# Tools Used:

-SIEM : Splunk Free

-Log Source : Windows Security Event Logs 

-Lab Setup : The Virtual Window Machine(Victim) and Kali Linux(Attacker) on the same subnet.  
             Windows log collection configured using Splunk Universal Forwarder.  
             Kali Linux is used to login through ssh and cleared the logs 
             and Splunk is used to detect it.


# Event ID / Data Source Mapping:

|Source                  | EventCode | Description                       |
|------------------------|-----------|-----------------------------------|
| WinEventLog : Security | 3         | Successfully Logged on via SSH    |
| WinEventLog : Sysmon   | 1         | Process Creation                  |
| WinEventLog : System   | 104       | Log Clear                         |
| WinEventLog : Security | 4634      | Account Logged off                | 

# Detection Query / Logic:

```spl 
index=* EventCode=104 source="WinEventLog:System"
```


# Sample Alert Screenshot

![Login](<../logs/Screenshot 2025-05-18 161602.png>)  
![Powershell](<../logs/Screenshot 2025-05-18 150514.png>)  
![Logs](<../logs/Screenshot 2025-05-18 152731.png>)  
![Log out](<../logs/Screenshot 2025-05-18 152814.png>)


# Analyst Notes / Recommendations:

1) What Should an Analyst do ? 

-> Verify the Tampering - Check event Logs, Identify affected system, verify timestamp.  
-> Isolate the affected System.  
-> Collect Evidence for it from other sources(e.g.,Firewall) and Correlate the source.  
-> Report & Document the Incident.

2) Possible False Positives ?

-> Admin Work - Maintenance.  
-> A User might run a scripts with higher privilege that unintentionally cleared the logs.  
-> Logs might get overwritten due to size limit, it appears like detection but its just old logs overwritten.  


# Detection Status
-> Detection Tested.


