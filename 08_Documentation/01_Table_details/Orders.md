**Orders Table (orders)**



**1. Table Purpose**



The orders table stores the lifecycle of every order placed on the ***Olist*** platform. It records the customer associated with the order, the order status, and key timestamps representing different stages of the order fulfillment process—from purchase to delivery.



This table acts as the central fact table for analyzing order volume, fulfillment performance, customer experience, and delivery efficiency.



**2. Table Grain**



**One record represents one order placed by one customer.**



Each row corresponds to a unique order and captures its complete lifecycle through various timestamps.



**3. Primary Key**



***order\_id* :** Unique identifier for each order.



**4. Foreign Keys**

&#x09;

**Column :** *customer\_id*

**References :** *customers.customer\_id*

**Purpose :** Identifies the customer who placed the order.



**5. Relationships**



Related Table	    Relationship

Customers	    Many Orders → One Customer (*customer\_id*)

Order Items	    One Order → Many Order Items (*order\_id*)

Order Payments	    One Order → One or Many Payments (*order\_id*)

Order Reviews	    One Order → One Review (*order\_id*)



The orders table acts as the hub that links customers, purchased products, payments, and reviews.



**6. Columns \& Description**



&#x20; ***order\_id*** 		 	Unique identifier for each order. Primary Key.

&#x20; ***customer\_id*** 		 	Customer associated with the order. Foreign Key to customers.

&#x20; ***order\_status***           	Current status of the order (e.g., delivered, shipped, canceled).

&#x20; ***order\_purchase\_timestamp***      Date and time when the customer placed the order.

&#x20; ***order\_approved\_at***             Date and time when the payment/order was approved.

&#x20; ***order\_delivered\_carrier\_date***  Date and time when the order was handed over to the logistics carrier.

&#x20; ***order\_delivered\_customer\_date*** Date and time when the customer received the order.

&#x20; ***order\_estimated\_delivery\_date*** Estimated delivery date promised to the customer.



**7. Business Importance**



This table is essential for understanding the complete order fulfillment process. It supports analyses related to:



* Order volume
* Delivery performance
* Customer satisfaction
* Operational efficiency
* Order cancellations
* Delivery delays
* Customer retention



**8. Data Quality Observations**



**From the data audit:**



* Primary Key (*order\_id*) is unique.
* *customer\_id* successfully links to the customers table.
* Timestamp columns contain expected missing values for orders that were canceled or not yet delivered.
* Datetime columns are correctly parsed and suitable for time-based analysis.
* No duplicate orders were identified.





**Documentation Notes**



\-The orders table is the central fact table of the Olist dataset.

\-Nearly every analytical workflow begins by joining this table with others.

\-Most delivery-related KPIs and customer experience metrics are derived from its timestamps.

\-Care should be taken when calculating time-based metrics to handle orders with statuses such as canceled, unavailable, or other non-delivered states, as these may have missing timestamp values.

