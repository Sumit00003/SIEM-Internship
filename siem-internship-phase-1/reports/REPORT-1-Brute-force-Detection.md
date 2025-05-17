

# Detection Usecase 1 : Brute Force Followed by Privileged Logon


# Description: 
Attacker or Malicious Person attemps to gain access to a Windows System by rapidly trying multiple passwords with a single username.
After Several Failed Logon attempt ,a successful login may occur if credentials are guessed correctly.


# Objective:
To identify Brute-Force login attempts from a remote users using ssh service(e.g., Event_ID 4624)
from the same user within a short time window(e.g.,1 minute).
After some attempt he successfully login into the System.


# Tools Used:

-SIEM : Splunk Free

-Log Source : Windows Security Event Logs 

-Lab Setup : The Virtual Window Machine(Victim or Target) and Kali Linux(Attacker) on the same subnet. 
             Hydra is used to simulate Brute-force attacks over SSH. 
             Windows log collection configured using Splunk Universal Forwarder.


# Event ID / Data Source Mapping:

|Source                  | EventCode | Description                |
|------------------------|-----------|----------------------------|
|WinEventLog:Security    | 4625      | Failed Login Attempts      |
|WinEventLog:Security    | 4624      | Successfully Logged On     |
|                        |           |                            |

# Detection Query / Logic:

Splunk SPL :-

=> index=* 4625 Failure Audit sshd.exe 
| table Account_Name, Caller_Process_Name 
| bin _time span=1m 
| stats count by Account_Name, Caller_Process_Name 
| where count > 5


# Sample Alert Screenshot

![Brute Detection 1](<../logs/Screenshot 2025-05-17 144614.png>)

![Brute Detection 2](<../logs/Screenshot 2025-05-17 104229.png>)

In the Above image, User(IP:192.168.0.104) has brute force using a single "sshuser" Account 
as the username with multiple passwords.

![Wireshark Log 1](<../logs/Screenshot 2025-05-17 111919.png>)

![Wireshark Log 2](<../logs/Screenshot 2025-05-17 112004.png>)

Above Logs Shows, Multiple repeated exchanges between 192.168.0.104(Attacker) and 192.168.0.103(Victim).
The Key Exchange Init Packets, indicate start of an SSH Session and TCP Packets right after handshake indicate failed attempts.
Right After Guessing the correct password,  attacker has successfully access the sshuser Account.

![Successful Logon 1](<../logs/Screenshot 2025-05-17 105209.png>)

![Successful Logon 2](<../logs/Screenshot 2025-05-17 111313.png>)


# Analyst Notes / Recommendations:

1) What Should an Analyst do ? 

-> Investigate the Source IP and user. Check if login was expected, verify with the User.
-> If Suspicious try to isolate the host from network.
-> Block the Source IP for Temporary Period of Time and report to escalated authority.

2) Possible False Positives ?

-> Users may forgot the password.
-> Penetration Test(if red taem is active).


# Detection Status
    - Successfully Triggered.


