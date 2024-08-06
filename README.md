# Cellphones Information SQL Case Study
## Overview:
This project involves analyzing a "Cellphones Information" database, which includes details about cell phone sales, manufacturers, models, customers, locations, and transactions. The goal is to extract insights from the database through SQL queries based on various business questions.

## Database Schema:
The database schema includes the following tables:

DIM_MANUFACTURER: Stores details about manufacturers.
DIM_MODEL: Stores details about cell phone models.
DIM_CUSTOMER: Stores information about customers.
DIM_LOCATION: Stores information about customer locations.
FACT_TRANSACTIONS: Stores sales transactions data.

## Project Tasks:
The project includes several SQL queries to address the following questions:

States with Customer Purchases: Identify states where customers have bought cellphones from 2005 to today.
Top State for Samsung Sales: Find which state in the US is buying the most Samsung cell phones.
Transactions by Model and Location: Show the number of transactions for each model per zip code per state.
Cheapest Cellphone: Display the cheapest cellphone along with its price.
Average Price of Models: Find the average price for each model from the top 5 manufacturers in terms of sales quantity, ordered by average price.
Customer Spending in 2009: List customer names and their average amount spent in 2009, where the average is higher than 500.
Top Models in 2008, 2009, and 2010: Identify models that were in the top 5 in terms of quantity in 2008, 2009, and 2010.
Second Top Manufacturer Sales: Show the manufacturer with the second highest sales in 2009 and 2010.
Manufacturers Sales Comparison: List manufacturers that sold cellphones in 2010 but not in 2009.
Top Customers Analysis: Find the top 100 customers, their average spend and quantity by year, and calculate the percentage change in their spend.

## Files:
schema.sql: Contains the SQL schema to create the database tables.
queries.sql: Contains the SQL queries addressing the tasks mentioned above.
