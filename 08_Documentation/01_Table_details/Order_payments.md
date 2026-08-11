**Order Payments Table (*order\_payments*)**



**1. Table Purpose**



The *order\_payments* table stores payment information for each order placed on the ***Olist*** platform. It records the payment method, installment details, payment amount, and the sequence of payments when an order is paid using multiple transactions.



This table is used to analyze customer payment behavior and validate payment values against order values.



**2. Table Grain**



One record represents one payment transaction associated with an order.



An order may have multiple payment records if the customer splits the payment across different methods or transactions.



**3. Primary Key**



There is no single-column primary key.



The logical composite key is:



*order\_id* + *payment\_sequential* : Together uniquely identify each payment transaction for an order.



**4. Foreign Keys**



Column : *order\_id*

References : *orders.order\_id*

Purpose : Links the payment to its corresponding order



**5. Relationships**



Related Table	Relationship

Orders	Many Payments → One Order (*order\_id*)



Although many orders have only one payment record, the table supports multiple payment transactions for the same order.



**6. Columns \& Description**



&#x20; *order\_id*		Order associated with the payment. Foreign Key to orders.

&#x20; *payment\_sequential*	Sequence number of the payment transaction for an order. Useful when multiple payments exist.

&#x20; *payment\_type*		Payment method used (e.g., credit\_card, boleto, voucher, debit\_card).

&#x20; *payment\_installments*	Number of installments chosen by the customer.

&#x20; *payment\_value*		Total amount paid in the transaction.



**7. Business Importance**



The *order\_payments* table helps understand customer payment preferences and purchasing behavior. It supports analysis of:



* Preferred payment methods
* Installment usage
* Average payment value
* Split payments
* Revenue validation
* Customer financing behavior



When combined with *order\_items*, it can also be used to verify that the total payment aligns with the total order value.





**8. Data Quality Observations**



From the data audit:



* *order\_id* is not unique because an order can have multiple payment transactions.
* *payment\_sequential* starts at 1 and increments when multiple payments exist for the same order.
* No major missing values were identified.
* *payment\_value* is numeric and suitable for financial analysis.
* *payment\_installments* contains integer values representing the selected installment plan.





**Documentation Notes :**



\-The *payment\_value* represents the amount paid in a single payment transaction, not necessarily the complete order value if multiple payment records exist.

\-For total order payment, sum *payment\_value* by *order\_id*.

\-*payment\_sequential* indicates the order of payment transactions and does not represent installment number.

\-Installments are represented separately in the *payment\_installments* column.

