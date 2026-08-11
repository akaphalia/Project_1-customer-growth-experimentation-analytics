**1. customer\_city\_state**



Description:

Combines the customer's city and state into a single geographic field.



Business Purpose:

Simplifies geographic analysis and reporting by providing a single location identifier for grouping and visualization.



Formula:

customer\_city + ", " + customer\_state



Source Column(s):

customer\_city

customer\_state



Data Type:

object



Expected Values:

City, State (e.g., "sao paulo, SP")



Missing Values:

None



Example:

customer\_city = sao paulo

customer\_state = SP



customer\_city\_state = sao paulo, SP



