

# Detection Usecase 2 : Suspicious Login Times - After Hours Admin Activity


# Description: 
Monitoring a Successful Login Attempt After Business Hours(9 AM - 7 PM).


# Objective:
To identify a logon attempts from any privileged accounts when the network activity is not active.


# Tools Used:

-SIEM : Splunk Free

-Log Source : Windows Security Event Logs, Wireshark Logs

-Lab Setup : The Virtual Window Machine(Victim or Target) and Kali Linux(Attacker) on the same subnet.  
             Windows log collection configured using Splunk Universal Forwarder.  
             Kali Linux is used to login after business hours and Alert in Splunk is used to detect it.


# Event ID / Data Source Mapping:

|Source                  | EventCode | Description                |
|------------------------|-----------|----------------------------|
|WindowsEventLog         | 4624      | Successfully Logged On     |


# Detection Query / Logic:

```spl
index=main EventCode=4624  
| eval logon_hour = strftime(_time, "%H")   
| where (logon_hour < 9 OR logon_hour >= 19)  
| table _time, Account_Name, host, Source_Network_Address, logon_hour
```


# Sample Alert Screenshot

![](<../logs/Screenshot 2025-05-17 154312.png>)  
![2](<../logs/Screenshot 2025-05-17 203201.png>)  
![3](<../logs/Screenshot 2025-05-17 204804.png>)


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
  -> Alert Triggered.
  -> Detection Tested

