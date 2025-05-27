

# Detection Usecase 1 : Privilege Escalation Attempt


# Scenario Summary: 
Monitoring a non-admin user tries to login to the system through ssh and attemps to add a user (backdoor)
in the system and try to escalate the privilege by adding it to administrators group and then logged off the system.

# Attack Steps:
Here, Virtual Windows 11 is the victim where universal forwarder is running,  
and Virtual Kali Linux is the attacker.

- The Attack was simulated by Kali Linux on Windows as follows:  
1) Attacker Login to Victim Machine via SSH  
```
ssh sshuser@<10.10.99.77>
```
2) He tries to create a elevated 'backdoor' user for him to stay persistence in victim system.  
```
net use backdoor /add  
net localgroup administrators backdoor /add
```

Tools Used:  
-Attacking Tool : SSH, Net.exe
-SIEM : Splunk Free  
-Log Source : Windows Security Event Logs, Sysmon


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
![Login](<logs/Screenshot 2025-05-22 163524.png>)  
![Login 2](<logs/Screenshot 2025-05-22 164358.png>)

2) Attacker Run command : whoami, net.exe  
![whoami](<logs/Screenshot 2025-05-22 164821.png>)  
![net1](<logs/Screenshot 2025-05-22 165027.png>)  
![net2](<logs/Screenshot 2025-05-22 165804.png>)

3) Account was created and escalated  
![backdoor](<logs/Screenshot 2025-05-22 163743.png>)  
![alt text](<logs/Screenshot 2025-05-22 163109.png>)

4) User was logged off  
![loggedoff](<logs/Screenshot 2025-05-22 165923.png>)

5) Alert  
![alert](<screenshot/Screenshot 2025-05-22 173045.png>)

# Analyst Notes / Recommendations:

1) What Should an Analyst do ? 

-> Investigate the Source IP and user. Check if the account is created by admin.  
-> If unauthorized account creation then try to disable the account from the System.  
-> Make an alert if some non-admin tries to create user or tries to escalate it.  
-> Report & Document.


# Detection Status
 -> Successfully Detected.  
 -> Alert Successfully.


