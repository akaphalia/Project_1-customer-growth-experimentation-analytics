-- =====================================================
-- Business Question 1
-- =====================================================
-- Objective:
-- What is the distribution of order statuses?

SELECT
    order_status,
    COUNT(*) AS total_orders,
    CAST(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER ()
        AS DECIMAL(5,2)
    ) AS order_percentage
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;

-- Business Insight:
-- Approximately 97.02% of all orders were successfully delivered, indicating that Olist has a strong order 
-- fulfillment process.
-- However, around 2.98% of orders were either cancelled, unavailable, or still in intermediate processing stages. 
-- While the overall fulfillment rate is high, further analysis of delivery speed and delivery delays is required 
-- to evaluate customer experience.



-- =====================================================
-- Business Question 2
-- =====================================================
-- Objective:
-- What percentage of delivered orders were delivered on time versus delivered late?

SELECT
    CASE
        WHEN order_delivered_customer_date <= order_estimated_delivery_date
            THEN 'On-Time'
        ELSE 'Delayed'
    END AS delivery_status,

    COUNT(*) AS total_orders,

    CAST(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER ()
        AS DECIMAL(5,2)
    ) AS percentage

FROM orders
WHERE order_status = 'delivered'
GROUP BY
    CASE
        WHEN order_delivered_customer_date <= order_estimated_delivery_date
            THEN 'On-Time'
        ELSE 'Delayed'
    END;

-- Business Insight:
-- Among all delivered orders, 91.88% were delivered on or before the estimated delivery date, while 8.12% 
-- were delivered late.
-- Although Olist demonstrates strong delivery reliability overall, approximately one in every twelve delivered 
-- orders experiences a delay.
-- Reducing these delayed deliveries presents an opportunity to improve customer satisfaction and 
-- support higher customer retention.



-- =====================================================
-- Business Question 3
-- =====================================================
-- Objective:
-- What is the average delivery delay (in days) for delayed orders?

SELECT
    CAST(
        AVG(
            DATEDIFF(
                DAY,
                order_estimated_delivery_date,
                order_delivered_customer_date
            ) * 1.0
        ) AS DECIMAL(5,2)
    ) AS average_delay_days
FROM orders
WHERE order_status = 'delivered'
    AND order_delivered_customer_date > order_estimated_delivery_date;



-- =====================================================
-- Business Question 4
-- =====================================================
-- Objective:
-- What is the average order approval time?

SELECT
    CAST(
        AVG(approval_time_hours)
        AS DECIMAL(10,2)
    ) AS average_approval_time_hours
FROM orders
WHERE approval_time_hours IS NOT NULL;


-- =====================================================
-- Business Question 5
-- =====================================================
-- Objective:
-- What is the average order processing time?
SELECT
    CAST(
        AVG(processing_time_hours)
        AS DECIMAL(10,2)
    ) AS average_processing_time_hours
FROM orders
WHERE processing_time_hours IS NOT NULL;


-- =====================================================
-- Business Question 6
-- =====================================================
-- Objective:
-- What is the average shipping (transit) time?
SELECT
    CAST(
        AVG(transit_time_days)
        AS DECIMAL(10,2)
    ) AS average_transit_time_days
FROM orders
WHERE transit_time_days IS NOT NULL;


-- =====================================================
-- Business Question 7
-- =====================================================
-- Objective:
-- What is the average total delivery time?
SELECT
    CAST(
        AVG(delivery_time_days)
        AS DECIMAL(10,2)
    ) AS average_delivery_time_days
FROM orders
WHERE delivery_time_days IS NOT NULL;

-- Business Insight:
-- Orders are approved within an average of 10.42 hours, indicating efficient order confirmation. 
-- However, orders spend an average of 67.32 hours in processing before being handed to the carrier.
-- The longest stage of the fulfillment process is transit, averaging 9.33 days and accounting for the majority of
-- the overall delivery time of 12.56 days. 
-- This suggests that logistics and shipping operations are the primary contributors to customer delivery times.


-- =====================================================
-- Business Question 8
-- =====================================================
-- Objective:
-- How are delivered orders distributed by delivery time?

