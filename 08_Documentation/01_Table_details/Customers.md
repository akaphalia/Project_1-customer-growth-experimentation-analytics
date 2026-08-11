Customers Table (customers)



**1. Table Purpose**



The customers table stores information about each customer associated with an order. It provides the customer's unique identifier along with their geographic location, enabling customer-level analysis and regional segmentation.



**2. Table Grain**



One record represents one customer associated with one order.



Although the table is named customers, it is not at the unique customer level. A customer who places multiple orders will appear multiple times with different customer\_id values.



**3.Primary Key**



***customer\_id :*** Unique identifier for each customer-order combination. Every row has a unique customer\_id.



**4. Foreign Keys**

**Column :** *customer\_id*

**References :** *orders.customer\_id*

**Purpose :** Links customers with their corresponding orders.



**5. Relationships**



**Related Table :** Orders

**Relationship :** One-to-one through customer\_id



**6. Columns and Description**

&#x20;  ***customer\_id* :** Unique identifier for each customer-order combination. Primary Key.

&#x20;  ***customer\_unique\_id* :** Permanent identifier for an individual customer. Used to identify repeat customers across multiple orders.

&#x20;  ***customer\_zip\_code\_prefix* :** First five digits of the customer's ZIP code.

&#x20;  ***customer\_city* :** Customer's city.

&#x20;  *customer\_state* : Customer's state abbreviation (e.g., SP, RJ, MG).



**7. Business Importance**



This table enables analysis of customer demographics and geographic distribution. It helps answer questions such as:



* Which states generate the highest number of customers?
* Which cities contribute the most orders?
* How many repeat customers does the business have?
* Which regions have the highest customer retention?



**8. Data Quality Observations**



**From the data audit:**



* Total Rows: 99,441
* Null Values: 0 across all columns
* Duplicate *customer\_id*: 0 (expected, as it is the primary key)
* Duplicate *customer\_unique\_id*: Expected, since the same customer can place multiple orders.
* Data types are appropriate for all columns.
* No immediate data quality issues were identified.





**Documentation Notes**



**One important observation worth highlighting is the distinction between the two customer identifiers:**



***-customer\_id*** identifies a customer-order instance and is used to join with the orders table.

***-customer\_unique\_id*** identifies the actual customer and should be used for customer-level analyses such as repeat purchase rate, customer lifetime value (CLV), and retention.

