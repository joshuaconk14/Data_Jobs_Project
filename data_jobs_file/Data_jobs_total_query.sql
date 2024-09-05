-- goal:
-- figure out which program languages used most for data jobs, + specific ones

-- later on:
-- education requirements for data jobs (scrape dashboard again)
-- where these jobs are located
-- which jobs provide more $ based on avg salary

-- issues: 
-- Julia was null
-- not a lot of manager of data jobs or other jobs, not enough data
-- Differentiating R, C, and Go as programming languages
-- in like statement: OR Job_Description LIKE '% C/%', C/ would bring up emails, so could not use


-- convert min, max, and avg salaries to thousands
UPDATE Glassdoor_Data_Jobs
SET min_salary = min_salary * 1000,
    max_salary = max_salary * 1000,
    avg_salary = avg_salary * 1000;


-- create new columns separating job titles
ALTER TABLE Glassdoor_Data_Jobs
ADD Job_Title_Classification VARCHAR(MAX);


-- classify job titles
UPDATE Glassdoor_Data_Jobs
SET Job_Title_Classification = 
    CASE
        WHEN Job_Title LIKE '%scientist%'
            OR Job_Title LIKE '%science%'
            AND Job_Title LIKE '%data%' THEN 'Data Scientist'
        WHEN Job_Title LIKE '%analyst%'
            OR Job_Title LIKE '%analysis%'
            OR Job_Title LIKE '%analytics%'
            AND Job_Title LIKE '%data%' THEN 'Data Analyst'
        WHEN Job_Title LIKE '%engineer%'
            OR Job_Title LIKE '%engineering%'
            AND Job_Title LIKE '%data%' THEN 'Data Engineer'
        WHEN Job_Title LIKE '%manager%'
            OR Job_Title LIKE '%management%'
            AND Job_Title LIKE '%data%' THEN 'Manager of Data'
        ELSE 'Other'
    END;


-- run the newly classified jobs column
    SELECT Job_Title, Job_Title_Classification
FROM Glassdoor_Data_Jobs
ORDER BY Job_Title_Classification;


-- make programming languages columns
ALTER TABLE Glassdoor_Data_Jobs
ADD Python_yn BIT,
    R_yn BIT,
    SQL_yn BIT,
    Java_yn BIT,
    Julia_yn BIT,
    Scala_yn BIT,
    C_yn BIT,
    JavaScript_yn BIT,
    Swift_yn BIT,
    Go_yn BIT,
    MATLAB_yn BIT,
    SAS_yn BIT,
    Pandas_yn BIT;


-- determine what programming languages mentioned in each job's description
UPDATE Glassdoor_Data_Jobs
SET
Python_yn = CASE
                WHEN Job_Description LIKE '%Python%' THEN 1
                ELSE 0
            END,
R_yn = CASE
                WHEN Job_Description LIKE '% R %' 
                         OR Job_Description LIKE '% R,%'
                         OR Job_Description LIKE '% R/%'
                         OR Job_Description LIKE '% R.'
                         OR Job_Description LIKE '% R.%' THEN 1 
                ELSE 0
            END,
SQL_yn = CASE
                WHEN Job_Description LIKE '%SQL%' THEN 1
                ELSE 0
            END,
Java_yn = CASE
                WHEN Job_Description LIKE '% Java %' 
                         OR Job_Description LIKE '% Java,%'
                         OR Job_Description LIKE '% Java/%'
                         OR Job_Description LIKE '% Java.'
                         OR Job_Description LIKE '% Java.%' THEN 1
                ELSE 0
            END,
Julia_yn = CASE
                WHEN Job_Description LIKE '%Julia%' THEN 1
                ELSE 0
            END,
Scala_yn = CASE
                WHEN Job_Description LIKE '% Scala %' 
                         OR Job_Description LIKE '% Scala,%'
                         OR Job_Description LIKE '% Scala/%'
                         OR Job_Description LIKE '% Scala.'
                         OR Job_Description LIKE '% Scala.%' THEN 1
                ELSE 0
            END,
C_yn = CASE
                WHEN Job_Description LIKE '% C %'
                         OR Job_Description LIKE '% C,%'
                         OR Job_Description LIKE '% C.'
                         OR Job_Description LIKE '% C.%'
                         OR Job_Description LIKE '%C++%'
                         OR Job_Description LIKE '%C/C++%'THEN 1
                ELSE 0
            END,
JavaScript_yn = CASE
                WHEN Job_Description LIKE '%JavaScript%' THEN 1
                ELSE 0
            END,
