

# Detection Usecase 5 : Hidden User Account Creation


# Description: 
Monitoring a event where tha attacker has log in to the system then created a 
new account 'Support1' then added the account in admins groups and logged off from the system.


# Objective:
To identify a new account creation and privilege escalation event done by an unauthorized user.

# Tools Used:

-SIEM : Splunk Free

-Log Source : Windows Security Event Logs 

-Lab Setup : The Virtual Window Machine(Victim) and Kali Linux(Attacker) on the same subnet.  
             Windows log collection configured using Splunk Universal Forwarder.  
             Kali Linux is used to login to system and create a user then add the user in admins groups.
             Splunk Enterprise is used to detect it.


# Event ID / Data Source Mapping:

|Source                  | EventCode | Description                                      |
|------------------------|-----------|--------------------------------------------------|
| WinEventLog : Security | 3         | Successfully Logged on via SSH                   |
| WinEventLog : Sysmon   | 1         | Process Creation                                 |
| WinEventLog : Security | 4720      | User Account was created                         |
| WinEventLog : Security | 4732      | Member was added to security-enabled local group |
| WinEventLog : Security | 4634      | Account Logged off                               | 

# Detection Query / Logic:

```
spl (Alert)
index=main EventCode=4720  
| eval logon_hour = strftime(_time, "%H")   
| where (logon_hour < 9 OR logon_hour >= 19)  
| table SAM_Account_Name, Account-domain, logon_hour
```


# Sample Alert Screenshot

![Login](<../logs/Screenshot 2025-05-18 161602.png>)  
![Add-ACC](<../logs/Screenshot 2025-05-18 160557.png>)  
![Account](<../logs/Screenshot 2025-05-18 155404.png>)  
![Admin](<../logs/Screenshot 2025-05-18 161821.png>)  
![Local-Group](<../logs/Screenshot 2025-05-18 162348.png>)  
![Log out](<../logs/Screenshot 2025-05-18 152814.png>)  
![Alert](<../logs/Screenshot 2025-05-18 165056.png>)s


# Analyst Notes / Recommendations:

1) What Should an Analyst do ? 

-> Validate the Event - Who Created the User, When it was created - In Business Hours or Not.  
-> Correlate with other logs - Such as Previous Failed Login attempts or login attempts, Process Creation.
-> If Unauthorized  - For Temporary Period of time disable user account.  
-> Report & Document.
-> Improve the Detection through alerts.

2) Possible False Positives ?

-> System Administrators may create new employee accounts.  
-> Software Installations - SQL Server, OpenSSH create local service account during install.
-> Penetration Testing.

# Detection Status
-> Successfully Triggered.


