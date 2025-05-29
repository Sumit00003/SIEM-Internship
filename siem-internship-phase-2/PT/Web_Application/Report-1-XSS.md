# DVWA - Reflective XSS Vulnerability - User Cookie Exposure

* Introduction:  

XSS (Cross-Site Scripting) is a web security vulnerability that allows an attacker to inject malicious scripts into a website.
In this Case, a reflected XSS was found which reflecting the cookie of the user.

* Vulnerability Details:  

The vulnerable URL is: `http://10.10.25.252/xss`
An attacker can inject a malicious script in the search box.

* Proof of Concept (POC):  

In the Search field, enter: `<scRipT>alert(document.cookie)</SRIpT>`
This will display an alert box in the browser with the cookie of the user.

* Impact:  

A malicious script in the search section, attacker can send a crafted url to any user and steal user cookies which lead to session hijacking of users account, then attacker can modify the content of the page or disrupt the website using user account.

* Steps to Reproduce:

1. Log in as a user on url [http://10.10.25.252/index.php].  
2. Visit the Reflected XSS Section.  
3. Enter the following payload into the search field: `<scRipT>alert(document.cookie)</SRIpT>`  
4. Observe the alert box triggered by the injected script.

* Recommendation:  

1. Implement output encoding to prevent the interpretation of user input as code.  
2. Use CSP(Content Security Policy) which control which scripts and resources can be load on a webpage.  
3. Regularly scan the application for XSS vulnerabilities.


* Attachments:  

![xss1](<screenshots/Screenshot 2025-05-26 165849.png>)  
![xss2](<screenshots/Screenshot 2025-05-26 165825.png>)  
![xss3](<screenshots/Screenshot 2025-05-26 165959.png>)