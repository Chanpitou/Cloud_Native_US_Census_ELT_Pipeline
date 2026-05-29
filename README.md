# Cloud-Native US Census ELT Pipeline
## Executive Summary
This project is a cloud-native ELT (Extract, Load, Transform) pipeline designed to ingest, process, 
and visualize demographic and economic data from the US Census Bureau API. The primary objective is to transform raw governmental 
JSON payloads into an enterprise-grade dimensional model that fuels a high-resolution Amazon QuickSight dashboard.
The resulting business intelligence suite analyzes and tracks regional income, housing affordability, and educational attainment baselines across the United States.


## Architecture & Tech Stack
This project leverages a modern data stack architecture to ensure scalability, modularity, and data integrity:
 - **Extraction & Orchestration:** Python running on **AWS Lambda**, extracted JSON data from the US Census Bureau API.
 - **Data Lake (Landing Zone):** **AWS S3** for secure, scalable storage of raw JSON extracts.
 - **Data Warehouse:** **Snowflake**, utilizing automated ingestion (**Snowpipe**) to move data from **AWS S3** into raw staging tables.
 - **Transformation & Modeling:** **dbt** (Data Build Tool) to execute SQL-based transformations, enforce testing, and build a clean Star Schema.
 - **Business Intelligence:** **AWS QuickSight** for interactive, executive-facing dashboards and geospatial analytics.

![Project_Diagram](images/Project_Overview_Diagram.jpeg)

## Data Transformation & Dimensional Modeling
Once the raw data lands in Snowflake, dbt is utilized to clean, normalize, and model the data into a production-ready Star Schema.

Key Modeling Highlights:
- **Staging Layer:** Cleans raw API column names, standardizes data types, and handles null values. 
- **Core Layer (Dimensions & Facts):** Splits the data into logical entities (e.g., dim_locations for State/County mappings, fact_economic_metrics for income and poverty measurements). 
- **Aggregation Logic:** Ensures percentage-based metrics (like POVERTY_RATE and BACHELORS_DEGREE_RATE) are pre-calculated accurately to prevent erroneous summation at the BI layer.

![Data_Model](images/data_model.png)

## Dashboard & Visual Analytics
The visualization layer was built in Amazon QuickSight to provide actionable insights into socioeconomic trends without overwhelming the end-user with raw data points.
Dashboard Features:

- **Executive KPI Summaries:** High-level metrics formatting median household income, median home values, and total population counts with clean currency and numeric formatting.
- **State-Level Education Attainment vs. Poverty Rate:** A dual-metric clustered bar chart that cleanly visualizes the contrast between a state's higher education rate and its baseline poverty rate, instantly highlighting regional opportunity gaps.
- **Granular Socioeconomic Reference Table:** A detailed, searchable matrix allowing stakeholders to verify the exact calculated averages for local counties.
- **Targeted Rankings (Bar Charts):** Side-by-side comparative views isolating economic extremes across mainland US counties:
    * *Top 10 Highest-Earning Counties:* Ranked by median household income.
    * *Top 10 Economically Vulnerable US Counties:* Ranked by poverty rate (filtered to exclude regional territorial anomalies).

![Dashboard](images/US_Census_AWS_QuickSight.png)

## 🔮 Future Improvements & Automation Roadmap
To scale this foundational prototype into a fully automated enterprise data pipeline, the following production upgrades are planned:
1. **Workflow Orchestration:** Integrate **Apache Airflow** or **Prefect** to coordinate task dependencies, manage retries, and eliminate manual triggers between the extraction and transformation phases.
2. **CI/CD Integration:** Set up GitHub Actions to automate dbt testing (`dbt test`) and deployment models on code commits to guarantee data quality before production runs.
