-- ============================================================
-- BUSINESS QUESTION 1:
-- How does delivery delay affect customer review scores?
-- ============================================================

SELECT
    CASE
        WHEN o.order_delivered_customer_date >
             o.order_estimated_delivery_date
            THEN 'Delayed'
        ELSE 'On-Time'
    END AS delivery_status,

    COUNT(DISTINCT r.review_id) AS total_reviews,

    CAST(
        AVG(CAST(r.review_score AS FLOAT))
        AS DECIMAL(5,2)
    ) AS average_review_score

FROM orders AS o

INNER JOIN reviews AS r
    ON o.order_id = r.order_id

WHERE
    o.order_status = 'delivered'

GROUP BY
    CASE
        WHEN o.order_delivered_customer_date >
             o.order_estimated_delivery_date
            THEN 'Delayed'
        ELSE 'On-Time'
    END

ORDER BY
    average_review_score ASC;

-- ============================================================
-- BUSINESS INSIGHT:
--
-- Delivery delays are strongly associated with lower customer
-- satisfaction. Delayed orders received an average review score
-- of only 2.57 out of 5 across 7,674 reviews, compared with
-- 4.29 out of 5 for on-time orders across 88,038 reviews.
--
-- This represents a substantial 1.72-point difference in average
-- review score between delayed and on-time orders, indicating
-- that delivery reliability is a major factor associated with
-- customer satisfaction.
--
-- The results strongly support prioritizing delivery-delay
-- reduction as a customer-experience and retention initiative.
-- However, this analysis establishes an association rather than
-- causation, as other factors may also influence review scores.
-- ============================================================



-- ============================================================
-- BUSINESS QUESTION 2:
-- How does actual delivery time relate to customer review scores?
-- ============================================================

SELECT
    CASE
        WHEN DATEDIFF(
                 DAY,
                 o.order_purchase_timestamp,
                 o.order_delivered_customer_date
             ) <= 7
            THEN '0-7 Days'

        WHEN DATEDIFF(
                 DAY,
                 o.order_purchase_timestamp,
                 o.order_delivered_customer_date
             ) BETWEEN 8 AND 14
            THEN '8-14 Days'

        WHEN DATEDIFF(
                 DAY,
                 o.order_purchase_timestamp,
                 o.order_delivered_customer_date
             ) BETWEEN 15 AND 21
            THEN '15-21 Days'

        ELSE '22+ Days'
    END AS delivery_time_category,

    COUNT(DISTINCT r.review_id) AS total_reviews,

    CAST(
        AVG(CAST(r.review_score AS FLOAT))
        AS DECIMAL(5,2)
    ) AS average_review_score

FROM orders AS o

INNER JOIN reviews AS r
    ON o.order_id = r.order_id

WHERE
    o.order_status = 'delivered'
    AND o.order_delivered_customer_date IS NOT NULL

GROUP BY
    CASE
        WHEN DATEDIFF(
                 DAY,
                 o.order_purchase_timestamp,
                 o.order_delivered_customer_date
             ) <= 7
            THEN '0-7 Days'

        WHEN DATEDIFF(
                 DAY,
                 o.order_purchase_timestamp,
                 o.order_delivered_customer_date
             ) BETWEEN 8 AND 14
            THEN '8-14 Days'

        WHEN DATEDIFF(
                 DAY,
                 o.order_purchase_timestamp,
                 o.order_delivered_customer_date
             ) BETWEEN 15 AND 21
            THEN '15-21 Days'

        ELSE '22+ Days'
    END

ORDER BY
    average_review_score DESC;

-- ============================================================
-- BUSINESS INSIGHT:
--
-- Customer satisfaction declines as delivery time increases.
-- Orders delivered within 7 days received the highest average
-- review score of 4.41 across 30,569 reviews, while orders
-- delivered within 8-14 days averaged 4.30 and those delivered
-- within 15-21 days averaged 4.12.
--
-- The decline becomes particularly pronounced for orders taking
-- 22 or more days to reach customers, which received an average
-- review score of only 3.06 across 11,458 reviews.
--
-- The results indicate a strong association between longer
-- delivery times and lower customer satisfaction. Reducing
-- prolonged delivery times, particularly orders taking 22+
-- days, could therefore be an important customer-experience
-- improvement opportunity.
--
-- This analysis identifies an association and does not establish
-- that delivery time alone causes lower review scores, as other
-- factors may also influence customer satisfaction.
-- ============================================================


-- ============================================================
-- BUSINESS QUESTION 3:
-- How does order value relate to customer review scores?
-- ============================================================

WITH order_values AS
(
    SELECT
        order_id,

        SUM(price) AS order_value

    FROM order_items

    GROUP BY
        order_id
)

SELECT
    CASE
        WHEN ov.order_value < 100
            THEN 'Under R$100'

        WHEN ov.order_value BETWEEN 100 AND 299.99
            THEN 'R$100-299'

        WHEN ov.order_value BETWEEN 300 AND 499.99
            THEN 'R$300-499'

        WHEN ov.order_value BETWEEN 500 AND 999.99
            THEN 'R$500-999'

        ELSE 'R$1000+'
    END AS order_value_category,

    COUNT(DISTINCT r.review_id) AS total_reviews,

    CAST(
        AVG(CAST(r.review_score AS FLOAT))
        AS DECIMAL(5,2)
    ) AS average_review_score

FROM order_values AS ov

INNER JOIN reviews AS r
    ON ov.order_id = r.order_id

