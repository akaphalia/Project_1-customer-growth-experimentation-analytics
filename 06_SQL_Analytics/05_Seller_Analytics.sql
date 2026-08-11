-- ============================================================
-- BUSINESS QUESTION 1:
-- Which sellers generate the highest revenue?
-- ============================================================

SELECT TOP (10)

    oi.seller_id,

    COUNT(DISTINCT oi.order_id) AS total_orders,

    CAST(
        SUM(oi.price)
        AS DECIMAL(12,2)
    ) AS total_revenue

FROM order_items AS oi

GROUP BY
    oi.seller_id

HAVING
    COUNT(DISTINCT oi.order_id) >= 100

ORDER BY
    total_revenue DESC;

-- ============================================================
-- BUSINESS INSIGHT:
--
-- The top 10 sellers generated between R$135K and R$229K in product revenue while each processed at least 100 orders.
-- Seller 4869f7a5dfa277a7dca6462dcf3b52b2 generated the highest revenue at R$229.47K from 1,132 orders, 
-- followed by seller 53243585a1d6dc2643021fd1853d8905 with R$222.78K from only 358 orders.
--
-- The results show substantial variation in revenue contribution across sellers, indicating that a relatively
-- small group of high-performing sellers contributes significantly to marketplace revenue. 
-- These sellers may warrant closer attention for retention, partnership, and operational-performance initiatives.
-- ============================================================


-- ============================================================
-- BUSINESS QUESTION 2:
-- Which sellers have the highest order volume?
-- ============================================================

SELECT TOP (10)

    oi.seller_id,

    COUNT(DISTINCT oi.order_id) AS total_orders,

    CAST(
        SUM(oi.price)
        AS DECIMAL(12,2)
    ) AS total_revenue

FROM order_items AS oi

GROUP BY
    oi.seller_id

HAVING
    COUNT(DISTINCT oi.order_id) >= 100

ORDER BY
    total_orders DESC;


-- ============================================================
-- BUSINESS INSIGHT:
--
-- The highest-volume sellers processed between 1,080 and 1,854
-- orders, with seller 6560211a19b47992c3666cc44a7e94c0 recording
-- the highest order volume at 1,854 orders, followed by seller
-- 4a3ca9315b744ce9f8e9374361493884 with 1,806 orders.
--
-- However, high order volume does not necessarily translate into
-- high revenue. For example, seller 6560211a19b47992c3666cc44a7e94c0
-- processed 1,854 orders but generated R$123.30K, while seller
-- 4869f7a5dfa277a7dca6462dcf3b52b2 generated R$229.47K from only
-- 1,132 orders.
--
-- This highlights significant variation in seller economics and
-- suggests that seller performance should be evaluated using both
-- order volume and revenue rather than volume alone.
-- ============================================================


-- ============================================================
-- BUSINESS QUESTION 3:
-- Which sellers have the highest average order value?
-- ============================================================

SELECT TOP (10)

    oi.seller_id,

    COUNT(DISTINCT oi.order_id) AS total_orders,

    CAST(
        SUM(oi.price)
        / COUNT(DISTINCT oi.order_id)
        AS DECIMAL(10,2)
    ) AS average_order_value

FROM order_items AS oi

GROUP BY
    oi.seller_id

HAVING
    COUNT(DISTINCT oi.order_id) >= 100

ORDER BY
    average_order_value DESC;


-- ============================================================
-- BUSINESS INSIGHT:
--
-- The top 10 sellers by average order value range from R$325.63
-- to R$622.28 per order. Seller 53243585a1d6dc2643021fd1853d8905
-- has the highest average order value at R$622.28 across 358 orders,
-- followed by seller 7e93a43ef30c4f03f38b393420bc753a with an average
-- of R$525.09 across 336 orders.
--
-- These results demonstrate that sellers with high average order
-- values are not necessarily the sellers with the highest order
-- volumes. This highlights the importance of evaluating seller
-- performance using multiple dimensions, including revenue, order
-- volume, and order value.
--
-- The minimum threshold of 100 orders reduces the likelihood that
-- sellers with very few transactions dominate the ranking because
-- of unusually high individual order values.
-- ============================================================


-- ============================================================
-- BUSINESS QUESTION 4:
-- Which sellers have the highest delivery-delay rates?
-- ============================================================

SELECT TOP (10)

    oi.seller_id,

    COUNT(DISTINCT oi.order_id) AS delivered_orders,

    COUNT(
        DISTINCT CASE
            WHEN o.order_delivered_customer_date >
                 o.order_estimated_delivery_date
            THEN oi.order_id
        END
    ) AS delayed_orders,

    CAST(
        COUNT(
            DISTINCT CASE
                WHEN o.order_delivered_customer_date >
                     o.order_estimated_delivery_date
                THEN oi.order_id
            END
        ) * 100.0
        / COUNT(DISTINCT oi.order_id)
        AS DECIMAL(5,2)
    ) AS delay_percentage