SELECT
    CASE
        WHEN delivery_time_days < 4 THEN '0-3 Days (Very Fast)'
        WHEN delivery_time_days < 8 THEN '4-7 Days (Fast)'
        WHEN delivery_time_days < 15 THEN '8-14 Days (Standard)'
        WHEN delivery_time_days < 22 THEN '15-21 Days (Slow)'
        ELSE '22+ Days (Very Slow)'
    END AS delivery_category,

    COUNT(*) AS total_orders,

    CAST(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER ()
        AS DECIMAL(5,2)
    ) AS percentage

FROM orders

WHERE order_status = 'delivered'
    AND delivery_time_days IS NOT NULL

GROUP BY
    CASE
        WHEN delivery_time_days < 4 THEN '0-3 Days (Very Fast)'
        WHEN delivery_time_days < 8 THEN '4-7 Days (Fast)'
        WHEN delivery_time_days < 15 THEN '8-14 Days (Standard)'
        WHEN delivery_time_days < 22 THEN '15-21 Days (Slow)'
        ELSE '22+ Days (Very Slow)'
    END

ORDER BY
    MIN(delivery_time_days);

-- Business Insight:
-- Most delivered orders (37.73%) reached customers within 8 to 14 days,
-- representing Olist's standard delivery experience. 
-- Nearly 34.93% of orders were delivered within seven days, while only 11.41% requiredmore than 22 days. 
-- Although extremely long delivery times are lesscommon, they still affect over one in every ten delivered 
-- orders and represent an opportunity to improve customer satisfaction.



-- =====================================================
-- Business Question 9
-- =====================================================
-- Objective:
-- Which customer states experience the longest average delivery times?

SELECT
    c.customer_state,

    COUNT(*) AS delivered_orders,

    CAST(
        AVG(o.delivery_time_days)
        AS DECIMAL(10,2)
    ) AS average_delivery_time_days

FROM orders AS o
INNER JOIN customers AS c
    ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
GROUP BY
    c.customer_state
ORDER BY
    average_delivery_time_days DESC;

-- Business Insight:
-- Delivery performance varies considerably across customer states.
-- Customers in northern and northeastern states generally experience longer delivery times than customers in 
-- southern and southeastern regions. 
-- São Paulo (SP), the largest customer market, has the shortest average delivery time (8.76 days), 
-- while several remote states require more than 20 days on average. 
-- These findings suggestthat geographic distance and logistics infrastructure significantly influence 
-- delivery performance.



-- =====================================================
-- Business Question 10
-- =====================================================
-- Objective:
-- Which customer states have the highest percentage of delayed deliveries?

SELECT
    c.customer_state,

    COUNT(*) AS delivered_orders,

    SUM(
        CASE
            WHEN o.order_delivered_customer_date >
                 o.order_estimated_delivery_date
            THEN 1
            ELSE 0
        END
    ) AS delayed_orders,

    CAST(
        SUM(
            CASE
                WHEN o.order_delivered_customer_date >
                     o.order_estimated_delivery_date
                THEN 1
                ELSE 0
            END
        ) * 100.0 /
        COUNT(*)
        AS DECIMAL(5,2)
    ) AS delay_percentage

FROM orders AS o

INNER JOIN customers AS c
    ON o.customer_id = c.customer_id

WHERE o.order_status = 'delivered'

GROUP BY
    c.customer_state

HAVING COUNT(*) >= 100

ORDER BY
    delay_percentage DESC;

-- Business Insight:
-- States such as Alagoas (AL), Maranhão (MA), Piauí (PI), Ceará (CE), and Sergipe (SE) have the highest 
-- percentages of delayed deliveries, with more than 15% of delivered orders arriving after the estimated
-- delivery date. 
-- In contrast, larger markets such as São Paulo (SP), Minas Gerais (MG), and Paraná (PR) maintain delay rates 
-- below 6%, indicating more reliable delivery performance. 
-- These findings suggest that improving logistics in specific regions could significantly reduce delayed 
-- deliveries and enhance customer satisfaction.