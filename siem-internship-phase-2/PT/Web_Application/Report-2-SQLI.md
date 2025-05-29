# DVWA - SQL Injection Vulnerability - Sensitive Data Exposure

* Introduction:  

SQLI (SQL Injection) is a web security vulnerability that allows an attacker to inject malicious sql query into a website, to modify or delete or retrieve the data.

* Vulnerability Details:  

The vulnerable URL is: `http://10.10.25.252/sqli`
An attacker can inject a malicious SQL query in the User ID search box.

* Proof of Concept (POC):  

In the User ID field, enter: `'union select table_name,null from information_schema.tables#`
This will display all the table names.

* Impact:  

If Someone is able to inject a malicious SQL query in the search section, then he can retrive all the sensitive data store in the databases or can modify data or even can delete some critical data.

* Steps to Reproduce:

1. Log in as a user on url url [http://10.10.25.252/login.php]  
2. Visit the SQL Injection Section.  
3. Enter the following payload into the User ID field: `'or 1=1#` This tells that the website is vulnerable t SQL Injection.  
4. Then use following payload to retrieve all the tables: `'union select table_name,null from information_schema.tables#`

* Recommendation:  

1. Implement output encoding to prevent the interpretation of user input as code.  
2. Implement a Strong & Proper Validation.  
3. Use Prepared Statement instead of concatenating the user input directly into the sql query.  
4. Regularly scan the application for SQL vulnerabilities.


* Attachments:  

![sql1](<screenshots/Screenshot 2025-05-26 170119.png>)  
![sql2](<screenshots/Screenshot 2025-05-26 170332.png>)