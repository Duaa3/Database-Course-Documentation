CREATE DATABASE AIMS;
USE AIMS;


CREATE TABLE Servers ( 
server_id INT PRIMARY KEY, 
server_name VARCHAR(50), 
region VARCHAR(50) 
); 

INSERT INTO Servers VALUES 
(1, 'web-server-01', 'us-east'), 
(2, 'db-server-01', 'us-east'), 
(3, 'api-server-01', 'eu-west'), 
(4, 'cache-server-01', 'us-west'); 

CREATE TABLE Alerts ( 
alert_id INT PRIMARY KEY, 
server_id INT, 
alert_type VARCHAR(50), severity VARCHAR(20) 
); 

INSERT INTO Alerts VALUES 
(101, 1, 'CPU Spike', 'High'), 
(102, 2, 'Disk Failure', 'Critical'), 
(103, 2, 'Memory Leak', 'Medium'), 
(104, 5, 'Network Latency', 'Low'); 

CREATE TABLE AI_Models ( 
model_id INT PRIMARY KEY, 
model_name VARCHAR(50), 
use_case VARCHAR(50) 
); 

INSERT INTO AI_Models VALUES 
(201, 'AnomalyDetector-v2', 'Alert Prediction'), 
(202, 'ResourceForecaster', 'Capacity Planning'), 
(203, 'LogParser-NLP', 'Log Analysis'); 

CREATE TABLE ModelDeployments ( 
deployment_id INT PRIMARY KEY, 
server_id INT, 
model_id INT, 
deployed_on DATE 
); 

INSERT INTO ModelDeployments VALUES 
(301, 1, 201, '2025-06-01'), 
(302, 2, 201, '2025-06-03'), 
(303, 2, 202, '2025-06-10'), 
(304, 3, 203, '2025-06-12'); 


SELECT Alerts.alert_id, Alerts.alert_type, Alerts.severity, Servers.server_name  
FROM Alerts  
INNER JOIN Servers ON Alerts.server_id = Servers.server_id;  

SELECT Servers.server_id, Servers.server_name, Alerts.alert_id, Alerts.alert_type, Alerts.severity  
FROM Servers  
LEFT JOIN Alerts ON Servers.server_id = Alerts.server_id;  

SELECT Alerts.alert_id, Alerts.alert_type, Alerts.severity, Servers.server_name  
FROM Servers  
RIGHT JOIN Alerts ON Servers.server_id = Alerts.server_id;  

SELECT Servers.server_id, Servers.server_name, Alerts.alert_id, Alerts.alert_type, Alerts.severity  
FROM Servers  
FULL OUTER JOIN Alerts ON Servers.server_id = Alerts.server_id;  

SELECT Servers.server_id, Servers.server_name, AI_Models.model_id, AI_Models.model_name  
FROM Servers  
CROSS JOIN AI_Models;  