1. **approval\_time\_hours**



Source: Table orders



Feature Type: Numerical (Continuous)



Business Definition: Time taken between order placement and order approval.



Formula: (order\_approved\_at - order\_purchase\_timestamp) in hours



Business Value: Measures payment and order approval efficiency. Useful for identifying operational bottlenecks and analyzing their relationship with cancellations, delivery performance, and customer satisfaction.



Null Logic: Null when an order was never approved.



Unit: Hours



**2. processing\_time\_hours**



Source: Table orders



Feature Type: Numerical (Continuous)



Business Definition: Time taken between order approval and handoff of the order to the logistics carrier.



Formula: (order\_delivered\_carrier\_date - order\_approved\_at) in hours



Business Value: Measures seller fulfillment efficiency after an order is approved. Useful for identifying operational bottlenecks, evaluating seller performance, and analyzing the impact of processing delays on delivery performance and customer satisfaction.



Null Logic: Null when an order was never approved or was never handed over to the logistics carrier.



Unit: Hours



Data Quality Note: A small number of records contain negative values due to inconsistent timestamps where the carrier handoff date precedes the order approval date. These records are retained during Feature Engineering and will be investigated during the EDA phase.



**3. transit\_time\_days**



Source: Table orders



Feature Type: Numerical (Continuous)



Business Definition: Time taken by the logistics network to transport an order from the seller to the customer after it has been handed over to the carrier.



Formula: (order\_delivered\_customer\_date - order\_delivered\_carrier\_date) in days



Business Value: Measures logistics transit efficiency. Useful for evaluating shipping performance, identifying transportation delays, and analyzing the impact of transit time on customer satisfaction.



Null Logic: Null when an order was never handed over to the logistics carrier or was never delivered to the customer.



Unit: Days



Data Quality Note: A very small number of records contain negative transit times due to inconsistent timestamps where the customer delivery date precedes the carrier pickup date. These records are retained during Feature Engineering and will be investigated during the EDA phase.



**4. delivery\_time\_days**



Source: Table orders



Feature Type: Numerical (Continuous)



Business Definition: Total time taken for an order to be delivered from the moment it was placed until it reached the customer.



Formula: (order\_delivered\_customer\_date - order\_purchase\_timestamp) in days



Business Value: Measures the overall customer delivery experience. Useful for evaluating end-to-end order fulfillment performance, identifying delivery delays, and analyzing the relationship between delivery time and customer satisfaction.



Null Logic: Null when an order was never delivered to the customer.



Unit: Days



**5. estimated\_delivery\_days**



Source: Table orders



Feature Type: Numerical (Continuous)



Business Definition: Number of days promised for delivering an order from the purchase date to the estimated delivery date.



Formula: (order\_estimated\_delivery\_date - order\_purchase\_timestamp) in days



Business Value: Measures the delivery commitment made to customers. Useful for comparing promised delivery time with actual delivery time, evaluating delivery performance, and analyzing customer expectations.



Null Logic: Null when the estimated delivery date is unavailable.



Unit: Days



**6. delivery\_delay\_days**



Source: Table orders



Feature Type: Numerical (Continuous)



Business Definition: Difference between the actual customer delivery date and the promised delivery date.



Formula: (order\_delivered\_customer\_date - order\_estimated\_delivery\_date) in days



Business Value: Measures delivery performance against the promised delivery date. Useful for monitoring service level performance, identifying late deliveries, evaluating logistics efficiency, and analyzing the impact of delivery delays on customer satisfaction.



Null Logic: Null when the order was never delivered to the customer or the estimated delivery date is unavailable.



Unit: Days



**7. delivered\_on\_time**



Source: Table orders



Feature Type: Categorical (Boolean)



Business Definition: Indicates whether an order was delivered on or before the promised delivery date.



Formula: delivery\_delay\_days <= 0



Business Value: Measures delivery performance against customer commitments. Useful for calculating on-time delivery rate, monitoring service level performance, comparing seller and logistics performance, and building KPI dashboards.



