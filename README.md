Got you — here is the **full README in clean Markdown**, formatted perfectly for GitHub.
Just copy–paste into your repo as `README.md`.

---

# 📊 Marketing Attribution Data Pipeline

### **Snowflake | dbt Cloud | Streamlit | Staging → Transform → Orchestrate → Visualize**

This project demonstrates a **complete modern data pipeline** using Snowflake, dbt Cloud, and Streamlit — starting from ingesting raw CSVs into Snowflake, transforming them with dbt, orchestrating automated runs, and visualizing business insights in an interactive dashboard.

---

## 📁 Repository Structure

```
├── models/
│   ├── sources/                # RAW source definitions
│   ├── staging/                # Cleaned and standardized models
│   ├── intermediate/           # Aggregations / rollups
│   └── marts/                  # Final analytics tables
│
├── snapshots/                  # dbt snapshots (if enabled)
├── tests/                      # Custom and generic dbt tests
├── streamlit_app/              # Streamlit dashboard
│   └── app.py
│
├── packages.yml                # dbt packages (dbt_utils)
├── dbt_project.yml             # dbt configuration
└── README.md                   # You're reading this!
```

---

# 🚀 Project Overview

This project simulates a **6-month marketing attribution dataset** with channels such as Google Ads, Meta Ads, and web session + order data.
The pipeline covers:

### **1️⃣ Loading data → Snowflake RAW**

* Upload CSV files from local machine using a **Snowflake stage**
* Create RAW tables
* Ingest data using `COPY INTO`

### **2️⃣ Transforming with dbt Cloud**

* Create staging models (`stg_google_ads`, `sessions_clean`, `orders_clean`)
* Build intermediate models (daily spend, attribution inputs)
* Build final marts (channel performance, ROAS, conversions)
* Add dbt tests, snapshots, documentation, and lineage

### **3️⃣ Orchestrating with dbt Cloud Jobs**

* Schedule daily `dbt build`
* Run `dbt test` automatically
* (Optional) Run snapshots + exposures

### **4️⃣ Visualizing in Streamlit**

* Build an interactive dashboard to view:

  * Daily spend trends
  * Clicks, impressions, orders, revenue
  * CAC, ROAS, CPV metrics
  * Campaign filtering + comparison
  * Budget simulation (increase spend → project impact)

---

# 🧊 1. Loading Data Into Snowflake

### **Create and use database + schemas**

```sql
CREATE DATABASE MARKETING_ANALYTICS;
CREATE SCHEMA RAW;
CREATE SCHEMA ANALYTICS;
```

### **Create stage**

```sql
CREATE OR REPLACE STAGE raw_stage;
```

### **Upload CSVs**

Using UI → Load Files → Choose `raw_stage`

Example files:

```
google_ads_6months.csv
meta_ads_6months.csv
sessions_6months.csv
orders_6months.csv
```

### **Create RAW tables**

```sql
CREATE OR REPLACE TABLE RAW.GOOGLE_ADS (...);
CREATE OR REPLACE TABLE RAW.META_ADS (...);
CREATE OR REPLACE TABLE RAW.SESSIONS (...);
CREATE OR REPLACE TABLE RAW.ORDERS (...);
```

### **Load data**

```sql
COPY INTO RAW.GOOGLE_ADS
FROM @raw_stage/google_ads_6months.csv
FILE_FORMAT = (TYPE=CSV SKIP_HEADER=1);
```

Repeat for other tables.

---

# 🛠 2. Building Transformations in dbt Cloud

### **Source definitions**

`models/sources/src_marketing.yml` declares RAW tables.

### **Staging models (clean data)**

Examples:

* `stg_google_ads.sql`
* `sessions_clean.sql`
* `orders_clean.sql`

### **Intermediate models**

* Daily spend aggregations
* Combine sessions + orders
* Channel performance by date

### **Analytics marts**

* `fct_marketing_performance`
* ROAS metrics, conversions, CAC

### **dbt tests**

Examples included:

* `not_null`
* `unique`
* `accepted_values`
* `relationships`
* `dbt_utils.greater_than`
* custom generic tests

### **Snapshots**

Track how spend or campaign metrics change over time.

---

# 📅 3. Orchestration With dbt Cloud Jobs

This project uses dbt Cloud to orchestrate:

### **Daily job**

```
dbt build
```

Includes:

✔ Models
✔ Tests
✔ Snapshots
✔ Documentation refresh

### Optional add-ons:

* Slack alerts
* Environment promotion
* GitHub PR triggers

---

# 📈 4. Analytics Dashboard — Streamlit

The `streamlit_app/app.py` connects directly to Snowflake using Snowpark.

### Dashboard features:

* Channel spend vs revenue
* ROAS over time
* Campaign-level performance
* Search filters + dropdowns
* KPI cards
* Time-series line charts
* Budget scaling simulator (+10%, +20%, custom)

### Run locally:

```bash
pip install streamlit snowflake-connector-python pandas
streamlit run streamlit_app/app.py
```

---

# 🧪 Data Quality With dbt Tests

### Included Tests

* **not_null** (IDs, dates, user IDs)
* **unique** (session_id, order_id)
* **greater_than / greater_than_or_equal_to** (cost > 0)
* **accepted_values** (date ranges)
* **relationships** (orders → sessions)
* **custom generic tests**

  * no_future_dates
  * valid_channel
  * positive_rate

All tests passed successfully via dbt Cloud.

---

# 🌐 Modern Data Stack Architecture

```
Local CSV → Snowflake Stage → RAW Tables
→ dbt Staging → dbt Intermediate → dbt Marts
→ Streamlit Dashboard Visualization
→ dbt Cloud Jobs (Orchestration)
```

This architecture is similar to how real data teams build production ELT pipelines.

---

# 🎯 Business Use Case

This pipeline answers:

* Which channels drive the highest ROAS?
* Which campaigns are overspending or underspending?
* How many sessions convert into orders?
* What happens if we increase a channel's budget?
* Which channel contributes to the highest revenue per dollar?

Useful for growth teams, analysts, and marketing leadership.

---

# 🚀 Future Enhancements

* Multi-touch attribution (Shapley, Markov chains)
* Incremental ingestion & SCD Type 2
* Airflow orchestration (Astro)
* ML-driven spend forecasting
* Deploy Streamlit to cloud (GCP/AWS/Streamlit Cloud)
* Add CI/CD for dbt (PR builds)

---

# 👩‍💻 Author

**Vandana Bhumireddygari**
Masters Student — University of Texas at Dallas
Data Engineer & Analytics Engineer
Snowflake | dbt | Databricks | Airflow | Python






### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [dbt community](https://getdbt.com/community) to learn from other analytics engineers
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
