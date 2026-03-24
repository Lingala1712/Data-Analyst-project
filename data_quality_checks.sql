-- DATA QUALITY SUITE
-- Objective: Identify and resolve inconsistencies in client datasets.

-- 1. Check for Duplicate Records (Uniqueness Validation)
SELECT Client_ID, Transaction_Date, COUNT(*) as duplicate_count
FROM Client_Transactions
GROUP BY Client_ID, Transaction_Date
HAVING COUNT(*) > 1;

-- 2. Orphaned Records Check (Referential Integrity)
-- Finding transactions that don't have a matching Master Client ID
SELECT t.Transaction_ID, t.Client_ID
FROM Transactions t
LEFT JOIN Client_Master m ON t.Client_ID = m.Client_ID
WHERE m.Client_ID IS NULL;

-- 3. Null Value Analysis (Completeness Check)
SELECT 
    COUNT(*) as total_records,
    SUM(CASE WHEN Email IS NULL THEN 1 ELSE 0 END) as missing_emails,
    (SUM(CASE WHEN Email IS NULL THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) as null_percentage
FROM Customer_Leads;
