Phase 1: SIEM Foundation - Building Your Cyber Defense Lab



Introduction:

Welcome to the CyberSecurity SIEM Internship Program, proudly sponsored by Srida IT Consulting and Services Pvt Ltd.
This internship is designed to learn from the cybersecurity real-world events , to improve skill of the interns and prepare them for a role in cybersecurity.
This internship provide challenge-driven learning  and focused on hands-on implementation SIEM detection use cases.



Objective of Phase 1:

* Setup the SOC Labs

* Simulate Basic attacks

* Configure Log sources

* Detect real threats.

***********        **************

What is SIEM and Why it Matters ?


SIEM, short for Security Information and Event Management, is a security solution that helps organizations to monitor, analyze, and respond to potential threats and vulnerabilities within their IT infrastructure.

It combines Security information management(SIM) and security event management(SEM) to provide a centralized view of security events.

SIEM collects data from various sources, correlate events, and generate alerts to facilitate rapid response to security incidents that results in mitigation of emerging cyber-attacks in the organization infrastructure.


***********        **************


Lab Setup

List of Tools Used:
* VMWare – Windows 10 and Linux 
* SIEM – Splunk Enterprise Free(In Main System)
* Monitoring Add-on – Splunk-Universal-Forwarder

Network Diagram:

![SetUp](<screenshorts/Screenshot 2025-05-17 113039.png>)



***********        **************


Log Sources Configuration

As a Log Source, Virtual Windows Machine is used. For Log Capturing it use:
1) Splunk Universal Fowarder + Sysmon
![Sysmon](<screenshorts/Screenshot 2025-05-15 125229.png>)
![Forwarder](<screenshorts/Screenshot 2025-05-17 130801-1.png>)


Universal Fowarder forward the data into the Main System(Windows 11) where Splunk Enterprise is running.

![Splunk](<screenshorts/Screenshot 2025-05-17 113437.png>)



Detection Usecases

| Usecase                                               |    See Here   
|
|Brute Force Followed by Privileged Logon               |  [See Report](reports/REPORT-1-Brute-force-Detection.md)
|
|Suspicious Login Times - After Hours Admin Activity
|
|Lateral Movement Attempt via RDP
|
|Log Tampering Simulation
|
|Hidden User Account Creation
|


