--SQL Advance Case Study
	USE db_SQLCaseStudies

--Q1--BEGIN 

	SELECT DISTINCT 
		A.State FROM DIM_LOCATION AS A
	INNER JOIN 
		FACT_TRANSACTIONS AS B
	ON 
		A.IDLocation = B.IDLocation
	WHERE 
		YEAR(B.DATE) >=2005 

--Q1--END

--Q2--BEGIN
	
	SELECT TOP 1 
		LOC.State AS US_STATE, 
		SUM(FT.Quantity) AS TOTAL_QUANTITY 
	FROM 
		FACT_TRANSACTIONS AS FT
	INNER JOIN 
		DIM_LOCATION AS LOC
		ON FT.IDLocation=LOC.IDLocation
	INNER JOIN 
		DIM_MODEL AS M
		ON 
		FT.IDModel=M.IDModel
	INNER JOIN
		DIM_MANUFACTURER AS MN
		ON M.IDManufacturer=MN.IDManufacturer
	WHERE 
		MN.Manufacturer_Name = 'SAMSUNG'
	GROUP BY 
		LOC.State
	ORDER BY 
		SUM(FT.Quantity) DESC

--Q2--END

--Q3--BEGIN      
	
	SELECT 
		M.Model_Name,
		LOC.ZipCode,
		LOC.State AS STATE_NAME,
		COUNT(FT.IDCustomer) AS NO_OF_TRANSACTIONS
	FROM 
		FACT_TRANSACTIONS AS FT
	INNER JOIN 
		DIM_MODEL AS M
	ON 
		FT.IDModel=M.IDModel
	INNER JOIN 
		DIM_LOCATION AS LOC
	ON 
		FT.IDLocation = LOC.IDLocation
	GROUP BY
		M.Model_Name,
		LOC.ZipCode,
		LOC.State

--Q3--END

--Q4--BEGIN
	
	SELECT TOP 1 
		M.Model_Name,
		MN.Manufacturer_Name,
		M.Unit_price 
	FROM 
		DIM_MODEL AS M
	INNER JOIN
		DIM_MANUFACTURER AS MN
	ON
		M.IDManufacturer=MN.IDManufacturer
	GROUP BY 
		M.Model_Name,
		MN.Manufacturer_Name,
		M.Unit_price
	ORDER BY 
		M.Unit_price

--Q4--END

--Q5--BEGIN

	WITH Top5Manufacturers AS (
			SELECT 
			    M.IDManufacturer,
			    SUM(FT.Quantity) AS Total_Quantity
			FROM 
			    FACT_TRANSACTIONS FT
			INNER JOIN 
			    DIM_MODEL M ON FT.IDModel = M.IDModel
			GROUP BY 
			    M.IDManufacturer
			ORDER BY 
			    Total_Quantity DESC
			OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY
	)
	SELECT 
	    M.Model_Name,
	    AVG(M.Unit_price) AS Avg_Price
	FROM 
	    DIM_MODEL M
	INNER JOIN 
	    Top5Manufacturers TM ON M.IDManufacturer = TM.IDManufacturer
	GROUP BY 
	    M.Model_Name
	ORDER BY 
		Avg_Price

--Q5--END

--Q6--BEGIN

	SELECT 
		C.Customer_Name,
		AVG(FT.TotalPrice) AS AVERAGE_AMOUNT_SPENT
	FROM 
		FACT_TRANSACTIONS AS FT
	INNER JOIN
		DIM_CUSTOMER AS C
	ON
		FT.IDCustomer=C.IDCustomer
	WHERE 
		YEAR(FT.Date) = '2009'
	GROUP BY 
		C.Customer_Name
	HAVING
		AVG(FT.TotalPrice) > 500

--Q6--END
	
--Q7--BEGIN  
	
	WITH TOPMODEL AS (
			SELECT 
				M.Model_Name,
				D.YEAR,
				SUM(FT.Quantity) AS TOTAL_QUANTITY,
				RANK() OVER(PARTITION BY D.YEAR ORDER BY SUM(FT.QUANTITY) DESC) AS RANK
			FROM 
				FACT_TRANSACTIONS AS FT
			INNER JOIN 
				DIM_MODEL AS M
			ON	
				FT.IDModel=M.IDModel
			INNER JOIN
				DIM_DATE AS D
			ON 
				FT.Date=D.DATE
			WHERE
				D.YEAR IN (2008, 2009, 2010)
			GROUP BY 
				M.Model_Name,
				D.YEAR	
	)
	SELECT
		MODEL_NAME
	FROM
		TOPMODEL
	WHERE
		RANK <=5
	GROUP BY
		MODEL_NAME
	HAVING
		COUNT(DISTINCT YEAR) = 3

