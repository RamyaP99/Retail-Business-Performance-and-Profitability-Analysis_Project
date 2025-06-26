# 1)Retail-Business-Performance-and-Profitability-Analysis

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
         └── retail_sales_dataset.csv              # Kaggle dataset
         └── inventory_sales_correlation_data.csv  # Correlation output
          sql/
         └── create_retail_analysis.sql            # MySQL schema 
         └── retail_business(SQL Results)          # Table Results
          python/
         └── Inventory Turnover.ipynb              # Python script for correlation
         └── Seasonal Trends.ipynb    
          powerbi/
         └── retail_insights.pbix (and Dashboard pdf)     # Power BI dashboard
          docs/
         └── README.md                            # This file


### 1.SQL (data prep and analysis)	

* Data Cleaning Summary
  
      - Removed null values in: ProductCategory, Date, PricePerUnit

      - Removed transactions with zero or negative quantity

* Profitability Analysis
  
      - Categories with highest/lowest profit margins


### 2.Python (EDA, correlations)

* Inventory Turnover vs Profitability
  
      - InventoryDays estimation logic
 
      - Correlation coefficient between InventoryDays and Profit

      - Scatter plot analysis

* Seasonal Trends
  
      - Monthly sales trends (line plot)

      - Peak and low seasons

      - Suggestions for promotions/inventory planning

### 3.Power BI (dashboard)

Power BI Dashboard Overview
* **Filters:** Gender, Product Category, Age Group, Time Period (Year/Month)
* **Visuals:** sale and Profit by Product-Category, Inventory Days vs Profit, Monthly Sales
* **Key insights** visible interactively

### 4.PDF Report (insights + recommendations)

**Recommendations**

* Drop or rethink low-margin categories

* Promote fast-selling seasonal products

* Improve stock management of slow movers



# 2)Financial-KPI-Analysis-for-a-Startup

**Project Overview**

This project analyzes key financial performance indicators (KPIs) for an early-stage SaaS startup using the AWS SaaS Sales dataset. The objective is to compute and visualize monthly revenue, burn rate, customer acquisition cost (CAC), lifetime value (LTV), LTV:CAC ratio, and run rate, while performing cohort analysis for monthly customer groups. The deliverables include a Tableau dashboard, an LTV:CAC report in PDF, and an Excel model template.

**Dataset**

AWS SaaS Sales Dataset: https://www.kaggle.com/datasets/nnthanh101/aws-saas-sales


**Objectives**

1. Collect and preprocess financial data (expenses, revenue, customer base).
2. Compute LTV, CAC, and LTV:CAC ratio.
3. Build a Tableau dashboard with trend indicators for KPIs.
4. Perform cohort analysis for monthly customer groups.
5. Deliver:

   * **Tableau dashboard** visualizing KPIs and trends.
   * **LTV:CAC report** in PDF format.
   * **Excel model template** for KPI calculations.

**Tools**

Excel: For data preprocessing and creating the model template.

Tableau: For building an interactive dashboard.

Python (Pandas): For data cleaning, aggregation, and cohort analysis.

### Repository Structure

 Financial KPIs for startups /

          data/
         └── Saas_Sales_dataset.csv               # Kaggle dataset
          python/
         └── Financial_KPI.ipynb                  # Python script for cohort analysis
          Excel/
         └── Financial_KPI_Model.xlsx             # Excel Model template
          Tableau/
         └── Financial_KPI_Dashboard.twb (and Dashboard pdf)     # tableau dashboard
          docs/
         └── LTV_CAC_Report.pdf                   # pdf report of LTV:CAC Ratio
         └── README.md                            # This file

### Data Preparation

1. Download the Dataset
2. Preprocess Data
3. Prepare Additional Datasets:
   * Create **monthly_revenue.csv**: Aggregate Sales by Month-Year.
   * Create **monthly_burn_rate.csv**: Estimate burn rate (e.g., assume fixed monthly expenses or derive from Profit if negative).
   * Create **monthly_CAC.csv**: Estimate CAC (e.g., marketing costs divided by new customers per month; assume constant marketing spend if not provided).
     
### Excel Model Template

**Create Template:**

Open Excel and create a workbook (kpi_model.xlsx).

Include sheets:
 * **Revenue**: Columns for Month-Year, Revenue (from monthly_revenue.csv).
 * **Burn Rate**: Columns for Month-Year, Burn Rate (assumed or derived).
 * **CAC**: Columns for Month-Year, New Customers, Marketing Spend, CAC (calculated as Marketing Spend / New Customers).
 * **LTV**: Columns for Customer ID, Total Sales, Lifespan, LTV (calculated as Total Sales * Lifespan).
 * **LTV:CAC**: Columns for Month-Year, LTV, CAC, LTV:CAC Ratio.

   Add formulas for calculations (e.g., =B2/C2 for LTV:CAC ratio).

### LTV:CAC Report in PDF

Calculate LTV and CAC:

**LTV**: Estimate as average revenue per customer (SUM(Sales) per Customer ID) multiplied by average customer lifespan (assume 3 years if unknown).

**CAC**: Estimate as total marketing spend (assumed or external data) divided by new customers per Month-Year.

Example Python script (ltv_cac.py):

              import pandas as pd
              df = pd.read_csv('data/aggregated_sales.csv')
              ltv = df.groupby('Customer ID')['Sales'].sum().mean() * 3  # Assume 3-year lifespan
              cac = 1000 / df.groupby('Month-Year')['Customer ID'].nunique().mean()  # Assume $1000 monthly marketing
              ltv_cac_ratio = ltv / cac
              print(f"LTV: ${ltv:.2f}, CAC: ${cac:.2f}, LTV:CAC: {ltv_cac_ratio:.2f}")

### Tableau Dashboard

1. Connect Data Sources
2. Create Worksheets:
    * Revenue Trend: Line chart with Month-Year (Columns) and SUM(Sales) or Revenue (Rows).
    * Burn Rate: Line chart with Month-Year (Columns) and Burn Rate (Rows).
    * CAC: Line chart with Month-Year (Columns) and CAC (Rows). 
    * Cohort Analysis: Heatmap with Cohort Month (Columns), Month-Year (Rows), and SUM(Sales) (Color).
    * LTV:CAC Ratio: Bar chart with Month-Year (Columns) and calculated LTV:CAC (Rows)



**Deliverables**

* **Tableau Dashboard:** Financial_KPI_Dashboard.twbx (visualizes revenue, burn rate, CAC, LTV:CAC, and cohort trends).
* **LTV:CAC Report:** LTV_CAC_Report.pdf.
* **Excel Model Template:** Financial_KPI_Model.xlsx (for KPI calculations and data input).
