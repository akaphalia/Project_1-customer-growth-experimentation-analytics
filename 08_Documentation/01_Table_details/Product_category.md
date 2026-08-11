**Product Category Translation Table (*product\_category*)**



**1. Table Purpose**



The *product\_category* table serves as a lookup (reference) table that translates product category names from Portuguese to English.



It enables reports, dashboards, and analyses to present product categories in English, making the dataset easier to interpret for an international audience.



**2. Table Grain**



One record represents one unique product category translation.



Each row maps a Portuguese category name to its English equivalent.



**3. Primary Key**



Column : *product\_category\_name*	

Description : Unique Portuguese product category name.



**4. Foreign Keys**



This table does not contain foreign keys.



However, it is referenced by:



Referenced By	Column

products	*product\_category\_name*



**5. Relationships**



Related Table		Relationship

Products		One Category → Many Products (*product\_category\_name*)



This relationship allows product information to be displayed using English category names.



**6. Columns \& Description**



&#x20;  *product\_category\_name*			Product category name in Portuguese. Primary Key.

&#x20;  *product\_category\_name\_english*		English translation of the product category.



**7. Business Importance**



Although this table contains no transactional data, it is essential for creating understandable reports and dashboards.



It improves:



* Dashboard readability
* Business reporting
* Product category analysis
* Communication with non-Portuguese stakeholders



Without this table, reports would display category names only in Portuguese.



**8. Data Quality Observations**



From the data audit:



* One row exists for each unique product category.
* No duplicate category names were identified.
* Translation values are complete and suitable for reporting.
* The table acts as a static lookup table and does not change transaction data.





**Documentation Notes :**



\-This is a reference (lookup) table, not a transactional table.

\-It should always be joined with the products table before creating product-level reports.

\-The English category names are recommended for all dashboards, reports, and presentations.

\-This table has no measurable KPIs on its own but improves the usability of analyses derived from other tables.

