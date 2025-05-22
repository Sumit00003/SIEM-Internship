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

| Usecase                                             | See Here                                                                               |
|-----------------------------------------------------|----------------------------------------------------------------------------------------|
| Brute Force Followed by Privileged Logon            | [See Report 1](<Usecase-1-Brute-Force/reports/REPORT-1-Brute-force-Detection.md>)      |
| Suspicious Login Times - After Hours Admin Activity | [See Report 2](<Usecase-2-After-Hours-LoggedOn/reports/REPORT-2-After_Hours_Logon.md>)                                |
| Lateral Movement Attempt via RDP                    | [See Report 3](<Usecase-3-RDP-lateral_Movement/reports/REPORT-3-RDP-Lateral-Movement.md>)                             |
| Log Tampering Simulation                            | [See Report 4](<Usecase-4-Log-Tampering/reports/REPORT-4-Log-Tampering.md>)                                    |
| Hidden User Account Creation                        | [See Report 5](<Usecase-5-User-Account-Creation/reports/REPORT-5-Hidden-User-Acc-Creation.md>)                         |

# Reflection & Evaluation Questions

1) What is the role of SIEM in modern cybersecurity ?
   -> As the technology increasing very rapidly, all the services, information, goods are available on the internet.
Due to which many black hat hackers are attracted towards many organisation and make them target.
SIEM provide the organisation to monitor, analyse, detect and respond to any potential threads at early stages,
as a result any attack can be mitigated before it become successful.


2) What challenges did you face while setting up your lab ?
   -> My 4 days in first week is spend on setting up the lab, i first tried winlogbeat to forward data to splunk but it was sending the logs in binary format 
, then i used logstash to take winlogbeat logs and make it suitable for the splunk, while doing this i got many errors that i solved till 2 days, still iit was not sending data in proper json instead sending in raw format. After that i got to know about universal forwarder finally i used that to send the logs from my virtual windows machine to splunk running on main system(Wins 11).


3) What are the difference between Sysmon logs and Windows Security Logs ?
   -> Sysmon logs - It Provides low-level system activity information such as Process Creation(Event ID 1), Network Connections(Event ID 3)
-> Windows Security logs - It Records event related to user activity, authentication, security policies such as Successful and failed Logins(Event ID 4624, 4625), Privilege Use, Groups membership changes.


4) How does a brute force attack appear in logs ? Mention specific Event ID ?
   -> Many similar logs with Wins Security Event ID 4625 appear in the splunk.


5) How would you detect a login outside normal business hours ?
    -> By analysing the logs timing that does not correlate with the business hours and by creating an alert of this incident(Event ID 4624) in splunk. Then if there is an alert the incident get detected.


6) Describe how RDP lateral movement is tracked in event logs.
    -> Any Logon attempts has event ID 4624, if the LOGON TYPE is 10, then it is consider as RDP login or Remote login. If any unusual activity occurs like process creation, privilege escalation then we can correlate the incident with previous RDP login attempt ,thats how we tracked RDP lateral movement.


7) What is the risk of log tampering, and how can we detect it ?
    -> After attacker done with their objective in target system they try to erase all their doings by clearing the logs. 
If the logs are tamper or erase it will be impossible to know attacker movement into our system.
By monitoring the event for Windows System Log with Event ID 104, through which we come to that someone has tried to erase the log into our system.


8) What improvements would you make in your lab setup if given more time ?
    -> To improve my detection I would like to use Splunk Enterprise Security that provides advanced security capabilities and also may increase Storage and proccessing capability for my setup.


9) How will this phase help you in real-world interviews or jobs ?
    -> So, I am passionate in Offensive Security, for this role the red teamer should have knowledge or insight about how defender defend the system and detect any incident. This phase give an idea about how incident are monitored by the analyst.


10) What was your biggest takeaway from phase 1 ?
    -> My biggest takeaway from this phase was understanding how real-world attacks are map to specific log events and how SIEM tools like Splunk can be configured to detect them. Through hands-on simulation i learned how to use event IDs effectively and how to generate an alert for any incident.
