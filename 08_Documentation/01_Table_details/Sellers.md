**Sellers Table (sellers)**



**1. Table Purpose**



The sellers table stores information about sellers participating in the ***Olist*** marketplace. It provides each seller's unique identifier and geographic location, enabling regional analysis and seller performance evaluation.



This table serves as the primary reference for analyzing seller distribution, operational performance, and regional marketplace activity.



**2. Table Grain**



One record represents one unique seller.



Each row corresponds to a single seller registered on the ***Olist*** marketplace.



**3. Primary Key**



Column : seller\_id

Description : Unique identifier for each seller



**4. Foreign Keys**



This table does not contain foreign keys.



However, it is referenced by:



Referenced By	Column

order\_items	seller\_id



**5. Relationships**



Related Table		Relationship

Order Items		One Seller → Many Order Items (*seller\_id*)



Since a seller can sell multiple products across many orders, this is a one-to-many relationship.



**6. Columns \& Description**



&#x20; *seller\_id*			Unique identifier for each seller. Primary Key.

&#x20; *seller\_zip\_code\_prefix*	First five digits of the seller's ZIP code.

&#x20; *seller\_city*			Seller's city.

&#x20; *seller\_state*			Seller's state abbreviation (e.g., SP, RJ, MG).



**7. Business Importance**



The sellers table enables analysis of seller distribution and marketplace operations.



It supports analyses such as:



* Seller geographic distribution
* Seller contribution to sales
* Regional marketplace activity
* Seller performance
* Operational efficiency



When joined with transactional tables, it becomes possible to identify high-performing sellers and evaluate how seller characteristics influence customer experience.





**8. Data Quality Observations**



From the data audit:



* *seller\_id* is unique and serves as the primary key.
* No duplicate seller records were identified.
* Geographic fields are complete and suitable for regional analysis.
* ZIP code prefixes can be linked with the geolocation table for more detailed mapping if required.





**Documentation Notes :**



\-The sellers table contains descriptive seller information, not sales transactions.

\-Revenue, order counts, and customer satisfaction metrics must be calculated by joining this table with:

&#x20;*a. order\_items*

&#x20;*b. orders*

&#x20;*c. order\_reviews*

\-Geographic information allows comparison of seller distribution across different regions.

