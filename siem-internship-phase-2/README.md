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

| Usecase                                             | See Here                                                                               |
|-----------------------------------------------------|----------------------------------------------------------------------------------------|
| Privilege Escalation Attempt                        | [See Report 1](<siem-internship-phase-2/Phase-2/Scenario-1-Privilege-Escalation/REPORT-1-Privilege-Escalation.md>)   |
| Lateral Movement Attempt                            | baki hai                                |
| Suspicious File Download and Execution                    | [See Report 3](<siem-internship-phase-2/Phase-2/Scenario-3-File-Download/REPORT-3-Suspicious-File.md>)                             |
| Anomalous User Behavior                             | [See Report 4](<siem-internship-phase-2/Phase-2/Scenario-4-User-Behavior/REPORT-4-Anomalous-User-Behavior.md>)                                    |
| Command & Control (C2) Beaconing Behavior           | [See Report 5](<siem-internship-phase-2/Phase-2/Scenario-5-Cmd&Control/REPORT-5-Command-And-Control.md>)                         |


# Phase 2 Extension - Vulnerability Assessment & Penetration Testing (VA/PT)

From Detection To Exploitaion - learned the attacker's perspective.

# Objective of Phase 2 Extension:

* Understand how vulnerability are discovered and exploited.  
   - Focus Areas : Perform Scan, Document the findings, and Provide remediation advice.

# Lab Setup

List of Tools Used:

* Victim Machine – Windows 7, Metasploitable 2, DVWA, Tryhackme Lab.  
* Attacker Machine - Kali Linux. 


# Phase 2 Extension Usecases

| VA(Vulnerability Assessment)              | PT(Penetration Testing)                                   |
|-------------------------------------------|-----------------------------------------------------------|
|  [Nessus_Report](<VA/Nessus_Report.pdf>)  |   [Manual-Exploit](<PT/Manual-exploit>)                   |
|  [Nmap_Report](<VA/Nmap_Scan.txt>)        |   [VSFTPD-2.3.4](<PT/metasploit>)                         |
|                 -                         |   [Web-App-Scan](<PT/Web_Application>)                    |


# Reflection & Evaluation Questions

