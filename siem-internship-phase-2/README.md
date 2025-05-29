# Phase 2: Suspicious Activity Detction & Threat Actor Behavior Simulation

# Objective of Phase 2:

* Simulate and Detect Post-compromises activities
   - Focus Areas : persistence, lateral movement, Privilege Escalation.

# Lab Setup

List of Tools Used:

* VMWare – Windows 11, Windows 7, Metasploitable 2 and Kali Linux  
* SIEM – Splunk Enterprise Free(In Main System)  
* Monitoring Add-on – Splunk-Universal-Forwarder

Network Diagram:

![network](<screenshot/Screenshot 2025-05-27 115414.png>)


# Phase 2 Detection Usecases

| Usecase                                             | See Here                                                                                       |
|-----------------------------------------------------|------------------------------------------------------------------------------------------------|
| Privilege Escalation Attempt                        | [See Report 1](<Phase-2/Scenario-1-Privilege-Escalation/REPORT-1-Privilege-Escalation.md>)     |
| Lateral Movement Attempt                            | [See Report 2](<Phase-2/Scenario-2-Lateral-Movement/REPORT-2-Lateral-Movement.md>)             |
| Suspicious File Download and Execution              | [See Report 3](<Phase-2/Scenario-3-File-Download/REPORT-3-Suspicious-File.md>)                 |
| Anomalous User Behavior                             | [See Report 4](<Phase-2/Scenario-4-User-Behavior/REPORT-4-Anomalous-User-Behavior.md>)         |
| Command & Control (C2) Beaconing Behavior           | [See Report 5](<Phase-2/Scenario-5-Cmd&Control/REPORT-5-Command-And-Control.md>)               |


************** **************

# Phase 2 Extension - Vulnerability Assessment & Penetration Testing (VA/PT)

From Detection To Exploitaion - learned the attacker's perspective.

# Objective of Phase 2 Extension:

* Understand how vulnerability are discovered and exploited.  
   - Focus Areas : Perform Scan, Document the findings, and Provide remediation advice.

# Lab Setup

List of Tools Used:

* Victim Machine – Windows 7, Metasploitable 2, DVWA, Tryhackme Lab.  
* Attacker Machine - Kali Linux.
* Tools - Nmap, Nessus, Metasploit, ExploitDB.  


# Phase 2 Extension Usecases

| VA(Vulnerability Assessment)              | PT(Penetration Testing)                                   |
|-------------------------------------------|-----------------------------------------------------------|
|  [Vulnerability Assessment](<VA>)         |   [Manual-Exploit](<PT/Manual-exploit>)                   |
|                 -                         |   [VSFTPD-2.3.4](<PT/metasploit>)                         |
|                 -                         |   [Web-App-Scan](<PT/Web_Application>)                    |

*******************

# Phase 2 - Tool-Based Advanced Detection Scenarios

# Lab Setup

List of Tools Used:

* Victim Machine – Windows 7    
* Attacker Machine - Kali Linux. 
* Tools - WinPEASx64, Crackmapexec, Powershell-Empire, Mimikatz, schtasks, SSH, smbclient, PowerShell


| Usecase                                             | See Here                                                                           |
|-----------------------------------------------------|------------------------------------------------------------------------------------|
| Privilege Escalation with WinPEAS                   | [See Report 1](<Phase-2-Tool-Based/R1-Priv-Esc-WinPeas/Detect-1-winpeas.md>)       |
| Lateral Movement with Crackmapexec                  | [See Report 2](<Phase-2-Tool-Based/R2-LM-Crackmapexec/Detect-2-Crackmap.md>)       |
| Suspicious File Download and Execution with Empire  | [See Report 3](<Phase-2-Tool-Based/R3-FileDownload-Empire/Detect-3-empire.md>)     |
| Credentials Dumping with Mimikatz                   | [See Report 4](<Phase-2-Tool-Based/R4-Creds-Dump-Mimikatz/Detect-4-mimikaz.md>)    |
| Remote Scheduled Task Creation with schtasks        | [See Report 5](<Phase-2-Tool-Based/R5-Task-Creation/Detect-5-schtasks.md>)         |