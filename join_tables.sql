create database join_task;
use join_task;

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
    alert_type VARCHAR(50), 
    severity VARCHAR(20) 
);

INSERT INTO Alerts VALUES 
(101, 1, 'CPU Spike', 'High'), 
(102, 2, 'Disk Failure', 'Critical'), 
(103, 2, 'Memory Leak', 'Medium'), 
(104, 5, 'Network Latency', 'Low'); -- Invalid server_id (edge case)

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

SELECT 
    A.alert_id, 
    A.alert_type, 
    A.severity, 
    S.server_name
FROM Alerts A
INNER JOIN Servers S ON A.server_id = S.server_id;

SELECT 
    S.server_id,
    S.server_name,
    A.alert_id,
    A.alert_type,
    A.severity
FROM Servers S
LEFT JOIN Alerts A ON S.server_id = A.server_id;

SELECT 
    A.alert_id,
    A.alert_type,
    A.severity,
    S.server_name
FROM Alerts A
RIGHT JOIN Servers S ON A.server_id = S.server_id;

SELECT 
    A.alert_id,
    A.alert_type,
    A.severity,
    S.server_name
FROM Servers S
RIGHT JOIN Alerts A ON S.server_id = A.server_id;

SELECT 
    S.server_id,
    S.server_name,
    A.alert_id,
    A.alert_type,
    A.severity
FROM Servers S
FULL OUTER JOIN Alerts A ON S.server_id = A.server_id;

SELECT 
    M.model_id,
    M.model_name,
    M.use_case,
    S.server_id,
    S.server_name,
    S.region
FROM AI_Models M
CROSS JOIN Servers S;

