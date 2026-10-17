# DBT Cheatsheet

Completed: No

## **Analysis**

#### Example

```sql
{%- set inc_flag=1 -%}
{%- set last_load=3 -%}
{%- set col_list=["sales_id","date_sk","gross_amount"] -%}

SELECT
    {% for i in col_list%}
        {{ i }}
        {%- if not loop.last -%} , {%- endif -%}
    {% endfor %}
FROM 
    {{ref("bronze_sales")}}

{% if inc_flag == 1 %}
    WHERE date_sk > {{last_load}}
{% endif %}
```

---

## Logs

---

## Macros

```sql
{% macro generate_schema_name(custom_schema_name, node) -%}

    {%- set default_schema = target.schema -%}
    {%- if custom_schema_name is none -%}

        {{ default_schema }}

    {%- else -%}

        {{ custom_schema_name | trim }}

    {%- endif -%}

{%- endmacro %}
```

---

## Models

#### Properties

```yaml
version: 2

models:
  - name: table name 1
    columns:
      - name: column -> table 1
        data_tests:
          - unique
          - not_null
  - name: table name 2
    columns:
      - name: column 2 -> table 2
        data_tests:
          - unique
          - not_null
      - name: column 2 -> table 1
        data_tests:
          - accepted_values:
              arguments:
                values: ['Column 2 Values Exact'] 
              config:
                severity: warn
```

#### Source

```yaml
sources:
  - name: Any name
    database: '{{target.catalog}}'  
    schema: schema name  
    tables:
      - name: table name
```

---

## Seeds

---

## Snapshots

```yaml
snapshots:
  - name: snapshot name
    relation: ref('Table name')
    config:
      schema: bronze/silver/gold
      database: '{{target.catalog}}'
      unique_key: primary column
      strategy: timestamp
      updated_at: datetime column
      dbt_valid_to_current: "to_date('9999-12-31')" 
```

---

## Target

---

## Tests

#### Generic

```sql
{%test non_negative(model,column_name)%}

SELECT *
FROM
    {{model}}
WHERE
    {{column_name}} <0

{%endtest%}
```

#### Normal test

---

 

```sql
SELECT *
FROM
    {{ref("table name")}}
WHERE
    refund_amount<0    -- It tests if there are any negative value present
```

---

## Jinja template

---

```yaml

# Name your project! Project names should contain only lowercase characters
# and underscores. A good package name should reflect your organization's
# name or the intended use of these models
name: 'dbt_practise'
version: '1.0.0'

# This setting configures which "profile" dbt uses for this project.
profile: 'dbt_practise'

# These configurations specify where dbt should look for different types of files.
# The `model-paths` config, for example, states that models in this project can be
# found in the "models/" directory. You probably won't need to change these!
model-paths: ["models"]
analysis-paths: ["analyses"]
test-paths: ["tests"]
seed-paths: ["seeds"]
macro-paths: ["macros"]
snapshot-paths: ["snapshots"]

clean-targets:         # directories to be removed by `dbt clean`
  - "target"
  - "dbt_packages"

# Configuring models
# Full documentation: https://docs.getdbt.com/docs/configuring-models

# In this example config, we tell dbt to build all models in the example/
# directory as views. These settings can be overridden in the individual model
# files using the `{{ config(...) }}` macro.
models:
  dbt_practise:
    # Config indicated by + and applies to all files under models/example/
    bronze:
      +materialized: table
      schema: bronze
    silver:
      +materialized: view
      schema: silver
    gold:
      +materialized: table
      schema: gold

seeds:
  dbt_practise:
    +schema: bronze

```

```yaml
dbt_practise:
  outputs:
    dev:
      catalog: catalogname
      host: databricks host Id
      http_path: HTTP Path
      schema: catalog.schema
      threads: 1
      token: dapi61662ed2e1368a358aa7363d311e5990
      type: databricks
    prod:
      catalog: catalogname
      host: databricks host Id
      http_path: HTTP Path
      schema: catalog.schema
      threads: 1
      token: dapi61662ed2e1368a358aa7363d311e5990
      type: databricks
  target: dev
jaffle_shop:
  outputs:
    dev:
      auth_type: token
      database: dbt_dev
      host: dbc-9d228c3b-a78d.cloud.databricks.com
      http_path: /sql/1.0/warehouses/0b64bfddcc91245d
      schema: dbt
      threads: 16
      token: dapida552f9c570fa67ef0761c81962c841edapida552f9c570fa67ef0761c81962c841ev
      type: databricks
  target: dev
jaffle_shop_1:
  outputs:
    dev:
      auth_type: token
      database: dbt
      host: dbc-9d228c3b-a78d.cloud.databricks.com
      http_path: /sql/1.0/warehouses/0b64bfddcc91245d
      schema: default
      threads: 16
      token: dapi921e40bfbc47a153dd7788b78d5ac71c
      type: databricks
  target: dev

```
