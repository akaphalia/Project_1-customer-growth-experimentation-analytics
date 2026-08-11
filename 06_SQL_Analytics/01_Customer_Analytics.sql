-- =====================================================
-- Business Question 1
-- =====================================================
-- Objective:
-- How many customer records exist, and how many unique customers has Olist served?

SELECT
    COUNT(customer_id) AS total_customer_records,
    COUNT(DISTINCT customer_unique_id) AS unique_customers,
    COUNT(customer_id) - COUNT(DISTINCT customer_unique_id) AS difference
FROM customers;

/* Business Insight:
-- Olist has served 96,096 unique customers through 99,441 customer records. 
The difference between total records and unique customers indicates that some customers have made multiple purchases, 
suggesting the presence of repeat buying behavior. 
The exact number of repeat customers will be analyzed in a subsequent query.
*/



-- =====================================================
-- Business Question 2
-- =====================================================
-- Objective:
-- Which states have the highest number of unique customers?

SELECT
    customer_state,
    COUNT(DISTINCT customer_unique_id) AS total_customers
FROM customers
GROUP BY customer_state
ORDER BY total_customers DESC;

-- Percentage for the same can be calculated as:
SELECT
    customer_state,
    COUNT(DISTINCT customer_unique_id) AS total_customers,
    CAST(
        COUNT(DISTINCT customer_unique_id) * 100.0 /
        SUM(COUNT(DISTINCT customer_unique_id)) OVER ()
     AS DECIMAL(5,2)) as customer_percentage
FROM customers
GROUP BY customer_state
ORDER BY total_customers DESC;

-- =====================================================
-- Business Question 3
-- =====================================================
-- Objective:
-- How many customers are repeat customers, and what is the repeat customer rate?
SELECT
    COUNT(*) AS repeat_customers
FROM
(
    SELECT
        customer_unique_id
    FROM customers
    GROUP BY customer_unique_id
    HAVING COUNT(*) > 1
) AS repeat_buyers;

WITH repeat_customers AS
(
    SELECT
        customer_unique_id
    FROM customers
    GROUP BY customer_unique_id
    HAVING COUNT(*) > 1
)

SELECT
    COUNT(*) AS repeat_customers,
    (SELECT COUNT(DISTINCT customer_unique_id) FROM customers) AS total_unique_customers,
    CAST(
        COUNT(*) * 100.0 /
        (SELECT COUNT(DISTINCT customer_unique_id) FROM customers)
        AS DECIMAL(5,2)
    ) AS repeat_customer_rate
FROM repeat_customers;

-- Business Insight:
-- Olist has 2,997 repeat customers out of 96,096 unique customers,
-- resulting in a repeat customer rate of 3.12%.
-- This indicates that only a small proportion of customers returned
-- to make another purchase, highlighting a significant opportunity
-- to improve customer retention through loyalty programs, personalized
-- marketing, and a better post-purchase experience.



-- =====================================================
-- Business Question 4
-- =====================================================
-- Objective:
-- How many orders does the average customer place?
SELECT
    CAST(
        COUNT(o.order_id) * 1.0 /
        COUNT(DISTINCT c.customer_unique_id)
        AS DECIMAL(5,2)
    ) AS average_orders_per_customer
FROM customers AS c
INNER JOIN orders AS o
    ON c.customer_id = o.customer_id;

    -- Business Insight:
-- On average, each customer places 1.03 orders on the Olist platform.
-- This indicates that most customers make only a single purchase,
-- with relatively few returning for additional orders. Combined with
-- the repeat customer rate of 3.12%, this suggests that improving
-- customer retention should be a strategic priority for Olist.



-- =====================================================
-- Business Question 4
-- =====================================================
-- Objective:
-- How many new customers were acquired each month?

WITH first_purchase AS
(
    SELECT
        c.customer_unique_id,
        MIN(o.order_purchase_timestamp) AS first_purchase_date
    FROM customers AS c
    INNER JOIN orders AS o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_unique_id
)

SELECT
    YEAR(first_purchase_date) AS purchase_year,
    MONTH(first_purchase_date) AS purchase_month,
    COUNT(*) AS new_customers
FROM first_purchase
GROUP BY
    YEAR(first_purchase_date),
    MONTH(first_purchase_date)
ORDER BY
    purchase_year,
    purchase_month;

-- Business Insight:
-- Customer acquisition increased steadily from late 2016 through 2018,
-- with the highest acquisition occurring in early and mid-2018.
-- The unusually low counts in September and October 2018 are due to the dataset ending during that period and should 
-- not be interpreted as a sudden decline in customer acquisition.

-- =====================================================
-- Business Question 5
-- =====================================================
-- Objective:
-- How has Olist's cumulative customer base grown over time?

WITH first_purchase AS
(
    SELECT
        c.customer_unique_id,
        MIN(o.order_purchase_timestamp) AS first_purchase_date
    FROM customers AS c
    JOIN orders AS o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_unique_id
),
monthly_customers AS
(
    SELECT
        DATEFROMPARTS(
            YEAR(first_purchase_date),
            MONTH(first_purchase_date),
            1
        ) AS purchase_month,
        COUNT(*) AS new_customers
    FROM first_purchase
    GROUP BY
        DATEFROMPARTS(
            YEAR(first_purchase_date),
            MONTH(first_purchase_date),
            1
        )
)

SELECT
    FORMAT(purchase_month, 'yyyy-MM') AS purchase_month,
    new_customers,
    SUM(new_customers) OVER (
        ORDER BY purchase_month
        ROWS UNBOUNDED PRECEDING
    ) AS cumulative_customers
