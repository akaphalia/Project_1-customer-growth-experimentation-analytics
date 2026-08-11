**1. payment\_total\_value\_per\_order**



Description:

Represents the total amount paid for an order by summing all payment transactions linked to the same order\_id.



Business Purpose:

Measures the complete revenue collected for each order, even when customers split payments across multiple transactions or payment methods. This feature is useful for revenue analysis, customer payment behavior, and order-level financial reporting.



Formula:

SUM(payment\_value) grouped by order\_id



Source Column(s):

payment\_value



Data Type:

float64



Expected Values:

Positive monetary values



Missing Values:

None



Example:

If an order has two payment transactions of 120.00 and 80.00,

payment\_total\_value\_per\_order = 200.00.



**2. payment\_method\_count**



Description:

Represents the number of unique payment methods used to complete an order.



Business Purpose:

Measures customer payment behavior by identifying whether an order was paid using a single payment method or multiple payment methods. This feature can be useful for analyzing payment preferences and complex payment patterns.



Formula:

COUNT(DISTINCT payment\_type) grouped by order\_id



Source Column(s):

payment\_type



Data Type:

int64



Expected Values:

Integer values greater than or equal to 1



Missing Values:

None



Example:

If an order is paid using:

credit\_card

voucher

credit\_card



payment\_method\_count = 2



**3. multiple\_payment\_methods**



Description:

Indicates whether an order was paid using more than one unique payment method.



Business Purpose:

Helps identify split-payment orders, providing insights into customer payment behavior and payment flexibility. This feature can support analyses of payment preferences and transaction complexity.



Formula:

payment\_method\_count > 1



Source Column(s):

payment\_method\_count



Data Type:

int64 (0 = No, 1 = Yes)



Expected Values:

0 or 1



Missing Values:

None



Example:

If payment\_method\_count = 1,

multiple\_payment\_methods = 0



If payment\_method\_count = 2,

multiple\_payment\_methods = 1



**4. max\_installments\_per\_order**



Description:

Represents the maximum number of payment installments used for an order across all its payment transactions.



Business Purpose:

Measures customers' financing behavior by identifying the longest installment plan chosen for an order. This feature is useful for analyzing payment preferences, financing trends, and installment usage.



Formula:

MAX(payment\_installments) grouped by order\_id



Source Column(s):

payment\_installments



Data Type:

int64



Expected Values:

Integer values greater than or equal to 0



Missing Values:

None



Example:

If an order has payment installments of:

1

3

2



max\_installments\_per\_order = 3



**5. installment\_payment\_flag**



Description:

Indicates whether an order was paid using installments.



Business Purpose:

Helps identify customers who chose installment-based payments instead of paying the full amount in a single transaction. This feature is useful for analyzing customer financing behavior and installment adoption.



Formula:

max\_installments\_per\_order > 1



Source Column(s):

max\_installments\_per\_order



Data Type:

int64 (0 = No, 1 = Yes)



Expected Values:

0 or 1



Missing Values:

None



Example:

If max\_installments\_per\_order = 1,

installment\_payment\_flag = 0



If max\_installments\_per\_order = 6,

installment\_payment\_flag = 1



**6. average\_payment\_value\_per\_transaction**



Description:

Represents the average payment amount for each payment transaction associated with an order.



Business Purpose:

Measures the average amount paid per transaction, helping analyze how customers split payments across multiple transactions. This feature can provide insights into payment behavior and transaction patterns.



Formula:

AVG(payment\_value) grouped by order\_id



Source Column(s):

payment\_value



Data Type:

float64



Expected Values:

Positive monetary values



Missing Values:

None



Example:

If an order has payment transactions of:

100.00

50.00

150.00



average\_payment\_value\_per\_transaction = 100.00





