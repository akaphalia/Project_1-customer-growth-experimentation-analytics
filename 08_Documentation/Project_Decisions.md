\# Project Decisions



This document records the key analytical and technical decisions made during the development of the \*\*Customer Growth \& Experimentation Analytics\*\* project.



\---



\## 1. Business Objective



\*\*Decision:\*\*  

The project is centered around the following business question:



> How can Olist increase customer retention while reducing delivery delays?



\*\*Rationale:\*\*  

The objective connects two important business dimensions: customer behavior and operational performance. This allows the analysis to move beyond basic sales reporting and generate actionable business recommendations.



\---



\## 2. Analytical Scope



\*\*Decision:\*\*  

The analysis focuses on the following core areas:



\- Customer behavior and retention

\- Order performance

\- Delivery performance

\- Product performance

\- Payment behavior

\- Seller performance

\- Customer reviews



\*\*Rationale:\*\*  

These areas collectively provide a view of both customer experience and operational performance while remaining aligned with the project's primary business objective.



\---



\## 3. Geolocation Data



\*\*Decision:\*\*  

The geolocation dataset was excluded from the main analytical workflow.



\*\*Rationale:\*\*  

Although geolocation provides postal-code-level information, it does not materially contribute to the defined business questions. Including it would increase data complexity without providing sufficient analytical value for this project.



The geolocation table is therefore documented but is not used in the main feature engineering, EDA, or SQL analysis.



\---



\## 4. Product Category Translation



\*\*Decision:\*\*  

English product category names are used for business-facing analysis.



\*\*Rationale:\*\*  

The original product categories contain Portuguese names. The translation table allows SQL results and future Power BI visualizations to use standardized English category names that are easier for business stakeholders to interpret.



\---



\## 5. Feature Engineering



\*\*Decision:\*\*  

Raw transactional data was transformed into business-oriented features before conducting the main analysis.



Examples include:



\- Approval time

\- Processing time

\- Transit time

\- Delivery time

\- Delivery status

\- Delivery-speed categories

\- Customer order frequency

\- Customer lifetime value

\- Average order value

\- Customer segments



\*\*Rationale:\*\*  

Raw timestamps and transaction-level records are useful for data storage but are not always directly suitable for business analysis. Derived features convert these raw fields into interpretable metrics that can answer specific business questions.



\---



\## 6. Customer-Level Analysis



\*\*Decision:\*\*  

Customer analysis is performed using `customer\_unique\_id` where customer-level behavior is required.



\*\*Rationale:\*\*  

A single customer can have multiple `customer\_id` records associated with different orders. Using `customer\_unique\_id` provides a more accurate representation of individual customer behavior and prevents customer activity from being artificially fragmented.



\---



\## 7. Delivery Performance



\*\*Decision:\*\*  

Delivery performance is evaluated using the difference between the actual customer delivery date and the estimated delivery date.



\*\*Rationale:\*\*  

The comparison directly measures whether an order reached the customer within the expected delivery timeframe and supports the project's objective of identifying delivery-delay problems.



Orders are classified into:



\- On-Time

\- Delayed



Additional delivery-speed categories are used where appropriate to understand the distribution of delivery duration.



\---



\## 8. SQL Analytics Approach



\*\*Decision:\*\*  

SQL analysis is structured around defined business questions rather than isolated SQL syntax exercises.



\*\*Rationale:\*\*  

The purpose of the SQL phase is to demonstrate the ability to transform business questions into analytical queries, interpret results, and generate meaningful insights.



\---



\## 9. Minimum Sample Thresholds



\*\*Decision:\*\*  

Minimum observation thresholds are applied when comparing categories where appropriate.



\*\*Rationale:\*\*  

Categories with very few observations can produce unstable averages or percentages and may lead to misleading conclusions. Applying a minimum threshold improves the reliability of category-level comparisons.



\---



\## 10. Customer Segmentation



\*\*Decision:\*\*  

Customers are segmented according to their order frequency.



The project distinguishes between:



\- One-Time Customers

\- Repeat Customers

\- Loyal Customers



\*\*Rationale:\*\*  

Order frequency provides a simple and interpretable way to identify differences in customer engagement and supports the project's customer-retention objective.



\---



\## 11. Generated Data Outputs



\*\*Decision:\*\*  

Cleaned and feature-engineered datasets are retained as project outputs.



\*\*Rationale:\*\*  

Keeping these outputs makes the transformation pipeline transparent and allows the progression from raw data to analytical datasets to be demonstrated within the repository.



Raw source data is excluded from the GitHub repository.



\---



\## 12. GitHub Repository



\*\*Decision:\*\*  

The GitHub repository contains the analytical workflow, notebooks, SQL scripts, documentation, and relevant processed datasets rather than the original raw dataset.



\*\*Rationale:\*\*  

This keeps the repository focused on the analytical work while avoiding unnecessary duplication of the source dataset.



\---



\## 13. Business-Focused Analysis



\*\*Decision:\*\*  

Each major analytical stage should contribute to answering the project's business objective.



\*\*Rationale:\*\*  

The project is intended to demonstrate data-analyst capability rather than simply demonstrate proficiency with Python, SQL, or Power BI. Technical methods are therefore selected based on their ability to support business interpretation and decision-making.

