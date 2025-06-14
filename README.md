# Retail-Business-Performance-and-Profitability-Analysis

This project analyzes retail sales data to uncover trends, seasonality, and inventory turnover patterns, enabling data-driven decisions for inventory optimization and marketing strategies. Built using the Kaggle Retail Sales Dataset, the project features an interactive Power BI dashboard with visuals like heatmaps, KPI charts, and area charts, and filters for ProductCategory, and season (MonthName, Quarter).

**Objectives:**

* Visualize sales trends and quarterly growth.
* Identify seasonal patterns to guide inventory planning.
* Highlight demographic drivers (e.g., Under 25 for Beauty).
* Optimize inventory turnover using correlation analysis.

**Dataset**

Source: Kaggle Retail Sales Dataset.
https://www.kaggle.com/datasets/mohammadtalib786/retail-sales-dataset?utm_source=chatgpt.com

 Fields:

     * TansactionID: Unique transaction identifier.
     * Date: Transaction date (e.g., 2023-01-01).
     * CustomerID: Customer identifier.
     * Gender: Customer gender.
     * Age: Customer age.
     * ProductCategory: Product type (e.g., Electronics, Clothing, Beauty).
     * Quantity: Units sold.
     * PricePerUnit: Price per unit.
     * TotalAmount: Total sales amount (Quantity * PricePerUnit).

**Derived Fields (via Power Query)**

     * MonthName: Month abbreviation (e.g., Jan).
     * MonthOrder: Sorting order (1–12).
     * Quarter: Quarter (e.g., Q1).
     * AgeGroup: Binned age (e.g., Under 25, 25-40).
     * Profit: Simulated (0.4 * TotalAmount, optional).

**Additional Data:**

     * inventory_sales_correlation_data.csv: ProductCategory, TotalSales, AvgInventoryDays (from Python analysis).

### Repository Structure

 retail-business-analysis/

          data/
         └── retail_sales_dataset.csv           # Kaggle dataset
         └── inventory_sales_correlation_data.csv  # Correlation output
          sql/
         └── create_retail_analysis.sql        # MySQL schema 
         └── retail_business(SQL Reults)       # Table Results
          python/
         └── Inventory Turnover.ipynb          # Python script for correlation
         └── Seasonal Trends.ipynb    
          powerbi/
         └── retail_insights.pbix (and Dashboard pdf)     # Power BI dashboard
          docs/
         └── Retail Business Performance_Report.pdf           # Analysis report
         └── README.md                            # This file


### 1.SQL (data prep and analysis)	

* Data Cleaning Summary
  
      - Removed null values in: ProductCategory, Date, PricePerUnit

      - Removed transactions with zero or negative quantity

* Profitability Analysis
  
      Categories with highest/lowest profit margins


### 2.Python (EDA, correlations)

* Inventory Turnover vs Profitability
  
      InventoryDays estimation logic
 
      Correlation coefficient between InventoryDays and Profit

      Scatter plot analysis

* Seasonal Trends
  
      Monthly sales trends (line plot)

      Peak and low seasons

      Suggestions for promotions/inventory planning

### 3.Tableau (dashboard)

Tableau Dashboard Overview
* **Filters:** Gender, Product Category, Age Group, Time Period (Year/Month)
* **Visuals:** sale and Profit by Product-Category, Inventory Days vs Profit, Monthly Sales
* **Key insights** visible interactively

### 4.PDF Report (insights + recommendations)

**Recommendations**

Drop or rethink low-margin categories

Promote fast-selling seasonal products

Improve stock management of slow movers

