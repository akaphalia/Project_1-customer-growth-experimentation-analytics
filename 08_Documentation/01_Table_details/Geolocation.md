**Geolocation Table (geolocation)**



**1. Table Purpose**



The geolocation table stores geographic information associated with Brazilian ZIP code prefixes. It maps ZIP code prefixes to latitude, longitude, city, and state, enabling spatial and regional analysis.



Unlike the customers and sellers tables, this table does not identify individuals or businesses. Instead, it provides location metadata that can be used to enrich customer and seller records.



**2. Table Grain**



One record represents one geographic coordinate associated with a ZIP code prefix.



Important: A single ZIP code prefix may appear multiple times because multiple latitude and longitude coordinates can be associated with the same postal prefix.



Therefore, the table is not unique at the ZIP code prefix level.



**3. Primary Key**



No primary key exists.



There is no column (or combination of columns) that uniquely identifies every record.



**4. Foreign Keys**



This table contains no foreign keys.



However, it can be joined with:



Related Table	Join Column

Customers	*customer\_zip\_code\_prefix*

Sellers		*seller\_zip\_code\_prefix*



**5. Relationships**



Related Table		Relationship

Customers		Many Customers → Many Geolocation Records (via ZIP code prefix)

Sellers			Many Sellers → Many Geolocation Records (via ZIP code prefix)



**6. Columns \& Description**



&#x20; *geolocation\_zip\_code\_prefix*	First five digits of the Brazilian ZIP code (CEP).

&#x20; *geolocation\_lat*		Latitude coordinate.

&#x20; *geolocation\_lng*		Longitude coordinate.

&#x20; *geolocation\_city*		City associated with the ZIP code prefix.

&#x20; *geolocation\_state*		State abbreviation associated with the ZIP code prefix.



**7. Business Importance**



The geolocation table enables geographic and spatial analysis by providing coordinates for customer and seller locations.



It supports analyses such as:



* Geographic customer distribution
* Geographic seller distribution
* Regional demand analysis
* Regional supply analysis
* Heatmaps
* Delivery region visualization



Most importantly it significantly enhances location-based reporting and visualizations.



**8. Data Quality Observations**



From the data audit:



* *geolocation\_zip\_code\_prefix* contains duplicate values, which is expected.
* No primary key exists.
* Latitude and longitude values are available for mapping and spatial analysis.
* City names may contain spelling variations due to different data sources.
* Before joining with other tables, consider aggregating the data to obtain one representative coordinate per ZIP code prefix.





**Documentation Notes :**



\-This table is a reference table used to enrich customer and seller data with geographic coordinates.

\-It should not be joined directly without considering duplicate ZIP code prefixes, as doing so can unintentionally duplicate records in the result set.

\-For most analytical use cases, create a deduplicated version by grouping on *geolocation\_zip\_code\_prefix* and calculating representative coordinates (such as the average latitude and longitude).