Swift_yn = CASE
                WHEN Job_Description LIKE '% Swift %' 
                         OR Job_Description LIKE '% Swift,%'
                         OR Job_Description LIKE '% Swift/%'
                         OR Job_Description LIKE '% Swift.'
                         OR Job_Description LIKE '% Swift.%' THEN 1
                ELSE 0
            END,
Go_yn = CASE
                WHEN Job_Description COLLATE Latin1_General_BIN LIKE '% Go %' 
                         OR Job_Description COLLATE Latin1_General_BIN LIKE '% Go,%'
                         OR Job_Description COLLATE Latin1_General_BIN LIKE '% Go/%'
                         OR Job_Description COLLATE Latin1_General_BIN LIKE '% Go.'
                         OR Job_Description COLLATE Latin1_General_BIN LIKE '% Go.%'
                         OR Job_Description LIKE '%Golang%' THEN 1
                ELSE 0
            END,
MATLAB_yn = CASE
                WHEN Job_Description LIKE '%MATLAB%' THEN 1
                ELSE 0
            END,
SAS_yn = CASE
                WHEN Job_Description COLLATE Latin1_General_BIN LIKE '% SAS %' 
                         OR Job_Description COLLATE Latin1_General_BIN LIKE '% SAS,%'
                         OR Job_Description COLLATE Latin1_General_BIN LIKE '% SAS/%'
                         OR Job_Description COLLATE Latin1_General_BIN LIKE '% SAS.'
                         OR Job_Description COLLATE Latin1_General_BIN LIKE '% SAS.%' THEN 1
                ELSE 0
            END,
Pandas_yn = CASE
                WHEN Job_Description LIKE '%Pandas%' THEN 1
                ELSE 0
            END;


-- input the sum of all programming languages into a different table
-- table name: "Programming Language count in Data Job Descriptions"
SELECT
    SUM(CAST([Python_yn] AS INT)) AS Python,
    SUM(CAST([R_yn] AS INT)) AS R,
    SUM(CAST([SQL_yn] AS INT)) AS SQL,
    SUM(CAST([Java_yn] AS INT)) AS Java,
    SUM(CAST([Scala_yn] AS INT)) AS Scala,
    SUM(CAST([C_yn] AS INT)) AS C,
    SUM(CAST([Javascript_yn] AS INT)) AS Javascript,
    SUM(CAST([Swift_yn] AS INT)) AS Swift,
    SUM(CAST([Go_yn] AS INT)) AS Golang,
    SUM(CAST([MATLAB_yn] AS INT)) AS MATLAB,
    SUM(CAST([SAS_yn] AS INT)) AS SAS,
    SUM(CAST([Pandas_yn] AS INT)) AS Pandas
INTO Prog_lang_count -- making new table for the sums
FROM Glassdoor_Data_Jobs;

-- this is for separate tables for each data job (previous code would be pasted before, new table name would be changed)
WHERE [Job_Title_Classification] = 'Data Scientist';
WHERE [Job_Title_Classification] = 'Data Engineer';
WHERE [Job_Title_Classification] = 'Data Analyst';

-- convert from columns to rows
SELECT 
    Language,
    Mention_Count
INTO Program_Lang_Count
FROM (
    SELECT 
        [Python], [R], [SQL], [Java], [Scala], 
        [C], [Javascript], [Swift], [Golang], [MATLAB], 
        [SAS], [Pandas]
    FROM Prog_lang_count
) AS SourceTable
UNPIVOT (
    Mention_Count FOR Language IN 
        ([Python], [R], [SQL], [Java], [Scala], 
         [C], [Javascript], [Swift], [Golang], [MATLAB], 
         [SAS], [Pandas])
) AS UnpivotedTable;

-- add primary key to identify each job
ALTER TABLE Program_Lang_Count
ADD id INT IDENTITY(1,1) PRIMARY KEY;





-- do this for data science, analyist, and engineering
-- Step 1: Add the column to the target table
ALTER TABLE Program_Lang_Count
ADD Data_Science_Count INT;

-- Step 2: Update the target table with the values from the source table
UPDATE Program_Lang_Count
SET Program_Lang_Count.Mention_Count = PL_count_DataSci.Data_Sci_Count
FROM Program_Lang_Count
JOIN PL_count_DataSci
    ON Program_Lang_Count.[Language] = PL_count_DataSci.Language;
    
    
    

-- Step 1: Add a new column for percentage
ALTER TABLE Program_Lang_Count
ADD Percentage DECIMAL(5, 4);

-- Step 2: Update the new column with the calculated percentage
UPDATE Program_Lang_Count
SET Percentage = (Mention_Count / 742.0);