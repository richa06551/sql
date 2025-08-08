# Sql: Feed Assignment
## Project Overview
This project is part of the foundational SQL learning assignment and focuses on developing hands-on experience with Data Manipulation Language (DML) and Data Definition Language (DDL) operations. The key objective is to simulate data feeds with varying structures, automate the generation process, identify and handle duplicate records, and validate data consistency using structured SQL scripts.
## Requirement 1: Manual Data Feed Creation
Created three SQL tables to simulate different data feeds:
Feed_1: 10 columns × 10 rows,
Feed_2: 15 columns × 15 rows,
Feed_3: 20 columns × 20 rows,
Each table was manually populated with randomized data values.
![1](https://github.com/user-attachments/assets/7af72fb4-a3cd-4d13-94ba-6833e23cda70)
![2](https://github.com/user-attachments/assets/730f20da-ed0b-431d-8409-42a14db26017)
## Requirement 2: Automated Data Feed Generation
A stored procedure InsertData(feedName, rowCount) was created to automate table population. This accepts: feedName (e.g., Feed_1), rowCount (e.g., 10)
Key Features:
1. Dynamically populates the required number of rows.
2. Uses functions like RAND(), CONCAT(), and ELT() for generating pseudo-random values.
3. Includes validations to avoid incorrect feed names.
![2](https://github.com/user-attachments/assets/51e7bb40-eeb4-4160-b99d-c1c659caaf5a)
![3](https://github.com/user-attachments/assets/a8d318b2-d6c2-4da0-bc30-426dfdb64f76)
![4](https://github.com/user-attachments/assets/dbb34018-e924-4be2-baf5-b3be394750dc)
![5](https://github.com/user-attachments/assets/fb81f42f-1b5f-426a-8d07-e463dfaa28fc)
![6](https://github.com/user-attachments/assets/53b031b9-7d79-4003-a4e8-6d9c47d5aad5)
## Req 3 & 4: Identify and Write Duplicate Records
SQL scripts were created to detect duplicate rows in each of the Feed tables (Feed1, Feed2, Feed3) based on all column values. The duplicates were identified using GROUP BY and HAVING COUNT(*) > 1. These duplicate records were extracted and written into an output table named duplicates for review and further action.
![17](https://github.com/user-attachments/assets/d5c56b9d-cc4d-48ca-8c23-bcad5e062f27)
![18](https://github.com/user-attachments/assets/05c0fb29-eb34-4a12-8103-7e41ffe148fc)
## Requirement 5: Replace Duplicates with Unique Rows
Designed a script to:
1. Delete duplicate rows while keeping one instance.
2. Re-populate the table with unique entries using the data generation script to restore row count.
![10](https://github.com/user-attachments/assets/cd2b19f3-9111-4301-bf18-7677e70bedb8)
![11](https://github.com/user-attachments/assets/adf2d892-f7ac-4e8a-a934-26eb2b8a851d)
## Requirement 6: Post-Validation of Duplicate Removal
Re-ran the duplicate detection scripts to ensure:
1. Zero duplicates present in all Feed tables post-processing.
2. Validation queries were documented via screenshots.
![11](https://github.com/user-attachments/assets/ba7d9ff8-62fb-45e3-978c-b1a0cf4ccef6)
![12](https://github.com/user-attachments/assets/2d949872-d8cc-4e9b-9299-d7f4c16ee775)
![13](https://github.com/user-attachments/assets/b49d1162-0faf-47ab-bc53-5afca02d3fad)
## Requirement 7: Data Comparison Across Feeds
Created a script to compare Feed_2 and Feed_3 with Feed_1 on overlapping columns.
Comparison Logic:
1. Matching keys and common columns were compared.
2. Differences were logged into an output file comparison_results.csv.
![13](https://github.com/user-attachments/assets/01c90291-c01e-4cb7-a37b-a0834e50b2aa)
![14](https://github.com/user-attachments/assets/e83b0e10-fad0-4174-85d7-f32f1265eb4b)
![15](https://github.com/user-attachments/assets/9fd968f7-3d26-4c56-bf5c-90e14cc19c81)
## Requirement 8: Write Common Records Across All Feeds
### Objective:
To validate that the SQL logic correctly identifies and inserts only those records that are present in all three feed tables (Feed1, Feed2, and Feed3) into a new table called common_records.

### Test Scenarios & Manual Test Cases
![20](https://github.com/user-attachments/assets/ffeae047-2cdb-4bf3-8fc2-6274d8538c30)

### Assumptions:
1. The matching logic is based on all four columns: name, city, dept, and manager.
2. MySQL is used (doesn’t support INTERSECT natively), so joins are used to simulate the behavior.
## Requirement 9: Test Case Automation
Developed a repeatable SQL automation process:
1. Combined multiple stored procedures in a test harness procedure: TestAllFeeds().
2. Automates population, duplication check, correction, and validation.
Where applicable, procedures and views have been created to mimic automation pipelines.
![16](https://github.com/user-attachments/assets/cb648316-a277-4edc-b0df-a70eb2e2aec4)