GROUP BY
    CASE
        WHEN ov.order_value < 100
            THEN 'Under R$100'

        WHEN ov.order_value BETWEEN 100 AND 299.99
            THEN 'R$100-299'

        WHEN ov.order_value BETWEEN 300 AND 499.99
            THEN 'R$300-499'

        WHEN ov.order_value BETWEEN 500 AND 999.99
            THEN 'R$500-999'

        ELSE 'R$1000+'
    END

ORDER BY
    average_review_score DESC;

-- ============================================================
-- BUSINESS INSIGHT:
--
-- Average review scores decline consistently as order value
-- increases. Orders below R$100 received the highest average
-- review score of 4.15 across 57,267 reviews, while orders
-- valued at R$1,000 or more received the lowest average score
-- of 3.91 across 935 reviews.
--
-- The results show a 0.24-point difference in average review
-- score between the lowest and highest order-value categories.
-- This suggests that higher-value purchases are associated with
-- slightly lower customer satisfaction.
--
-- However, the difference is relatively small compared with the
-- much larger effect observed for delivery delays. Therefore,
-- order value appears to be a weaker indicator of customer
-- satisfaction than delivery performance in this dataset.
--
-- This analysis identifies an association and does not establish
-- that higher order value causes lower review scores.
-- ============================================================


-- ============================================================
-- BUSINESS QUESTION 4:
-- Which product categories have the highest percentage of
-- negative reviews?
-- ============================================================

SELECT TOP (10)

    pct.product_category_name_english AS product_category,

    COUNT(DISTINCT r.review_id) AS total_reviews,

    COUNT(
        DISTINCT CASE
            WHEN r.review_score IN (1, 2)
                THEN r.review_id
        END
    ) AS negative_reviews,

    CAST(
        COUNT(
            DISTINCT CASE
                WHEN r.review_score IN (1, 2)
                    THEN r.review_id
            END
        ) * 100.0
        / COUNT(DISTINCT r.review_id)
        AS DECIMAL(5,2)
    ) AS negative_review_percentage

FROM order_items AS oi

INNER JOIN products AS p
    ON oi.product_id = p.product_id

INNER JOIN product_category_translation AS pct
    ON p.product_category_name = pct.product_category_name

INNER JOIN reviews AS r
    ON oi.order_id = r.order_id

GROUP BY
    pct.product_category_name_english

HAVING
    COUNT(DISTINCT r.review_id) >= 100

ORDER BY
    negative_review_percentage DESC;

-- ============================================================
-- BUSINESS INSIGHT:
--
-- Negative review rates vary substantially across product
-- categories. Fashion_male_clothing has the highest negative
-- review percentage at 26.13%, with 29 negative reviews out
-- of 111 total reviews.
--
-- Office_furniture has the second-highest negative review rate
-- at 22.69%, with 287 negative reviews out of 1,265 reviews.
-- Audio follows at 22.13%.
--
-- The results also show that some categories with relatively
-- large review volumes have significant negative-review rates.
-- For example, bed_bath_table has a 16.71% negative-review rate
-- across 9,324 reviews, representing 1,558 negative reviews.
--
-- Categories with both high negative-review percentages and
-- substantial review volumes should be prioritized for further
-- investigation, as improving customer experience in these
-- categories could affect a meaningful number of customers.
--
-- A minimum threshold of 100 reviews was applied to reduce the
-- influence of categories with very small review samples.
-- ============================================================


-- ============================================================
-- BUSINESS QUESTION 5:
-- How does delivery performance affect the proportion of
-- negative reviews?
-- ============================================================

SELECT

    CASE
        WHEN o.order_delivered_customer_date >
             o.order_estimated_delivery_date
            THEN 'Delayed'
        ELSE 'On-Time'
    END AS delivery_status,

    COUNT(DISTINCT r.review_id) AS total_reviews,

    COUNT(
        DISTINCT CASE
            WHEN r.review_score IN (1, 2)
                THEN r.review_id
        END
    ) AS negative_reviews,

    CAST(
        COUNT(
            DISTINCT CASE
                WHEN r.review_score IN (1, 2)
                    THEN r.review_id
            END
        ) * 100.0
        / COUNT(DISTINCT r.review_id)
        AS DECIMAL(5,2)
    ) AS negative_review_percentage

FROM orders AS o

INNER JOIN reviews AS r
    ON o.order_id = r.order_id

WHERE
    o.order_status = 'delivered'

GROUP BY

    CASE
        WHEN o.order_delivered_customer_date >
             o.order_estimated_delivery_date
            THEN 'Delayed'
        ELSE 'On-Time'
    END

ORDER BY
    negative_review_percentage DESC;

-- ============================================================
-- BUSINESS INSIGHT:
--
-- Delivery delays are strongly associated with a higher incidence
-- of negative customer reviews. Delayed orders had 4,143 negative
-- reviews out of 7,674 total reviews, resulting in a negative
-- review rate of 53.99%.
--
-- In comparison, on-time orders had 8,109 negative reviews out of
-- 88,038 total reviews, resulting in a negative review rate of
-- only 9.21%.
--
-- Therefore, customers with delayed orders were substantially more
-- likely to leave a negative review than customers whose orders
-- arrived on time. The negative-review rate was approximately
-- 5.9 times higher for delayed orders than for on-time orders.
--
-- This highlights delivery reliability as a critical customer-
-- experience priority. Reducing delivery delays could potentially
-- reduce the volume of negative customer feedback and support
-- stronger customer satisfaction and retention.
--
-- The analysis identifies a strong association and does not
-- establish that delivery delays alone cause negative reviews,
-- as other factors may also influence customer satisfaction.
-- ============================================================