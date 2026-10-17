SELECT *
FROM
{{source('bronze_databricks', 'dim_customer')}}