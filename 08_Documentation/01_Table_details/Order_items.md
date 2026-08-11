**Order Items Table (order\_items)**



**1. Table Purpose**



The *order\_items* table stores details about every product included in an order. Since a single order can contain multiple products, this table represents the individual line items of each order.



It records the product purchased, the seller fulfilling the order, the item price, freight (shipping) cost, and the shipping deadline.



**2. Table Grain**



One record represents one product (line item) within an order.



If an order contains three different products, the table will contain three separate records for that order.



**3. Primary Key**



The table does not have a single-column primary key.

Instead, the logical composite primary key is:



***order\_id* + <i>order\_item\_id</i> :** Together uniquely identify each item within an order.



**4. Foreign Keys**

Column	        References	        Purpose

*order\_id*	*orders.order\_id*	        Identifies the order containing the item.

*product\_id*	*products.product\_id*	Identifies the purchased product.

*seller\_id*	*sellers.seller\_id*	Identifies the seller fulfilling the item.



**5. Relationships**



Related Table	     Relationship

Orders	             Many Order Items → One Order (*order\_id*)

Products	     Many Order Items → One Product (*product\_id*)

Sellers	             Many Order Items → One Seller (*seller\_id*)



This table serves as the bridge between orders, products, and sellers.



**6. Columns \& Description**



&#x20; *order\_id*                Order identifier. Foreign Key to orders.

&#x20; *order\_item\_id*           Sequential item number within the order.

&#x20; *product\_id*              Purchased product. Foreign Key to products.

&#x20; *seller\_id*               Seller responsible for fulfilling the order. Foreign Key to sellers.

&#x20; *shipping\_limit\_date*     Deadline by which the seller should dispatch the item.

&#x20; *price*                   Price of the product.

&#x20; *freight\_value*           Shipping charge associated with the item.



**7. Business Importance**



The *order\_items* table enables product- and seller-level analysis. It is fundamental for measuring:



* Revenue generation
* Product sales
* Seller performance
* Shipping costs
* Product popularity
* Marketplace activity



Since each row represents a purchased product, this table is the primary source for revenue calculations.



**8. Data Quality Observations**



From the data audit:



* 112,650 rows representing individual purchased items.
* *order\_id* contains duplicates, which is expected because an order may contain multiple items.
* *order\_item\_id* restarts from 1 for each new order and uniquely identifies items only within the same order.
* No duplicate combinations of (*order\_id*, *order\_item\_id*) were identified.
* *price* and *freight\_value* are numeric and suitable for financial analysis.
* *shipping\_limit\_date* is stored as a datetime and can be used to evaluate seller dispatch performance.





**Documentation Notes :**



\-The *order\_items* table is the revenue fact table of the dataset.

\-Revenue should be calculated from the price column, while shipping cost should be analyzed separately using *freight\_value*.

\-A single order can contain products from multiple sellers, making this table essential for marketplace and seller performance analysis.

\-This table should be joined with:

&#x20; a. orders for order lifecycle and timestamps.

&#x20; b. products for product attributes and categories.

&#x20; c. sellers for seller-level insights.

*-order\_payments* to compare item values with payment amounts.

