SELECT *
FROM
{{source('bronze_databricks', 'fact_returns')}}