FROM monthly_customers
ORDER BY purchase_month;


-- =====================================================
-- Business Question 6
-- =====================================================
-- Objective:
-- How many new and repeat customers did Olist have each month?

WITH first_purchase AS
(
    SELECT
        c.customer_unique_id,
        MIN(DATEFROMPARTS(
            YEAR(o.order_purchase_timestamp),
            MONTH(o.order_purchase_timestamp),
            1
        )) AS first_purchase_month
    FROM customers AS c
    JOIN orders AS o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_unique_id
),

monthly_orders AS
(
    SELECT
        c.customer_unique_id,
        DATEFROMPARTS(
            YEAR(o.order_purchase_timestamp),
            MONTH(o.order_purchase_timestamp),
            1
        ) AS order_month
    FROM customers AS c
    JOIN orders AS o
        ON c.customer_id = o.customer_id
)

SELECT
    FORMAT(m.order_month, 'yyyy-MM') AS order_month,
    COUNT(DISTINCT CASE
        WHEN m.order_month = f.first_purchase_month
        THEN m.customer_unique_id
    END) AS new_customers,

    COUNT(DISTINCT CASE
        WHEN m.order_month > f.first_purchase_month
        THEN m.customer_unique_id
    END) AS repeat_customers

FROM monthly_orders AS m
JOIN first_purchase AS f
    ON m.customer_unique_id = f.customer_unique_id

GROUP BY m.order_month
ORDER BY m.order_month;


-- Business Insight:
-- Olist's customer growth was driven primarily by acquiring new customers rather than retaining existing ones. 
-- Throughout the analysis period,monthly new customer acquisitions consistently outnumbered repeat customers.
--
-- Although repeat customers gradually increased over time, they remained a small proportion of the monthly customer 
-- base, indicating significant opportunities to improve customer retention through loyalty programs,personalized 
-- marketing, and enhanced post-purchase experiences.



-- =====================================================
-- Business Question 7
-- =====================================================
-- Objective:
-- What is the average Customer Lifetime Value (CLV) (based on 'delivered' orders)?

WITH customer_clv AS
(
    SELECT
        c.customer_unique_id,
        SUM(p.payment_value) AS customer_lifetime_value
    FROM customers AS c
    INNER JOIN orders AS o
        ON c.customer_id = o.customer_id
    INNER JOIN payments AS p
        ON o.order_id = p.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_unique_id
)

SELECT
    COUNT(*) AS customers,
    CAST(
        AVG(customer_lifetime_value)
        AS DECIMAL(10,2)
    ) AS average_customer_lifetime_value
FROM customer_clv;

-- Business Insight:
-- Among customers with at least one delivered order, the average Customer Lifetime Value (CLV) is 165.20. 
-- This represents the average revenue generated per customer from completed purchases.
-- Customers without any delivered orders are excluded because they did not generate realized revenue.



-- =====================================================
-- Business Question 8
-- =====================================================
-- Objective:
-- Who are Olist's highest-value customers based on delivered orders?

SELECT TOP (10)
    DENSE_RANK() OVER(ORDER BY SUM(payment_value) DESC) AS rank,
    c.customer_unique_id,
    COUNT(DISTINCT o.order_id) AS total_orders,

    CAST(
        SUM(p.payment_value)
        AS DECIMAL(10,2)
    ) AS customer_lifetime_value,

    CAST(
        SUM(p.payment_value) * 1.0 /
        COUNT(DISTINCT o.order_id)
        AS DECIMAL(10,2)
    ) AS average_order_value

FROM customers AS c
INNER JOIN orders AS o
    ON c.customer_id = o.customer_id
INNER JOIN payments AS p
    ON o.order_id = p.order_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_unique_id
ORDER BY customer_lifetime_value DESC

-- Business Insight:
-- The highest-value customer generated a historical CLV of 13,664.08 from a single delivered order. 
-- While several customers contributed significant revenue through individual purchases, others generated value 
-- through multiple transactions, highlighting different customer purchasing patterns. 
-- Olist can use this information to identify VIP customers for targeted retention campaigns and personalized offers.



-- =====================================================
-- Business Question 9
-- =====================================================
-- Objective:
-- How are customers distributed based on their purchase frequency?

WITH customer_orders AS
(
    SELECT
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id) AS total_orders
    FROM customers AS c
    INNER JOIN orders AS o
        ON c.customer_id = o.customer_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_unique_id
)

SELECT
    CASE
        WHEN total_orders = 1 THEN 'One-Time Customer'
        WHEN total_orders BETWEEN 2 AND 3 THEN 'Repeat Customer'
        ELSE 'Loyal Customer'
    END AS customer_segment,

    COUNT(*) AS total_customers,

    CAST(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER ()
        AS DECIMAL(5,2)
    ) AS customer_percentage

FROM customer_orders

GROUP BY
    CASE
        WHEN total_orders = 1 THEN 'One-Time Customer'
        WHEN total_orders BETWEEN 2 AND 3 THEN 'Repeat Customer'
        ELSE 'Loyal Customer'
    END

ORDER BY total_customers DESC;

-- Business Insight:
-- Customer segmentation reveals that 97.00% of customers made only one delivered purchase, while only 2.95% placed 
-- two to three orders.
-- Just 47 customers (0.05%) qualified as loyal customers with four or more delivered orders. 
-- These findings indicate that customer retention is a major opportunity for Olist, 
-- as the vast majority of customers do not return after their initial purchase.