Null Logic: False values indicate late deliveries. Null values occur only when delivery\_delay\_days is null because the order was never delivered or the estimated delivery date is unavailable.



Possible Values:

\- True: Delivered on or before the promised delivery date.

\- False: Delivered after the promised delivery date.



**8. purchase\_month**



Source: Table orders



Feature Type: Categorical



Business Definition:

Represents the calendar month in which the customer placed the order.



Formula:

Extract month name from order\_purchase\_timestamp.



Business Value:

Useful for analyzing seasonal purchasing behavior, identifying peak sales periods, monitoring monthly order trends, and supporting demand forecasting.



Null Logic:

No null values expected because order\_purchase\_timestamp is mandatory.



Possible Values:

January, February, March, ..., December


**9. purchase\_year**



Source: Table orders



Feature Type: Numerical (Discrete)



Business Definition:

Represents the calendar year in which the customer placed the order.



Formula:

Extract year from order\_purchase\_timestamp.



Business Value:

Useful for year-over-year trend analysis, filtering reports, comparing annual business performance, and creating time-based dashboards.



Null Logic:

No null values expected because order\_purchase\_timestamp is mandatory.



Possible Values:

2016, 2017, 2018

**10. purchase\_quarter**



Source: Table orders



Feature Type: Categorical



Business Definition:

Represents the calendar quarter in which the customer placed the order.



Formula:

Extract quarter from order\_purchase\_timestamp and format as Q1, Q2, Q3, or Q4.



Business Value:

Useful for quarterly sales analysis, executive reporting, identifying seasonal trends, and comparing business performance across quarters.



Null Logic:

No null values expected because order\_purchase\_timestamp is mandatory.



Possible Values:

Q1, Q2, Q3, Q4



**11. purchase\_day\_of\_week**



Source: Table orders



Feature Type: Categorical



Business Definition:

Represents the day of the week on which the customer placed the order.



Formula:

Extract day name from order\_purchase\_timestamp.



Business Value:

Useful for analyzing customer purchasing patterns across weekdays, identifying peak shopping days, optimizing marketing campaigns, and supporting workforce planning.



Null Logic:

No null values expected because order\_purchase\_timestamp is mandatory.



Possible Values:

Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday



**12. purchase\_hour**



Source: Table orders



Feature Type: Numerical (Discrete)



Business Definition:

Represents the hour of the day when the customer placed the order using a 24-hour clock.



Formula:

Extract hour from order\_purchase\_timestamp.



Business Value:

Useful for identifying peak shopping hours, understanding customer purchasing behavior throughout the day, optimizing marketing campaign timing, improving staffing decisions, and analyzing hourly order trends.



Null Logic:

No null values expected because order\_purchase\_timestamp is mandatory.



Possible Values:

0–23 (24-hour format)



**13. is\_weekend\_order**



Source: Table orders



Feature Type: Categorical (Boolean)



Business Definition:

Indicates whether an order was placed on a weekend (Saturday or Sunday).



Formula:

purchase\_day\_of\_week in (Saturday, Sunday)



Business Value:

Useful for comparing customer purchasing behavior between weekdays and weekends, evaluating promotional campaign performance, analyzing operational workload, and identifying differences in delivery performance based on the order day.



Null Logic:

No null values expected because order\_purchase\_timestamp is mandatory.



Possible Values:

True: Order placed on Saturday or Sunday.

False: Order placed on Monday through Friday.



**14. purchase\_year\_month**



Source: Table orders



Feature Type: Categorical



Business Definition:

Represents the year and month in which the customer placed the order.



Formula:

Format order\_purchase\_timestamp as YYYY-MM.



Business Value:

Useful for month-over-month trend analysis, sales reporting, seasonal analysis, KPI tracking, and building time-series visualizations in SQL and Power BI.



Null Logic:

No null values expected because order\_purchase\_timestamp is mandatory.



Possible Values:

YYYY-MM (e.g., 2017-01, 2017-02, 2018-06)

