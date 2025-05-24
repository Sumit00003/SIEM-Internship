

# Detection Usecase 1 : Privilege Escalation Attempt


# Description: 
Monitoring a non-admin user tries to login to the system through ssh and attemps to add a user (backdoor) 
in the system and try to escalate the privilege by adding it to the administrator group and then logged off the system.

# Objective:
To identify Account Creation and Privilege Escalation Attempt by any non-admin.

# Tools Used:

-SIEM : Splunk Free

-Log Source : Windows Security Event Logs, Sysmon

-Lab Setup : The Virtual Window Machine(Victim) and Kali Linux(Attacker) on the same subnet. 
             Used SSH via Kali Linux to connect with Windows. 
             Windows log collection configured using Splunk Universal Forwarder + Sysmon.


# Event ID / Data Source Mapping:

| Source                    | EventCode | Description                      |
|---------------------------|-----------|----------------------------------|
| WinEventLog : Security    | 4624      | Successfully Logged On           |
| WinEventLog : Sysmon      | 1         | Process Creation                 |
| WinEventLog : Security    | 4720      | User was Created                 |
| WinEventLog : Security    | 4798      | User localgroup was enumerated   |
| WinEventLog : Security    | 4634      | User was logged off              |

# Detection Query / Logic:
```spl 
- Search Login
index=* EventCode=4624 Account_Domain="VIRTUAL USERS" sshd.exe
```
```spl 
- Search Account Creation
index=* EventCode=4720 OR EventCode=4728
```
```spl 
- Alert
index=* (EventCode=4728 OR EventCode=4720)
| eval Action=case(EventCode=4720,"User Acc Created",EventCode=4728,"Privilege Escalation")
| search NOT Account_Domain="sumit"
| table _time, SAM_Account_Domain, Action, host
```


# Sample Alert Screenshot

1) Attacker Login here using SSH.  
![login](<../screenshot/Screenshot 2025-05-22 170231.png>)  
![Login](<../logs/Screenshot 2025-05-22 163524.png>)  
![Login 2](<../logs/Screenshot 2025-05-22 164358.png>)

2) Attacker Run command : whoami, net.exe  
![whoami](<../logs/Screenshot 2025-05-22 164821.png>)  
![net1](<../logs/Screenshot 2025-05-22 165027.png>)  
![net2](<../logs/Screenshot 2025-05-22 165804.png>)

3) Account was created and escalated  
![backdoor](<../logs/Screenshot 2025-05-22 163743.png>)  
![alt text](<../logs/Screenshot 2025-05-22 163109.png>)

4) User was logged off  
![loggedoff](<../logs/Screenshot 2025-05-22 165923.png>)

5) Alert  
![alert](<../screenshot/Screenshot 2025-05-22 173045.png>)

# Analyst Notes / Recommendations:

1) What Should an Analyst do ? 

-> Investigate the Source IP and user. Check if the account is created by admin.  
-> If unauthorized account creation then try to disable the account from the System.  
-> Make an alert if some non-admin tries to create user or tries to escalate it.  
-> Report & Document.

2) Possible False Positives ?

-> Penetration Test(if red taem is active).

# Detection Status
 -> Successfully Detected.  
 -> Alert Successfully.


