-- =====================================================
-- Business Question 1
-- =====================================================
-- Objective:
-- Which product categories generate the highest revenue?

-- =====================================================
-- Business Question 1
-- =====================================================
-- Objective:
-- Which product categories generate the highest revenue?

SELECT TOP (10)

    pct.product_category_name_english AS product_category,

    COUNT(*) AS items_sold,

    CAST(
        SUM(oi.price)
        AS DECIMAL(12,2)
    ) AS total_revenue

FROM order_items AS oi

INNER JOIN products AS p
    ON oi.product_id = p.product_id

INNER JOIN product_category_translation AS pct
    ON p.product_category_name = pct.product_category_name

INNER JOIN orders AS o
    ON oi.order_id = o.order_id

WHERE o.order_status = 'delivered'

GROUP BY
    pct.product_category_name_english

ORDER BY
    total_revenue DESC;

-- Business Insight:
-- Bed & Bath Table is the highest-selling product category by volume, while Health & Beauty generates the 
-- highest overall revenue. 
-- Watches & Gifts ranks second in revenue despite selling significantly fewer items than Bed & Bath Table, 
-- indicating a higher average selling price.
-- These findings highlight the difference between high-volume and high-value product categories.


-- =====================================================
-- Business Question 2
-- =====================================================
-- Objective:
-- Which product categories have the highest average selling price?
SELECT TOP (10)

    pct.product_category_name_english AS product_category,

    COUNT(*) AS items_sold,

    CAST(
        AVG(oi.price)
        AS DECIMAL(10,2)
    ) AS average_selling_price

FROM order_items AS oi

INNER JOIN products AS p
    ON oi.product_id = p.product_id

INNER JOIN product_category_translation AS pct
    ON p.product_category_name = pct.product_category_name

INNER JOIN orders AS o
    ON oi.order_id = o.order_id

WHERE o.order_status = 'delivered'

GROUP BY
    pct.product_category_name_english

ORDER BY
    average_selling_price DESC;

-- Business Insight:
-- Premium product categories such as Computers and Home Appliances command the highest average selling prices 
-- but contribute relatively low sales volumes. 
-- In contrast, Watches & Gifts combines a strong average selling price with high sales volume, making it one
-- of Olist's most valuable product categories from a revenue perspective.


-- =====================================================
-- Business Question 3
-- =====================================================
-- Objective:
-- Which product categories have the highest average freight cost?

SELECT TOP (10)

    pct.product_category_name_english AS product_category,

    COUNT(*) AS items_sold,

    CAST(
        AVG(oi.freight_value)
        AS DECIMAL(10,2)
    ) AS average_freight_cost

FROM order_items AS oi

INNER JOIN products AS p
    ON oi.product_id = p.product_id

INNER JOIN product_category_translation AS pct
    ON p.product_category_name = pct.product_category_name

INNER JOIN orders AS o
    ON oi.order_id = o.order_id

WHERE o.order_status = 'delivered'

GROUP BY
    pct.product_category_name_english

ORDER BY
    average_freight_cost DESC;

-- Business Insight:
-- Computers and large household products incur the highest average freight costs, reflecting their size, 
-- weight, or special handling requirements. 
-- Furniture-related categories appear frequently among the highest freight cost products, suggesting that
-- logistics expenses play a significant role in the profitability of these categories.


-- =====================================================
-- Business Question 4
-- =====================================================
-- Objective:
-- Which product categories have the longest average delivery time?
SELECT TOP (10)

    pct.product_category_name_english AS product_category,

    COUNT(*) AS items_sold,

    CAST(
        AVG(o.delivery_time_days)
        AS DECIMAL(10,2)
    ) AS average_delivery_time_days

FROM order_items AS oi

INNER JOIN products AS p
    ON oi.product_id = p.product_id

INNER JOIN product_category_translation AS pct
    ON p.product_category_name = pct.product_category_name

INNER JOIN orders AS o
    ON oi.order_id = o.order_id

WHERE o.order_status = 'delivered'

GROUP BY
    pct.product_category_name_english

HAVING COUNT(*) >= 100

ORDER BY
    average_delivery_time_days DESC;

