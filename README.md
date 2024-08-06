# Cellphones Information SQL Case Study

## Overview

This project involves analyzing a "Cellphones Information" database, focusing on cell phone sales data. Key tasks include querying data for customer purchases, top-selling states, transaction counts, and pricing insights.

## Database Schema

The database schema includes the following tables:

- **DIM_MANUFACTURER**: Details about manufacturers.
- **DIM_MODEL**: Details about cell phone models.
- **DIM_CUSTOMER**: Customer information.
- **DIM_LOCATION**: Customer locations.
- **FACT_TRANSACTIONS**: Sales transactions data.

## Project Tasks

1. **States with Customer Purchases**: Identify states with customer purchases from 2005 to today.
2. **Top State for Samsung Sales**: Determine which state buys the most Samsung cell phones.
3. **Transactions by Model and Location**: Count transactions for each model per zip code per state.
4. **Cheapest Cellphone**: Find the cheapest cellphone and its price.
5. **Average Price of Models**: Calculate the average price for each model from the top 5 manufacturers based on sales quantity, ordered by average price.
6. **Customer Spending in 2009**: List customer names with average spending over 500 in 2009.
7. **Top Models in 2008, 2009, and 2010**: Identify models that were top 5 in quantity for 2008, 2009, and 2010.
8. **Second Top Manufacturer Sales**: Show the second highest sales manufacturer for 2009 and 2010.
9. **Manufacturers Sales Comparison**: List manufacturers that sold cellphones in 2010 but not in 2009.
10. **Top Customers Analysis**: Find the top 100 customers, their average spend and quantity by year, and calculate spend percentage changes.

## Files

- **schema.sql**: SQL schema for creating database tables.
- **queries.sql**: SQL queries for the tasks mentioned.
- **answer_template.sql**: Template for submitting answers.
