
---------------------------------- AMAZON -------------------------------
---------CREATING A DATABASE --------------

CREATE DATABASE SALES1;

USE SALES1;     ------USING


--------------CREATING TABLE AMAZON1 BY TAKING APPROPRIATE DATA TYPES --------------

CREATE TABLE AMAZON1 (
                         ID INT,
                         BRAND CHAR(10),
						 OFFERPRICE INT,
						 ACTUALPRICE INT,
						 DISCOUNT_PRICE INT,
						 RATING INT,
						 TOTALREVIEWS INT
						 );


------------------ LOADING THE DATA BY USING BULK INSERT METHOD ----------------

Bulk insert AMAZON1
from 'C:\Users\reshm\OneDrive\Desktop\AMAZON1.CSV'
With (format = 'CSV',
       FIRSTROW = 2,
	   FIELDTERMINATOR = ',',
	   ROWTERMINATOR = '\n'
	   );

--------------------- ROWS EFFECTED ---------------------

SELECT * FROM AMAZON1



----------------                  FINDIN SOME MEANING FUL INSIGHTS FROM THE DATA                   ----------------

----------- RATING WISE BRAND -------------

SELECT BRAND , SUM(RATING) AS RATING_WISE 
FROM AMAZON1
GROUP BY BRAND
ORDER BY RATING_WISE DESC;


------------ REVIEW WISE BRAND -----------------

SELECT BRAND , SUM(TOTALREVIEWS) AS REVIEW_WISE 
FROM AMAZON1
GROUP BY BRAND
ORDER BY REVIEW_WISE DESC;


---------------COUNT OF THE PRODUCTS ----------------------

SELECT COUNT(*) AS TOTAL_PRODUCTS 
FROM AMAZON1;


-----------------DISTINCT COUNT OF THE BRANDS ---------------

SELECT COUNT(DISTINCT BRAND) AS BRAND_COUNTS
FROM AMAZON1;


---------LENOVO -------------

SELECT * FROM AMAZON1
WHERE BRAND = 'LENOVO';


---------DELL----------

SELECT * FROM AMAZON1
WHERE BRAND = 'DELL';


-----------HP-----------

SELECT * FROM AMAZON1
WHERE BRAND = 'HP';


----------ACER-----------

SELECT * FROM AMAZON1
WHERE BRAND = 'ACER';


------------FUJITSU---------

SELECT * FROM AMAZON1
WHERE BRAND = 'Fujitsu';


----------HIGHEST PRICE FOR BRAND-------------

SELECT BRAND,MAX(OFFERPRICE) AS HIGHEST_PRICE 
FROM AMAZON1
GROUP BY BRAND
ORDER BY HIGHEST_PRICE DESC;


------------LEAST PRICE FOR BRAND-----------

SELECT BRAND,MIN(OFFERPRICE) AS LEAST_PRICE 
FROM AMAZON1
GROUP BY BRAND
ORDER BY LEAST_PRICE DESC;


-------------MAXIMUM PRICE -----------

SELECT MAX(OFFERPRICE) AS MAXIMUM_PRICE 
FROM AMAZON1;

------------MINIMUM PRICE --------------

SELECT MIN(OFFERPRICE) AS MINIMUM_PRICE 
FROM AMAZON1;


---------- AVERAGE RATING --------------

SELECT BRAND, AVG(Rating) AS avg_rating
FROM AMAZON1
GROUP BY BRAND;



------------CREATING A VIEW INFO ----------------

CREATE VIEW INFO AS
SELECT ID,BRAND, ACTUALPRICE, OFFERPRICE, DISCOUNT_PRICE
FROM AMAZON1;


SELECT * FROM INFO


----------WE CAN ALSO CHECK PARTICULAR FILTER --------------

SELECT * FROM INFO WHERE BRAND = 'Lenovo';


SELECT * FROM AMAZON1



---------------CREATING TRIGGERS WHICH DOESNOT ALLOWS DUPLICATE VALUES ---------------
GO
CREATE TRIGGER PREVENT_DUPLICATES
ON AMAZON1
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted WHERE ID IN (SELECT ID FROM AMAZON1))
    BEGIN
        RAISERROR ('THIS FILE DOESNT EXISTS DUPLICATE VALUES.PLEASE CHOOSE SOME OTHER VALUE', 16, 1)
        ROLLBACK TRANSACTION
    END
    ELSE
        INSERT INTO AMAZON1(ID,BRAND, RATING, TOTALREVIEWS)
        SELECT ID, BRAND, RATING, TOTALREVIEWS
        FROM inserted
END


--------------- BY TAKING THE ID WHICH ALREADY EXISTS WILL NOT ALLOW AND THROWS A ERROR ------------------

INSERT INTO AMAZON1(ID, BRAND, RATING, TOTALREVIEWS)
VALUES(20 , 'DELL' , 8 , 100 )



----------------- CREATING PROCEDURE FOR BRANDS -------------------

GO
CREATE PROCEDURE get_details
    @BRAND VARCHAR(10)
AS
BEGIN
   SELECT *
   FROM AMAZON1
   WHERE [BRAND] = @BRAND;
END;


------------LETS EXCEUTE -------------

EXEC get_details 'LENOVO';




---------------CREATING PROCEDURE FOR TOP RATED PRODUCTS ------------------

GO
  CREATE PROCEDURE TOP_RATED_PRODUCTS
   AS 
     BEGIN
           SELECT * FROM AMAZON1
	  
   WHERE  Rating > 7 
      END;           
 GO



 -------------EXECUTE AND CHECKING --------------

 EXEC TOP_RATED_PRODUCTS



 -----------TRANSACTON ( DELETING THE TABLE WHERE TOTAL REVIEWS LESS THAN 100 ) WITH BEGIN ---------------

BEGIN TRANSACTION 
             SAVE TRANSACTION T
			 DELETE AMAZON1 WHERE TOTALREVIEWS <100;

-------------THE ROWS WILL BE DELETED ----------

SELECT * FROM AMAZON1

------------- BY DOING ROLLBACK TRANSACTION WE CAN GET BACK THE DELETED CELLS FROM THE DATA ---------------
------------------IT CAN BE POSSIBLE WHEN WE STRAT WTH BEGIN -----------------

ROLLBACK TRANSACTION T
 
----------------------------THE END ------------------
-------------------------------------------THANK YOU --------------------------


  


	