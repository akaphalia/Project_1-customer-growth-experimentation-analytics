# Customer Growth \& Experimentation Analytics

An end-to-end data analytics portfolio project using the Brazilian Olist e-commerce dataset to investigate customer retention, delivery performance, customer satisfaction, and commercial performance.

## Business Problem

Olist has a large customer base, but customer retention is weak. At the same time, delivery performance varies considerably across orders.

This project investigates:

> \\\*\\\*How can Olist increase customer retention while reducing delivery delays?\\\*\\\*

The analysis combines Python ETL, feature engineering, exploratory data analysis, SQL analytics, Power BI, and statistical analysis to identify actionable business opportunities.

## Key Business Findings

### Customer Retention

* Approximately **97% of customers are one-time customers**.
* Only a small proportion of customers make repeat purchases.
* This indicates a major opportunity to improve customer retention and repeat purchasing.

### Delivery Performance

* Approximately **91.9% of delivered orders were on time**.
* Approximately **8.1% were delayed**.
* Average delivery time was approximately **12.56 days**.
* Extremely long delivery durations represent an important customer-experience risk.

### Delivery Time \& Customer Satisfaction

|Analysis|Result|
|-|-:|
|Pearson correlation|**-0.334**|
|Spearman correlation|**-0.235**|
|Delayed-order mean review|**2.57**|
|On-time-order mean review|**4.21**|
|Welch's t-statistic|**-85.07**|
|Welch's test|**p < 0.001**|
|Cohen's d|**-1.30**|
|ANOVA F-statistic|**3597.20**|
|ANOVA|**p < 0.001**|

Review scores declined across every delivery-time category:

|Delivery Time|Average Review Score|
|-|-:|
|0–7 Days|**4.42**|
|8–14 Days|**4.31**|
|15–21 Days|**4.14**|
|22+ Days|**3.12**|

Tukey HSD post-hoc testing showed that **all delivery-time category pairs differed significantly (p < 0.001)**.

> These statistical results demonstrate strong association and group differences; they do not by themselves establish causation.

## Business Recommendations

1. **Prioritize prevention of extreme delivery delays**, particularly orders approaching or exceeding 22 days.
2. **Investigate seller and carrier performance** to identify operational sources of long delivery times.
3. **Monitor high-risk orders proactively** and intervene before delays become severe.
4. **Use delivery performance as a customer-experience KPI**, not only as an operational metric.
5. **Develop customer-retention initiatives** aimed at converting one-time customers into repeat customers.
6. **Segment commercial and product performance** to identify categories and payment behaviors associated with stronger business outcomes.

## Analytical Workflow

```text
Raw Data
   ↓
Data Audit
   ↓
Python ETL
   ↓
Feature Engineering
   ↓
Exploratory Data Analysis
   ↓
SQL Analytics
   ↓
Power BI
   ↓
Statistical Analysis
   ↓
Business Insights \\\& Recommendations
```

## Project Structure

```text
Customer Growth \\\& Experimentation Analytics/
│
├── 01\\\_Raw\\\_Data/
│
├── 02\\\_Data\\\_Audit/
│
├── 03\\\_Python\\\_ETL/
│   ├── Notebooks/
│   └── Output/
│
├── 04\\\_Feature\\\_Engineering/
│   ├── Notebooks/
│   └── Output/
│
├── 05\\\_EDA/
│
├── 06\\\_SQL\\\_Analytics/
│
├── 07\\\_PowerBI/
│
├── 08\\\_Documentation/
│
├── 09\\\_Statistical\_Analysis/
│
└── 10\\\_Images/
```

## Dataset

This project uses the **Brazilian Olist e-commerce dataset**, containing information related to:

* Customers
* Orders
* Order items
* Payments
* Products
* Reviews
* Sellers
* Product category translation

The geolocation dataset was not included because it was not required to answer the project's defined business questions.

### Core Tables

```text
customers
orders
order\\\_items
payments
products
reviews
sellers
product\\\_category\\\_translation
```

## 1\. Data Audit

The data-audit stage examined:

* Dataset dimensions
* Column names and data types
* Missing values
* Duplicate records
* Unique identifiers
* Date fields
* Categorical distributions
* Referential relationships between tables

The objective was to understand the raw data and identify issues before transformation.

## 2\. Python ETL

Python was used to clean and transform the raw Olist datasets.

Main activities included:

* Data type standardization
* Date parsing
* Missing-value handling
* Duplicate checks
* Column standardization
* Validation of key fields
* Export of cleaned datasets

### Tools

* Python
* Pandas
* NumPy
* Matplotlib
* Jupyter Notebook

## 3\. Feature Engineering

Features were created to support operational, customer, commercial, and time-based analysis.

### Orders

Key operational features include:

