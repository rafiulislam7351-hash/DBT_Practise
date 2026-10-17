# DBT_Practise

Welcome to the `DBT_Practise` repository! This project demonstrates how to set up and configure a dbt (Data Build Tool) project connected to a Databricks environment. 

We use [uv](https://github.com/astral-sh/uv), a lightning-fast Python package installer and resolver, to manage our dependencies efficiently.

## Prerequisites

Before getting started, ensure you have the following:
* Python installed on your local machine.
* Access to a Databricks workspace (Cluster and SQL Warehouse details).

## Setup Instructions

Follow these steps to set up the project locally:

### 1. Install `uv`
First, install `uv` to manage our Python packages much faster than standard pip.
```bash
pip install uv
```

### 2. Install `dbt-core`
Use `uv` to add the core dbt package to your environment.
```bash
uv pip install dbt-core
```
*(Note: If you are using a virtual environment managed by uv, you can use `uv add dbt-core`)*

### 3. Install the Databricks Adapter
Next, install the Databricks adapter for dbt so it can communicate with your Databricks workspace.
```bash
uv pip install dbt-databricks
```

### 4. Initialize the dbt Project
Run the initialization command to scaffold your dbt project. This will prompt you for your project name and connection details.
```bash
dbt init
```

### 5. Configure Your Profile
After initialization, configure your `profiles.yml` file (typically located in `~/.dbt/profiles.yml`). You will need to provide your Databricks host, HTTP path, and a Personal Access Token (PAT) to establish the connection.

### 6. Create Source Schema & Tables in Databricks
Before running your dbt models, make sure your raw data is ready. Log into your Databricks workspace and create the necessary source schemas (databases) and tables that your dbt project will reference and transform.

## Next Steps

Once configured, you can verify your connection by running:
```bash
dbt debug
```
And run your models using:
```bash
dbt run
```
