-- ============================================================
-- BUSINESS QUESTION 1:
-- Which payment methods are most frequently used and what percentage of orders use each method?
-- ============================================================

SELECT
    payment_type,

    COUNT(DISTINCT order_id) AS total_orders,

    CAST(
        COUNT(DISTINCT order_id) * 100.0
        / SUM(COUNT(DISTINCT order_id)) OVER ()
        AS DECIMAL(5,2)
    ) AS order_percentage

FROM dbo.payments

GROUP BY
    payment_type

ORDER BY
    total_orders DESC;

-- Business Insight:
-- Credit cards are the dominant payment method, accounting for 75.24% of orders, while boleto represents 
-- the second-most-used method at 19.46%. 
-- Voucher and debit-card payments account for relatively small shares of orders at 3.80% and 1.50%, respectively. 
-- This indicates that credit-card payments are the primary payment channel and should be prioritized when 
-- optimizing the checkout experience. 
-- Boleto remains a significant alternative payment method and should also be maintained as an important payment option.


-- ============================================================
-- BUSINESS QUESTION 2:
-- Which payment methods generate the most revenue?
-- ============================================================

SELECT
    payment_type,

    CAST(
        SUM(payment_value)
        AS DECIMAL(12,2)
    ) AS total_revenue

FROM payments

GROUP BY
    payment_type

ORDER BY
    total_revenue DESC;

-- Business Insights:
-- Credit card payments generate the highest revenue at R$12.54 million, representing approximately 78.15% of 
-- total payment value. 
-- Boleto is the second-largest contributor with R$2.87 million, accounting for 
-- approximately 17.88% of payment value. 
-- Voucher and debit-card payments contribute relatively small shares of revenue at approximately 2.36% 
-- and 1.36%, respectively. 
-- The strong concentration of payment value in credit cards indicates that this payment channel is particularly 
-- important to Olist's revenue flow and should be prioritized when optimizing payment and checkout experiences.


-- ============================================================
-- BUSINESS QUESTION 3:
-- What is the average payment value by payment method?
-- ============================================================

SELECT
    payment_type,

    COUNT(*) AS total_payments,

    CAST(
        AVG(payment_value)
        AS DECIMAL(10,2)
    ) AS average_payment_value

FROM payments

GROUP BY
    payment_type

ORDER BY
    average_payment_value DESC;

-- Business Insights:
-- Credit card payments have the highest average payment value at R$163.32 per payment, followed by boleto 
-- at R$145.03 and debit card at R$142.57. 
-- Voucher payments have a considerably lower average value of R$65.70. 
-- This indicates that credit card transactions tend to be associated with higher-value purchases, reinforcing 
-- the importance of maintaining a smooth and reliable credit-card payment experience. 
-- Voucher payments, in contrast, are generally used for lower-value transactions.


-- ============================================================
-- BUSINESS QUESTION 4:
-- How does installment usage vary by payment method?
-- ============================================================

SELECT
    payment_type,

    COUNT(*) AS total_payments,

    CAST(
        AVG(
            TRY_CONVERT(DECIMAL(10,2), payment_installments)
        )
        AS DECIMAL(10,2)
    ) AS average_installments

FROM payments

WHERE
    TRY_CONVERT(DECIMAL(10,2), payment_installments) > 0

GROUP BY
    payment_type

ORDER BY
    average_installments DESC;

-- Business Insights:
-- Credit card is the only payment method with meaningful installment usage, averaging 3.51 installments per payment.
-- Boleto, debit card, and voucher payments average 1 installment, indicating that these methods are predominantly 
-- used for single-payment transactions. 
-- This suggests that installment-based purchasing is strongly associated with credit-card usage and may be an 
-- important mechanism supporting higher-value purchases on the platform.


-- ============================================================
-- BUSINESS QUESTION 5:
-- Do orders with more installments tend to have
-- higher payment values?
-- ============================================================

SELECT
    CASE
        WHEN TRY_CONVERT(INT, payment_installments) = 1
            THEN '1 Installment'

        WHEN TRY_CONVERT(INT, payment_installments) BETWEEN 2 AND 3
            THEN '2-3 Installments'

        WHEN TRY_CONVERT(INT, payment_installments) BETWEEN 4 AND 6
            THEN '4-6 Installments'

        WHEN TRY_CONVERT(INT, payment_installments) BETWEEN 7 AND 12
            THEN '7-12 Installments'

        WHEN TRY_CONVERT(INT, payment_installments) > 12
            THEN '13+ Installments'
    END AS installment_category,

    COUNT(*) AS total_payments,

    CAST(
        AVG(payment_value)
        AS DECIMAL(10,2)
    ) AS average_payment_value

FROM payments

WHERE
    TRY_CONVERT(INT, payment_installments) > 0

GROUP BY
    CASE
        WHEN TRY_CONVERT(INT, payment_installments) = 1
            THEN '1 Installment'

        WHEN TRY_CONVERT(INT, payment_installments) BETWEEN 2 AND 3
            THEN '2-3 Installments'

        WHEN TRY_CONVERT(INT, payment_installments) BETWEEN 4 AND 6
            THEN '4-6 Installments'

        WHEN TRY_CONVERT(INT, payment_installments) BETWEEN 7 AND 12
            THEN '7-12 Installments'

        WHEN TRY_CONVERT(INT, payment_installments) > 12
            THEN '13+ Installments'
    END

ORDER BY
    average_payment_value DESC;

--
-- Higher installment counts are strongly associated with higher payment values. 
-- Payments made in a single installment have an average value of R$112.42, compared with R$181.32 for 4–6 
-- installments, R$333.29 for 7–12 installments, and R$413.72 for 13+ installments. 
-- This indicates that installment payments are particularly important for higher-value purchases. 
-- Olist could therefore consider maintaining competitive installment options as part of its strategy to 
-- support higher-value transactions and reduce friction for customers making larger purchases.


-- ============================================================
-- BUSINESS QUESTION 6:
-- Which payment methods are associated with higher-value orders?
-- ============================================================

WITH order_payment_summary AS
(
    SELECT
        order_id,
        payment_type,
        SUM(payment_value) AS order_payment_value

    FROM payments

    GROUP BY
        order_id,
        payment_type
)

SELECT
    payment_type,

    COUNT(*) AS total_orders,

    CAST(
        AVG(order_payment_value)
        AS DECIMAL(10,2)
    ) AS average_order_value

FROM order_payment_summary

GROUP BY
    payment_type

HAVING COUNT(*) >= 100

ORDER BY
    average_order_value DESC;

-- Business Insights:
-- Credit card orders have the highest average order value at R$163.94, followed by boleto at R$145.03 and 
-- debit card at R$142.66. Voucher-based orders have a substantially lower average order value of R$98.15. 
-- This indicates that credit card usage is associated with higher-value orders, while voucher payments tend to 
-- be associated with lower-value purchases. 
-- Given the dominance of credit cards in both order volume and value, maintaining a seamless credit-card payment 
-- experience is strategically important for Olist.