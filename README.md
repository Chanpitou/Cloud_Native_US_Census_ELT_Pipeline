# Cloud_Native_US_Census_ELT_Pipeline
A cloud-native, serverless ELT pipeline automating ingestion and modeling of US Census metrics at the county grain.  Extracts raw JSON via AWS Lambda into Amazon S3, loads it into a Snowflake RAW VARIANT tier, and transforms it with dbt into a Kimball Star Schema inside an ANALYTICS database for cloud-based BI visualization.