FROM order_items AS oi

INNER JOIN orders AS o
    ON oi.order_id = o.order_id

WHERE
    o.order_status = 'delivered'

GROUP BY
    oi.seller_id

HAVING
    COUNT(DISTINCT oi.order_id) >= 100

ORDER BY
    delay_percentage DESC;

-- ============================================================
-- BUSINESS INSIGHT:
--
-- The top 10 sellers by delivery-delay rate have delay rates
-- ranging from 15.52% to 23.14%. Seller
-- 06a2c3af7b3aee5d69171b0e14f0ee87 has the highest delay rate
-- at 23.14%, with 90 delayed orders out of 389 delivered orders.
-- Seller 1ca7077d890b907f89be8c954a02686a has the second-highest
-- rate at 22.22%.
--
-- These elevated delay rates indicate that delivery performance
-- varies considerably across sellers. Sellers with consistently
-- high delay rates should be prioritized for operational review,
-- particularly where delays may negatively affect customer
-- satisfaction and retention.
--
-- The minimum threshold of 100 delivered orders was applied to
-- avoid rankings being dominated by sellers with very small
-- numbers of delivered orders.
-- ============================================================

-- ============================================================
-- BUSINESS QUESTION 5:
-- Which sellers have the highest average delivery time?
-- ============================================================

SELECT TOP (10)

    oi.seller_id,

    COUNT(DISTINCT oi.order_id) AS delivered_orders,

    CAST(
        AVG(
            DATEDIFF(
                DAY,
                o.order_purchase_timestamp,
                o.order_delivered_customer_date
            ) * 1.0
        )
        AS DECIMAL(10,2)
    ) AS average_delivery_time_days

FROM order_items AS oi

INNER JOIN orders AS o
    ON oi.order_id = o.order_id

WHERE
    o.order_status = 'delivered'
    AND o.order_delivered_customer_date IS NOT NULL

GROUP BY
    oi.seller_id

HAVING
    COUNT(DISTINCT oi.order_id) >= 100

ORDER BY
    average_delivery_time_days DESC;

-- ============================================================
-- BUSINESS INSIGHT:
--
-- The top 10 sellers by average delivery time have average
-- delivery durations ranging from 16.05 to 22.33 days.
-- Seller 7c67e1448b00f6e969d365cea6b010ab has the highest
-- average delivery time at 22.33 days across 973 delivered
-- orders, followed by seller 88460e8ebdecbfecb5f9601833981930
-- at 18.23 days across 246 delivered orders.
--
-- The results indicate substantial variation in delivery speed
-- across sellers. Seller 7c67e1448b00f6e969d365cea6b010ab is
-- particularly important to investigate because its high
-- delivery time is observed across a relatively large volume
-- of delivered orders.
--
-- Sellers with consistently long delivery times should be
-- investigated alongside their delay rates to identify potential
-- operational bottlenecks that could negatively affect customer
-- experience and retention.
--
-- The minimum threshold of 100 delivered orders was applied to
-- reduce the influence of sellers with very small sample sizes.
-- ============================================================

-- ============================================================
-- BUSINESS QUESTION 6:
-- Which sellers have the best customer review scores?
-- ============================================================

SELECT TOP (10)

    oi.seller_id,

    COUNT(DISTINCT r.review_id) AS total_reviews,

    CAST(
        AVG(CAST(r.review_score AS FLOAT))
        AS DECIMAL(5,2)
    ) AS average_review_score

FROM order_items AS oi

INNER JOIN reviews AS r
    ON oi.order_id = r.order_id

GROUP BY
    oi.seller_id

HAVING
    COUNT(DISTINCT r.review_id) >= 100

ORDER BY
    average_review_score DESC,
    total_reviews DESC;

-- ============================================================
-- BUSINESS INSIGHT:
--
-- The top 10 sellers by average review score have ratings ranging
-- from 4.43 to 4.58 out of 5. Seller
-- 289cdb325fb7e7f891c38608bf9e0962 has the highest average review
-- score at 4.58 across 110 reviews, followed by seller
-- ac3508719a1d8f5b7614b798f70af136 with a score of 4.57 across
-- 101 reviews.
--
-- Several sellers maintain average scores above 4.40 while
-- having more than 100 reviews, indicating consistently positive
-- customer feedback rather than ratings based on only a handful
-- of transactions.
--
-- These high-performing sellers can serve as benchmarks for
-- customer experience and operational practices. Comparing their
-- delivery performance, order economics, and other characteristics
-- with lower-rated sellers could help identify practices associated
-- with stronger customer satisfaction.
--
-- A minimum threshold of 100 reviews was applied to reduce the
-- influence of sellers with very small review samples.
-- ============================================================


