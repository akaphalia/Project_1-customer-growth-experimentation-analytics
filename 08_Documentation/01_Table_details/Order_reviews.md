**Order Reviews Table (order\_reviews)**



**1. Table Purpose**



The *order\_reviews* table stores customer feedback for completed orders. It contains the review score assigned by the customer, optional review title and message, and timestamps indicating when the review was created and submitted.



This table is the primary source for measuring customer satisfaction and identifying factors that influence positive or negative experiences.



**2. Table Grain**



One record represents one customer review for one order.



Most orders have a single review, although not every order necessarily receives one.



**3. Primary Key**



Column		Description

*review\_id*	Unique identifier for each customer review.



**4. Foreign Keys**



Column : *order\_id*

References : *orders.order\_id*

Purpose : Associates the review with its corresponding order.



**5. Relationships**



Related Table		Relationship

Orders			One Review → One Order (*order\_id*)



When joined with the orders table, reviews can be analyzed alongside delivery timelines, order status, and fulfillment performance.



**6. Columns \& Description**

Column				Description

*review\_id*			Unique identifier for the review. Primary Key.

*order\_id*			Order associated with the review. Foreign Key to orders.

*review\_score*			Customer rating for the order, ranging from 1 (lowest) to 5 (highest).

*review\_comment\_title*		Short title provided by the customer (optional).

*review\_comment\_message*		Detailed customer feedback (optional).

*review\_creation\_date*		Date when the review invitation was created.

*review\_answer\_timestamp*		Date and time when the customer submitted the review.



**7. Business Importance**



The order\_reviews table enables measurement of customer satisfaction and helps identify operational issues that affect the customer experience.



It supports analyses related to:



* Customer satisfaction
* Service quality
* Seller performance
* Delivery experience
* Product quality perception



This table is particularly important because review scores can be linked with operational metrics such as delivery time and shipping performance to uncover drivers of customer satisfaction.



**8. Data Quality Observations**



From the data audit:



* *review\_id* is unique and serves as the primary key.
* *order\_id* links reviews to the corresponding order.
* *review\_comment\_title* and *review\_comment\_message* contain missing values, which is expected because leaving written feedback is optional.
* *review\_score* contains integer values from 1 to 5.
* Timestamp columns are stored in datetime format and support time-based analysis.





**Documentation Notes :**



\-The review score is the most reliable quantitative measure of customer satisfaction in the dataset.

\-Missing review comments should not be treated as missing customer feedback; many customers provide only a numeric rating.

\-Review comments can be used for qualitative or text analysis, but the numeric score is generally more suitable for KPI reporting.

\-This table becomes significantly more valuable when joined with:

&#x20; a.orders to evaluate the impact of delivery performance.

&#x20; b.order\_items and products to compare satisfaction across products or categories.

&#x20; c.sellers to assess seller performance.

