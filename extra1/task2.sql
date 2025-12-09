USE ChallengeDB;

INSERT INTO Employees (First_Name, Last_Name, Email, Job_Title, Hire_Date, Salary)
VALUES 
    ('John', 'Doe', 'john.doe@gmail.com', 'Software Developer', '2023-01-15', 45000.00),
    ('Sarah', 'Johnson', 'sarah.johnson@gmail.com', 'Project Manager', '2022-06-20', 48000.00),
    ('Michael', 'Williams', 'michael.williams@gmail.com', 'Software Developer', '2023-03-10', 42000.00),
    ('Emily', 'Brown', 'emily.brown@gmail.com', 'Data Analyst', '2023-08-05', 38000.00),
    ('David', 'Jones', 'david.jones@gmail.com', 'Project Manager', '2021-11-12', 50000.00);

INSERT INTO Customers (First_Name, Last_Name, Email, Province, City)
VALUES 
    ('Jennifer', 'Taylor', 'jennifer.taylor@outlook.com', 'Ontario', 'Toronto'),
    ('Robert', 'Anderson', 'robert.anderson@outlook.com', 'British Columbia', 'Vancouver'),
    ('Lisa', 'Martinez', 'lisa.martinez@outlook.com', DEFAULT, 'Ottawa'),
    ('James', 'Garcia', 'james.garcia@outlook.com', 'Quebec', 'Montreal'),
    ('Amanda', 'Wilson', 'amanda.wilson@outlook.com', 'Alberta', 'Calgary');

SELECT * FROM Employees;

SELECT AVG(Salary) AS Average_Salary FROM Employees;

SELECT Job_Title, AVG(Salary) AS Average_Salary 
FROM Employees 
GROUP BY Job_Title;


UPDATE Customers 
SET City = 'Mississauga', Province = 'Ontario' 
WHERE Cust_ID = 1;

SELECT * FROM Customers WHERE Cust_ID = 1;
