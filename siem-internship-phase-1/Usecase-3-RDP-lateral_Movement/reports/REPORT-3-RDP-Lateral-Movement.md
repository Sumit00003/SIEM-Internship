

# Detection Usecase 3 : Lateral Movement Attempt via RDP


# Description: 
Monitoring Logon attempt to a system through SMB, where attacker has connected to our System 
and tried to gathered the data of the shared Directory which contain critical information.


# Objective:
To identify a logon attempts from an user to the windows system remotely.


# Tools Used:

-SIEM : Splunk Free

-Log Source : Windows Security Event Logs, Wireshark Logs

-Lab Setup : The Virtual Window Machine - Victim and Kali Linux - Attacker on the same subnet.
             Windows log collection configured using Splunk Universal Forwarder.  
             Kali Linux is used to login through SMB.
             and Alert in Splunk is used to detect it.


# Event ID / Data Source Mapping:

|Source                  | EventCode | Logon Type     | Description                       |
|------------------------|-----------|----------------|-----------------------------------|
| WinEventLog : Security | 4624      | 10             | Successfully Logged on via RDP    |
| WinEventLog : Security | 4624      | 3              | Successfully Logged on via SMB    |
| WinEventLog : Security | 4625      | 3              | Unsuccessfull Login via SMB       |


# Detection Query / Logic:

```spl (Search)
index=* 4624 | table Source_IP, Source_Port, Logon_type, _time, source
```

```spl (For Alert)
index=* Logon_Type=3 OR Logon_Type=10 
EventCode=4624 OR EventCode=3
```


# Sample Alert Screenshot

![UnSuccess](<../logs/Screenshot 2025-05-18 134816.png>)  
![Search](<../logs/Screenshot 2025-05-18 131421.png>)  
![Wireshark](<../logs/Screenshot 2025-05-18 132035.png>)  
![Shared Dir](<../logs/Screenshot 2025-05-18 132252.png>)
![Pass](<../logs/Screenshot 2025-05-18 132623.png>)


# Analyst Notes / Recommendations:

1) What Should an Analyst do ? 

-> Validate the Event - Check event Logs, verify timestamp.  
-> Correlate with other logs - Such as Previous Failed Login attempts, Process Creation.    
-> If Unauthorized  - For Temporary Period of time disable user account.  
-> Report & Document.

2) Possible False Positives ?

-> Admin Work - Maintenance or Patching.  
-> Remote Users - in different Timezones.  


# Detection Status
 -> Successfully Triggered.


