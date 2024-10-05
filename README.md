# Chocolate Store Data Analysis

## Table of Contents

- [Project Overview](#project-overview)
- [Data Source](#data-source)
- [Database or Tools Used](#database-or-tools-used)
- [Data Preparation](#data-preparation)
- [Exploratory Data Analysis](#exploratory-data-analysis)
- [Results or Findings](#results-or-findings)
- [Recommendations](#recommendations)
- [Limitations](#limitations)


### Project Overview

This data analysis project aims to provide insights into the sales performance of a chocolate store. By examining different aspects of the sales figures, we strive to uncover valuable insights and understand the store's performance on a deeper level.


### Data Source

The primary dataset used for the analysis is the 'chocolate-store-database.sql' file, containing detailed information about each sale made by the store.


### Database or Tools Used

- MySQL - For analyzing the data


### Data Preparation

In the initial data preparation phase I performed the following tasks:
1. Data loading and inspection.
2. Handling missing values.
3. Data cleaning and formatting.


### Exploratory Data Analysis

EDA involved exploring the sales data to answer key questions, such as:
- What is the Average Order Value?
  ```sql
  SELECT ROUND(SUM(amount)/COUNT(distinct SPID), 2) AS Average_order_value
  FROM sales;
  ```
- What is the total Revenue?
  ```sql
  SELECT SUM(Amount) AS Total_revenue 
  FROM sales;
  ```
- Which shipments had under 100 customers & under 100 boxes? Did any of them occur on Wednesday? 
  ```sql
  SELECT * 
  FROM sales 
  WHERE customers <100 AND boxes <100 AND dayname(saledate) = 'Wednesday'; 
  ```


### Results or Findings

The analysis results are summarized as follows:

Over the past year, the store's sales have consistently risen, with a significant peak observed during winter. Notably, 'After Nines' has emerged as the top performer in revenue and 'Orange Chocolate' in max. number of boxes shipped.


### Recommendations

Based on the analysis, I recommend the following actions:

To boost revenue, allocate resources to marketing and promotions during peak sales periods. Prioritize the growth and promotion of After Nines Chocolates.


### Limitations

I had to remove all zero/missing values from the amount and boxes columns because they would have affected the accuracy of my calculations from the analysis. 
