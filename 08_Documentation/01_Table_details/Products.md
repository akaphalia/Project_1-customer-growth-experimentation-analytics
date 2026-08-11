**Products Table (products)**



**1. Table Purpose**



The products table stores descriptive information about every product sold on the ***Olist*** marketplace. It includes the product category, description metadata, image information, weight, and physical dimensions.



This table enriches transactional data by enabling product-level, category-level, and logistics-related analysis.



**2. Table Grain**



One record represents one unique product.



Each row corresponds to a single product identified by a unique *product\_id.*



**3. Primary Key**

Column		Description

*product\_id*	Unique identifier for each product.



**4. Foreign Keys**



This table does not contain foreign keys.



However, it is referenced by:

Referenced By : order\_items

Column : product\_id



**5. Relationships**



Related Table	Relationship

Order Items	One Product → Many Order Items (product\_id)

Product Category Translation	Many Products → One Category (product\_category\_name)



The products table provides additional product attributes for every item sold.



**6. Columns \& Description**



&#x20; *product\_id*			Unique identifier for each product. Primary Key.

&#x20; *product\_category\_name*		Product category (Portuguese). Links to the category translation table.

&#x20; *product\_name\_lenght*		Number of characters in the product name.

&#x20; *product\_description\_lenght*	Number of characters in the product description.

&#x20; *product\_photos\_qty*		Number of product images available.

&#x20; *product\_weight\_g*		Product weight in grams.

&#x20; *product\_length\_cm*		Product length in centimeters.

&#x20; *product\_height\_cm*		Product height in centimeters.

&#x20; *product\_width\_cm*		Product width in centimeters.





**7. Business Importance**



The products table enables analysis of product assortment, product characteristics, and logistics factors.



It supports analyses such as:



* Product category performance
* Inventory characteristics
* Shipping complexity
* Product popularity
* Physical product profiling



Product dimensions and weight are particularly useful for understanding shipping costs and delivery efficiency.



**8. Data Quality Observations**



From the data audit:



* *product\_id* is unique and serves as the primary key.
* Some product metadata fields contain missing values, particularly:

&#x09;*a. product\_category\_name*

&#x09;*b. product\_name\_lenght*

&#x09;*c. product\_description\_lenght*

&#x09;*d. product\_photos\_qty*

* Physical dimensions and weight (for a small number of products)
* Numeric columns are stored as floats because of missing values.
* Product dimensions are recorded in centimeters, and weight is recorded in grams.



**Documentation Notes :**



\-This table contains descriptive attributes, not transactional data.

\-Revenue cannot be calculated directly from this table; it must be joined with order\_items.

\-The product category names are stored in Portuguese. Use the product\_category translation table to obtain English category names for reporting and dashboards.

\-Product dimensions and weight are valuable for logistics analysis and can help explain differences in freight costs and delivery performance.