-- Business Insight:
-- Office Furniture has the longest average delivery time among major product categories, despite not having
-- the highest average freight cost. 
-- High-volume categories such as Garden Tools and Consoles Games also experience above-average delivery times,
-- indicating that operational delays are influenced by factors beyond shipping cost alone.


-- =====================================================
-- Business Question 5
-- =====================================================
-- Objective:
-- Which product categories have the highest percentage of delayed deliveries?

SELECT TOP (10)

    pct.product_category_name_english AS product_category,

    COUNT(*) AS items_sold,

    SUM(
        CASE
            WHEN o.order_delivered_customer_date >
                 o.order_estimated_delivery_date
            THEN 1
            ELSE 0
        END
    ) AS delayed_items,

    CAST(
        SUM(
            CASE
                WHEN o.order_delivered_customer_date >
                     o.order_estimated_delivery_date
                THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*)
        AS DECIMAL(5,2)
    ) AS delay_percentage

FROM order_items AS oi

INNER JOIN products AS p
    ON oi.product_id = p.product_id

INNER JOIN product_category_translation AS pct
    ON p.product_category_name = pct.product_category_name

INNER JOIN orders AS o
    ON oi.order_id = o.order_id

WHERE o.order_status = 'delivered'

GROUP BY
    pct.product_category_name_english

HAVING COUNT(*) >= 100

ORDER BY
    delay_percentage DESC;

-- Business Insight:
-- Delay rates vary across product categories, with Audio and Fashion Underwear & Beach exceeding a 12% delay rate.
-- However, Health & Beauty represents the greatest operational opportunity because its high sales volume 
-- combined with a 9.05% delay rate results in the largest number of delayed items. 
-- This indicates that improvement efforts should prioritize categories based on both delay rate and business
-- impact rather than percentage alone.


-- =====================================================
-- Business Question 6
-- =====================================================
-- Objective:
-- Which product categories receive the highest average review ratings?

SELECT TOP (10)

    pct.product_category_name_english AS product_category,

    COUNT(*) AS total_reviews,

    CAST(
        AVG(CAST(r.review_score AS FLOAT))
        AS DECIMAL(5,2)
    ) AS average_review_score

FROM order_items AS oi

INNER JOIN products AS p
    ON oi.product_id = p.product_id

INNER JOIN product_category_translation AS pct
    ON p.product_category_name = pct.product_category_name

INNER JOIN reviews AS r
    ON oi.order_id = r.order_id

GROUP BY
    pct.product_category_name_english

HAVING COUNT(*) >= 100

ORDER BY
    average_review_score DESC,
    total_reviews DESC;

-- Business Insight:
-- Books, Luggage & Accessories, and Stationery consistently receive the highest customer ratings, indicating
-- strong product quality and positive purchasing experiences. 
-- Categories such as Stationery and Pet Shop maintain high satisfaction levels despite receiving a large
-- volume of reviews, demonstrating consistently positive customer feedback at scale.


-- =====================================================
-- Business Question 7
-- =====================================================
-- Objective:
-- Which product categories receive the lowest average review ratings?

SELECT TOP (10)

    pct.product_category_name_english AS product_category,

    COUNT(*) AS total_reviews,

    CAST(
        AVG(CAST(r.review_score AS FLOAT))
        AS DECIMAL(5,2)
    ) AS average_review_score

FROM order_items AS oi

INNER JOIN products AS p
    ON oi.product_id = p.product_id

INNER JOIN product_category_translation AS pct
    ON p.product_category_name = pct.product_category_name

INNER JOIN reviews AS r
    ON oi.order_id = r.order_id

GROUP BY
    pct.product_category_name_english

HAVING COUNT(*) >= 100

ORDER BY
    average_review_score ASC,
    total_reviews DESC;

-- Business Insight:
-- Office Furniture receives the lowest average customer rating while also exhibiting the longest delivery 
-- times and among the highest freight costs.
-- Categories such as Audio and Home Comfort also combine operational challenges with below-average customer
-- ratings, suggesting that improvements in logistics and fulfillment could positively influence customer satisfaction.
-- High-volume categories like Bed & Bath Table should also be prioritized because even modest rating improvements 
-- would affect a large number of customers.
