# Retail-Business-Performance-and-Profitability-Analysis

This project analyzes retail sales data to uncover trends, seasonality, and inventory turnover patterns, enabling data-driven decisions for inventory optimization and marketing strategies. Built using the Kaggle Retail Sales Dataset, the project features an interactive Power BI dashboard with visuals like heatmaps, KPI charts, and area charts, and filters for ProductCategory, and season (MonthName, Quarter).

**Objectives:**

* Visualize sales trends and quarterly growth.
* Identify seasonal patterns to guide inventory planning.
* Highlight demographic drivers (e.g., Under 25 for Beauty).
* Optimize inventory turnover using correlation analysis.

**Dataset**

Source: Kaggle Retail Sales Dataset.

Fields:

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

retail-business-analysis/

          data/
            *  retail_transactions.csv           # Kaggle dataset
            *  inventory_sales_correlation_data.csv  # Correlation output
          sql/
         └── create_retail_analysis.sql        # MySQL schema 
          python/
         └── Inventory Turnover.ipynb          # Python script for correlation
         └── Seasonal Trends.ipynb    
          powerbi/
         └── retail_insights.pbix (and Dashboard pdf)       # Power BI dashboard
          docs/
         └── retail_insights_Report.pdf           # Analysis report
         └── README.md                            # This file


	






