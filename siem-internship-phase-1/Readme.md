# Phase 1: SIEM Foundation - Building Your Cyber Defense Lab



# Introduction:

Welcome to the CyberSecurity SIEM Internship Program, proudly sponsored by Srida IT Consulting and Services Pvt Ltd.
This internship is designed to learn from the cybersecurity real-world events , to improve skill of the interns and prepare them for a role in cybersecurity.
This internship provide challenge-driven learning  and focused on hands-on implementation SIEM detection use cases.



# Objective of Phase 1:

* Setup the SOC Labs

* Simulate Basic attacks

* Configure Log sources

* Detect real threats.

***********        **************

# What is SIEM and Why it Matters ?


SIEM, short for Security Information and Event Management, is a security solution that helps organizations to monitor, analyze, and respond to potential threats and vulnerabilities within their IT infrastructure.

It combines Security information management(SIM) and security event management(SEM) to provide a centralized view of security events.

SIEM collects data from various sources, correlate events, and generate alerts to facilitate rapid response to security incidents that results in mitigation of emerging cyber-attacks in the organization infrastructure.


# Lab Setup

List of Tools Used:

* VMWare – Windows 10 and Linux  
* SIEM – Splunk Enterprise Free(In Main System)  
* Monitoring Add-on – Splunk-Universal-Forwarder

Network Diagram:

![SetUp](<screenshorts/Screenshot 2025-05-17 113039.png>)

# Log Sources Configuration

As a Log Source, Virtual Windows Machine is used. For Log Capturing it use:

- Splunk Universal Fowarder + Sysmon
![Sysmon](<screenshorts/Screenshot 2025-05-15 125229.png>)  
![Forwarder](<screenshorts/Screenshot 2025-05-17 130801-1.png>)


Universal Fowarder forward the data into the Main System(Windows 11) where Splunk Enterprise is running.

![Splunk](<screenshorts/Screenshot 2025-05-17 113437.png>)



# Detection Usecases

(For Usecase 3 RDP, due to storage issues not able to download another virtual windows and also not able to use RDP because the virtual windows 11 was not supporting it. Solution used => Used Kali Linux as 2nd virtual machine and used SMB instead of RDP).

| Usecase                                               | See Here                                                       |
|-------------------------------------------------------|----------------------------------------------------------------|
| Brute Force Followed by Privileged Logon              | [See Report 1](reports/REPORT-1-Brute-force-Detection.md)      |
| Suspicious Login Times - After Hours Admin Activity   | [See Report 2](<reports/REPORT-2-After_Hours_Logon.md>)        |
| Lateral Movement Attempt via RDP                      | [See Report 3](<reports/REPORT-3-RDP-Lateral-Movement.md>)     |
| Log Tampering Simulation                              | [See Report 4](<reports/REPORT-4-Log-Tampering.md>)            |
| Hidden User Account Creation                          | [See Report 5](<reports/REPORT-5-Hidden-User-Acc-Creation.md>) |


