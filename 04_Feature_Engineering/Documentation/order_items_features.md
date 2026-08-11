**1. freight\_to\_price\_ratio**



Source: Table order\_items



Feature Type:

Numerical (Continuous)



Business Definition:

Represents the shipping cost as a proportion of the product price for each order item.



Formula:

freight\_value / price



Business Value:

Helps evaluate whether shipping costs are reasonable relative to product value. This feature can be used to identify products or sellers with disproportionately high shipping charges and supports logistics, pricing, and profitability analysis.



Null Logic:

No null values are expected because both freight\_value and price are available for all records. Division by zero is avoided since the minimum product price is greater than zero.



Unit / Possible Values:

Decimal ratio (e.g., 0.20 = shipping cost is 20% of the product price)



**2. order\_total\_items**



Source: Table order\_items



Feature Type:

Numerical (Discrete)



Business Definition:

Represents the total number of items purchased within an order.



Formula:

Count of order\_item\_id grouped by order\_id



Business Value:

Helps distinguish single-item and multi-item orders. This feature supports analyses of purchasing behavior, order complexity, logistics planning, shipping costs, and revenue patterns.



Null Logic:

No null values are expected because every order item belongs to an order and contributes to the item count.



Unit / Possible Values:

Positive integer (1, 2, 3, ...)



**3. seller\_total\_items**



Source: Table order\_items



Feature Type:

Numerical (Discrete)



Business Definition:

Represents the total number of order items fulfilled by a seller across the entire dataset.



Formula:

Count of order\_item\_id grouped by seller\_id



Business Value:

Measures seller activity and sales volume. This feature supports seller segmentation, marketplace analysis, logistics planning, and performance evaluation by identifying sellers who fulfill large or small numbers of items.



Null Logic:

No null values are expected because every order item is associated with a seller.



Unit / Possible Values:

Positive integer (1, 2, 3, ...)

