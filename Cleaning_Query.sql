CREATE PROCEDURE basic_table
AS
SELECT *
FROM Transactions
GO;

---- Find Entry Errors ----
select Merchant, count(Merchant)
From Transactions
Group by Merchant

select Category, count(Category)
from Transactions
Group by Category

select Account_Type 
From Transactions
Group by Account_Type

select Transaction_Type, count(Transaction_Type)
From Transactions
Group By Transaction_Type
----------------------------------------------------

---- Correct Entry Errors ----

/* 
All of these errors are known in advance and require little 
outside judgement. These errors were mainly spelling but some contain
mis-labeled entries.
*/

UPDATE Transactions
SET Merchant = 'AB Country Store'
WHERE Merchant = 'AB Country'

UPDATE Transactions
SET Merchant = 'AB Country Store'
WHERE Merchant = 'ABC Country Store'

UPDATE Transactions
SET Merchant = 'Alliance Bank'
WHERE Merchant = 'Allianz Event'

UPDATE Transactions
SET Merchant = 'Board & Bites'
WHERE Merchant = 'Boards & Bites'

UPDATE Transactions
SET Merchant = 'Brookshires'
WHERE Merchant = 'Brookshire'

UPDATE Transactions
SET Merchant = 'Capital One'
WHERE Merchant = 'Caital One'

UPDATE Transactions
SET Merchant = 'Capital One'
WHERE Merchant = 'Capitald One'

UPDATE Transactions
SET Merchant = 'Capital One'
WHERE Merchant = 'Captial One'

UPDATE Transactions
SET Merchant = 'Coca Cola'
WHERE Merchant = 'Coca Cola Tyler'

UPDATE Transactions
SET Merchant = 'Goolsbees Tire Service'
WHERE Merchant = 'Goolsbee Tire Service'

UPDATE Transactions
SET Merchant = 'Goolsbees Tire Service'
WHERE Merchant = 'Goolsbee'

UPDATE Transactions
SET Merchant = 'Mcdonald'
WHERE Merchant = 'Mcdonalds'

UPDATE Transactions
SET Merchant = 'Netflix'
WHERE Merchant = 'Netlix'

UPDATE Transactions
SET Merchant = 'Southside Bank'
WHERE Merchant = 'Southside Banke'

UPDATE Transactions
SET Merchant = 'Sports Clip'
WHERE Merchant = 'Sports Clips'

UPDATE Transactions
SET Merchant = 'TC'
WHERE Merchant = 'TC Broadway'

UPDATE Transactions
SET Merchant = 'TJC'
WHERE Merchant = 'Tyler Junior College'

UPDATE Transactions
SET Merchant = 'TJC'
WHERE Merchant = 'TJC Bookstore'

UPDATE Transactions
SET Merchant = 'US Derm'
WHERE Merchant = 'US Dermatology Partners'

UPDATE Transactions
SET Category = 'Credit Card'
WHERE Category = 'Credit Car'

UPDATE Transactions
SET Category = 'Credit Card'
WHERE Category = 'Credit Car'

UPDATE Transactions
SET Category = 'Entertainment'
WHERE Category = 'Entertaiment'

UPDATE Transactions
SET Category = 'Fuel'
WHERE Category = 'Gas'

UPDATE Transactions
SET Category = 'Interest Deposit'
WHERE Category = 'Interest'

UPDATE Transactions
SET Category = 'Interest Deposit'
WHERE Category = 'Interest Income'

UPDATE Transactions
SET Category = 'Loan'
WHERE Category = 'Student Loan'

UPDATE Transactions
SET Category = 'Transfer'
WHERE Category = 'Transefer'

UPDATE Transactions
SET Transaction_Type = 'Income'
WHERE Transaction_Type = 'Payroll'

UPDATE Transactions
SET Transaction_Type = 'Income'
WHERE Transaction_Type = 'Refund'

UPDATE Transactions
SET Transaction_Type = 'Payment'
WHERE Transaction_Type = 'Income' and Account_Type = 'Platinum'

-------------------------------------

---- Trim Extra Spaces ----

UPDATE Transactions
SET Merchant = TRIM(Merchant)

UPDATE Transactions
SET Category = TRIM(Category)

UPDATE Transactions
SET Account_Type = TRIM(Account_Type)

UPDATE Transactions
SET Transaction_Type = TRIM(Transaction_Type)

ALTER TABLE transactions
ALTER COLUMN Amount decimal(16,2)

---- Remove Duplicates ----

WITH find_row AS (
SELECT *, ROW_NUMBER() OVER (
			PARTITION BY
				Transaction_ID,
				Date,
				Merchant,
				Category,
				Account_Type,
				Transaction_Type,
				Amount
			ORDER BY
				Transaction_ID
				) row_num
FROM Transactions
)

SELECT *
FROM find_row
WHERE row_num > 1

-- No duplicates found --

---- Missing Data ----

SELECT *
FROM Transactions
WHERE Transaction_Type = ' ' -- To save space, this query is used once and Transaction_Type is swapped to other column names as needed.

-- Don't want Null values
SELECT ISNULL(Holdings_ID, 'None') as Holdings_ID
FROM Transactions

UPDATE Transactions
SET Holdings_ID = 'None'
WHERE Holdings_ID IS NULL

---- Date ----

ALTER TABLE Transactions
ADD Year int

UPDATE Transactions
SET Year = DATEPART(year, Date)

ALTER TABLE Transactions
ADD Month int

UPDATE Transactions
SET Month = DATEPART(month, Date)

ALTER TABLE Transactions
ADD Day int

UPDATE Transactions
SET Day = DATEPART(day, Date)

---- Non capitalized words ----

UPDATE Transactions
SET Holdings_ID = LOWER(Holdings_ID)

UPDATE Transactions
SET Merchant = LOWER(Merchant)

UPDATE Transactions
SET Category = LOWER(Category)

UPDATE Transactions
SET Account_Type = LOWER(Account_Type)

UPDATE Transactions
SET Transaction_Type = LOWER(Transaction_Type)

--------------------------------------

EXEC basic_table