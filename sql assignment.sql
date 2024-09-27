-- SQL Last ASSIGNMENT 

-- DATABASE Project
create database Project2;
USE Project2;

-- Query 1
select 'Customer ID' , count('Customer ID')
from service
group by 'Customer ID'
having count('Customer ID') > 1;

with service as (
select a.'Customer ID' , a.'Contract' as contract_type,
avg('Monthly Charge') over ( partition by 'Customer ID' order by 'Monthly Charge' desc)
as average_monthly_charges, b.Customer Status
from service a
join customer_status b
on a.'Customer ID' = b.'Customer ID'
where b.'Customer_Status' = 'churned')
select a.*, b.'Age', b.'Gender'
from service a
join demographics b
on a.'Customer_ID' = b.'Customer_ID'
order by a.average_monthly_charges desc
limit 5;

-- Query 2

SELECT s.'Customer ID', s.'Contract' AS contract_type, s.'Monthly Charge', st.'Customer Status', st.'Churn Reason'
FROM service s
JOIN customer_status st
ON S.'Customer ID' = st.'Customer ID'
WHERE st.'Customer Status' = 'churned'
AND st.'Churn Reason' IS NOT NULL;


-- Query 3

SELECT s.'Payment Method' , COUNT(st.'Customer ID') AS total_customers,
 SUM(CASE WHEN st.'Churn Label' = 'Yes' THEN 1 ELSE 0 END) AS 'churned_customers',
ROUND(SUM(CASE WHEN st.'Churn Label' = 'Yes' THEN 1 ELSE 0 END) / COUNT(st.'Customer ID') * 100, 2) AS churn_rate_percentage
FROM service s
JOIN customer_status st
ON s.'Customer ID' = st.'Customer ID'
GROUP BY s.'Payment Method'
ORDER BY churn_rate_percentage DESC;