--Q7--END	
--Q8--BEGIN

	WITH TopSales AS (
			SELECT 
				MN.Manufacturer_Name,
				SUM(FT.TotalPrice) AS TOTAL_SALES,
				D.YEAR,
				RANK() OVER(PARTITION BY D.YEAR ORDER BY SUM(FT.TOTALPRICE) DESC) AS SALES_RANK
			FROM 
				FACT_TRANSACTIONS AS FT
			INNER JOIN 
				DIM_DATE AS D
			ON
				FT.Date=D.DATE
			INNER JOIN 
				DIM_MODEL AS M
			ON 
				FT.IDModel=M.IDModel
			INNER JOIN
				DIM_MANUFACTURER AS MN
			ON
				M.IDManufacturer=MN.IDManufacturer
			WHERE 
				D.YEAR IN (2009, 2010)
			GROUP BY
				MN.Manufacturer_Name,
				D.YEAR	
	)
	SELECT
		MANUFACTURER_NAME,
		YEAR,
		TOTAL_SALES
	FROM
		TopSales
	WHERE 
		(YEAR = 2009 AND SALES_RANK = 2)
    OR
		(YEAR = 2010 AND SALES_RANK = 2)

--Q8--END
--Q9--BEGIN
	
	WITH SalesByYear AS (		
			SELECT DISTINCT 
				MN.IDManufacturer,
				MN.Manufacturer_Name,
				D.YEAR
			FROM 
				FACT_TRANSACTIONS AS FT
			INNER JOIN 
				DIM_MODEL AS M
			ON
				FT.IDModel=M.IDModel
			INNER JOIN 
				DIM_MANUFACTURER AS MN
			ON
				M.IDManufacturer=MN.IDManufacturer
			INNER JOIN 
				DIM_DATE AS D
			ON
				FT.Date=D.DATE
			WHERE
				D.YEAR IN (2009, 2010)
			GROUP BY 
				MN.IDManufacturer,
				MN.Manufacturer_Name,
				D.YEAR
	)
	SELECT
		MANUFACTURER_NAME
	FROM 
		SalesByYear
	WHERE 
		YEAR = 2010
		AND IDManufacturer NOT IN (
			SELECT IDManufacturer
			FROM SalesByYear
			WHERE YEAR = 2009
		)

--Q9--END

--Q10--BEGIN
	
	WITH RankedCustomers AS(
			SELECT
				C.IDCustomer,
				C.Customer_Name,
				D.YEAR,
				AVG(FT.TotalPrice) AS AVG_SPEND,
				AVG(FT.QUANTITY) AS AVG_QUANTITY,
				RANK() OVER (PARTITION BY D.YEAR ORDER BY AVG(FT.TOTALPRICE) DESC) AS Rank_
				FROM 
					FACT_TRANSACTIONS AS FT
				INNER JOIN
					DIM_CUSTOMER AS C
				ON
					FT.IDCustomer=C.IDCustomer
				INNER JOIN
					DIM_DATE AS D
				ON
					FT.Date=D.DATE
				GROUP BY
					C.IDCustomer,
					C.Customer_Name,
					D.YEAR
	)
	SELECT 
		R1.Customer_Name,
		R1.YEAR AS Year1,
		R1.Avg_Spend AS Avg_Spend_Year1,
		R2.YEAR AS Year2,
		R2.Avg_Spend AS Avg_Spend_Year2,
    CASE 
        WHEN R1.Avg_Spend = 0 THEN NULL
        ELSE ((R2.Avg_Spend - R1.Avg_Spend) / R1.Avg_Spend) * 100 
    END AS Percentage_Change
	FROM 
		RankedCustomers R1
	JOIN 
		RankedCustomers R2
    ON 
		R1.IDCustomer = R2.IDCustomer
		AND R1.Rank_ <= 100
		AND R2.Rank_ <= 100
		AND R1.YEAR = R2.YEAR - 1

--Q10--END
	