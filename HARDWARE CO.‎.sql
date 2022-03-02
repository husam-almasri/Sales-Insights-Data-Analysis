# Show tables in the database
Show tables FROM atliq;‎

# customer table:‎
‎# Show all customer records
SELECT * FROM customers;‎
# Check the null values:‎
SELECT * FROM atliq.customers where (custmer_name is null or customer_type is ‎null) ;‎
# Show total number of customers
SELECT count(*) FROM customers;‎

# markets table:‎
‎# Show all markets records
SELECT * FROM markets;‎
# Count unique values of the zone field
SELECT count(distinct (zone)) FROM atliq.markets;‎
SELECT distinct (zone) FROM atliq.markets;‎
‎# Show the rows that have the empty zone
select * from markets where (zone is null or zone="");‎

# products table:‎
# Show all products records
SELECT * FROM products;‎
# Count how many products the company sells
SELECT count(distinct(product_code)) FROM atliq.products;‎
# Count unique values of the product_type field
SELECT distinct (product_type) FROM atliq.products;‎

# transactions table:‎
# Show all transactions records
SELECT * FROM transactions;‎
# Count how many transactions the company did.‎
SELECT count(*) FROM atliq.transactions; ‎
# Show the first and last transaction dates
SELECT order_date FROM transactions order by order_date limit 1;‎
SELECT order_date FROM transactions order by order_date desc limit 1;‎
# Show transactions for Chennai market (market code for chennai is Mark001‎
SELECT * FROM transactions where market_code='Mark001';‎
# Show distrinct product codes that were sold in chennai
SELECT distinct product_code FROM transactions where market_code='Mark001';‎
# Show any transaction amounts under 1‎
select count(*) from transactions where atliq_amount<1;‎
# Show any order has quantities under 1‎
select count(*) from transactions where atliq_qty<1;‎
# Show transactions’ currency unique values
‎SELECT distinct currency FROM transactions;‎
# Show transactions where currency is US dollars
SELECT * from transactions where currency="USD"‎
# Show transactions in 2020 join by date table
SELECT transactions.* FROM transactions INNER JOIN date ON ‎transactions.order_date=date.date where date.year=2020;‎
# Show total revenue in year 2020,‎
SELECT SUM(transactions.atliq_amount) FROM transactions INNER JOIN date ON ‎transactions.order_date=date.date where date.year=2020;‎
# Show total revenue in year 2020, January Month,‎
SELECT SUM(transactions.atliq_amount) FROM transactions INNER JOIN date ON ‎transactions.order_date=date.date where date.year=2020 and ‎date.month_name="January" ;‎
# Show total revenue in year 2020 in Chennai
SELECT SUM(transactions.atliq_amount) FROM transactions INNER JOIN date ON ‎transactions.order_date=date.date where date.year=2020 and ‎transactions.market_code="Mark001";‎
#ETL
# Filter the international markets 
DELETE FROM markets where zone="";‎
# Show how many transactions have atliq amount less than 1 INR‎
‎ select count(*) from transactions where atliq_amount<1;‎
# Filtering the data that have atliq_amount less than 1 INR‎
SELECT * FROM atliq.transactions;‎
SELECT count(*) FROM atliq.transactions;‎
delete from transactions where atliq_amount<1;‎
SELECT count(*) FROM atliq.transactions;‎
SELECT * FROM atliq.transactions;‎
# Check the currency field
SELECT count(*) FROM atliq.transactions where currency="INR\r" or currency="USD\r";‎
SELECT count(*) FROM atliq.transactions where currency="INR" or currency="USD";‎
# Check these values to see if they are related to the others‎
SELECT *,COUNT(*)‎
FROM atliq.transactions
GROUP BY product_code,customer_code,market_code,order_date,atliq_qty,atliq_amount
HAVING COUNT(*) > 1 order by currency;‎
# Filter the duplicated data
delete FROM atliq.transactions where currency="USD";‎
delete FROM atliq.transactions where currency="INR";‎
# Rename the currency to move the typos:‎
update transactions set currency=replace(currency,"INR\r","INR");‎
update transactions set currency=replace(currency,"USD\r","USD");‎
SELECT count(distinct currency) FROM atliq.transactions where currency="INR" or ‎currency="USD";‎