* `approval\\\_time\\\_hours`
* `processing\\\_time\\\_hours`
* `transit\\\_time\\\_days`
* `delivery\\\_time\\\_days`
* `estimated\\\_delivery\\\_days`
* `delivery\\\_delay\\\_days`
* `delivered\\\_on\\\_time`

Time-intelligence features include:

* `purchase\\\_month`
* `purchase\\\_year`
* `purchase\\\_quarter`
* `purchase\\\_day\\\_of\\\_week`
* `purchase\\\_hour`
* `is\\\_weekend\\\_order`
* `purchase\\\_year\\\_month`

Feature engineering was intentionally kept focused on features that support the project's business questions.

## 4\. Exploratory Data Analysis

EDA was performed to identify patterns and generate hypotheses for deeper analysis.

Areas examined included:

### Customer Analytics

* Customer distribution
* Geographic concentration
* One-time vs repeat customers
* Customer retention patterns

### Order \& Delivery Analytics

* Order status
* Delivery performance
* Delivery time distribution
* Delivery delay distribution
* On-time vs delayed orders

### Product Analytics

* Product category performance
* Items sold
* Revenue
* Average selling price
* Delivery performance
* Review scores

### Seller Analytics

* Seller distribution
* Seller performance
* Delivery-related patterns
* Customer experience indicators

## 5\. SQL Analytics

SQL Server was used to answer business questions from the transformed datasets.

### Database

```text
CustomerGrowthAnalytics
```

### DBMS

```text
Microsoft SQL Server / SSMS
```

The SQL analysis is organized around business questions:

* Customer Analytics
* Order Analytics
* Product Analytics
* Seller Analytics

Each analysis follows:

```text
Business Question
      ↓
Objective
      ↓
SQL Query
      ↓
Business Insight
```

SQL techniques include:

* Aggregations
* GROUP BY
* CASE expressions
* CTEs
* Window functions
* Ranking
* Conditional calculations
* Date-based analysis
* Multi-table joins

## 6\. Power BI

Power BI was used to convert analytical findings into an interactive business dashboard.

The report includes pages covering areas such as:

* Delivery \& Customer Experience
* Commercial Performance
* Payment Performance
* Summary / Results

The dashboard includes:

* KPI cards
* Bar charts
* Category analysis
* Payment analysis
* Interactive slicers
* Navigation buttons
* Home / previous-page navigation

## 7\. Statistical Analysis

Statistical analysis was performed in Python to validate important patterns identified during EDA and Power BI.

### Correlation Analysis

Pearson and Spearman correlations evaluated the relationship between delivery time and review score.

```text
Pearson  r = -0.334
Spearman ρ = -0.235
```

Both indicate a negative association between delivery duration and customer review score.

### Welch's Independent Two-Sample t-Test

The test compared review scores between delayed and on-time orders.

```text
Delayed mean  = 2.57
On-time mean  = 4.21

t = -85.07
p < 0.001
Cohen's d = -1.30
```

### One-Way ANOVA

ANOVA compared review scores across:

```text
0–7 Days
8–14 Days
15–21 Days
22+ Days
```

Results:

```text
F = 3597.20
p < 0.001
```

### Tukey HSD

Post-hoc Tukey testing showed that every pair of delivery-time categories had a statistically significant difference in mean review score.

## Technology Stack

|Area|Tools|
|-|-|
|Data processing|Python, Pandas, NumPy|
|Visualization|Matplotlib, Power BI|
|Statistical analysis|SciPy, Statsmodels|
|Database|Microsoft SQL Server|
|SQL development|SSMS|
|BI / Reporting|Power BI, DAX|
|Version control|Git, GitHub|
|Documentation|Markdown, Jupyter Notebook|

## Analytical Skills Demonstrated

* Data cleaning
* ETL
* Feature engineering
* Exploratory data analysis
* Business-question-driven SQL
* Advanced SQL
* Window functions
* CTEs
* Data visualization
* Power BI dashboard development
* DAX
* Statistical hypothesis testing
* Correlation analysis
* Welch's t-test
* One-way ANOVA
* Tukey HSD
* Effect-size analysis
* Business interpretation
* Data storytelling

## Key Takeaway

The analysis shows that **customer retention is a major growth challenge**, while delivery performance is a major customer-experience lever.

Although most orders are delivered on time, review scores decline substantially as delivery duration increases. The **22+ day delivery segment is particularly concerning**, receiving substantially lower ratings than faster delivery segments.

Therefore, Olist can potentially improve customer satisfaction and support retention by focusing on:

> \\\*\\\*Reducing extreme delivery durations, improving delivery reliability, and converting one-time customers into repeat customers.\\\*\\\*

## Disclaimer

The statistical analysis identifies associations and statistically significant differences within the available dataset. These findings should not be interpreted as definitive causal effects without controlled experimentation or additional causal analysis.

