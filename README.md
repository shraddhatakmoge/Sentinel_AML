# 🛡️ Sentinel AML Dashboard
### Anti-Money Laundering Intelligence Dashboard using PostgreSQL & Power BI

An interactive Business Intelligence dashboard built to analyze Anti-Money Laundering (AML) transaction data using PostgreSQL and Power BI.

The project focuses on identifying suspicious transaction patterns, high-value transfers, currency mismatches, self-transactions, and other risk indicators through SQL analysis and interactive dashboards.

---

# 📌 Project Overview

Financial institutions process millions of transactions every day. Finding suspicious patterns manually is difficult and time-consuming.

This project demonstrates how SQL and Power BI can be combined to transform raw transaction data into meaningful insights through interactive visualizations.

The dashboard allows users to explore transactions using multiple filters and monitor important AML risk indicators.

---

# 🎯 Objectives

- Analyze large-scale financial transaction data
- Identify suspicious transaction patterns
- Perform SQL-based exploratory analysis
- Build interactive Power BI dashboards
- Create business-friendly KPI reports
- Practice real-world data analytics workflow

---

# 📊 Dashboard Preview

### Summary Dashboard

<img width="629" height="398" alt="Screenshot 2026-07-06 201934" src="https://github.com/user-attachments/assets/54df5428-f12f-4104-aa46-b5120bc5dc62" />


---

### Risk Analysis Dashboard

<img width="628" height="399" alt="Screenshot 2026-07-06 201959" src="https://github.com/user-attachments/assets/7d2fd348-dabb-43da-bf9b-8f518253fdb7" />


---

# 📂 Dataset

**Dataset Used**

IBM Anti-Money Laundering (AML) Transaction Monitoring Dataset

Source:
[https://www.kaggle.com/](https://www.kaggle.com/datasets/ealtman2019/ibm-transactions-for-anti-money-laundering-aml)

Dataset Highlights

- 3.15+ Million Transactions
- 30K+ Banks
- Multiple Payment Formats
- Multiple Currencies
- Legitimate & Suspicious Transactions

---

# 🛠 Tech Stack

- PostgreSQL
- SQL
- Power BI Desktop
- Power BI Service
- Power Query
- DAX

---

# 🔄 Project Workflow

```
IBM AML Dataset
        │
        ▼
Data Cleaning (Power Query)
        │
        ▼
PostgreSQL Database
        │
        ▼
SQL Analysis
        │
        ▼
Power BI Data Model
        │
        ▼
DAX Measures
        │
        ▼
Interactive Dashboard
        │
        ▼
Published to Power BI Service
```

---

# 📈 Dashboard Features

### Executive Summary

- Total Transactions
- Total Amount
- Suspicious Transactions
- High Value Transactions
- Total Banks
- Payment Format Distribution
- Daily Transaction Trend
- Currency Mismatch Analysis
- Laundering Distribution

---

### Risk Analysis

- Risk Score Distribution
- High Value Transactions Trend
- Near Threshold Transactions
- Self Transactions
- Cross Bank Transactions
- Top Sender Banks
- Currency Mismatch Analysis
- Interactive Filters

---

# 🧠 SQL Analysis

SQL was used to perform exploratory analysis before building the dashboard.

Some of the analysis performed includes:

- High Value Transactions
- Suspicious Transactions
- Currency Mismatch Detection
- Cross Bank vs Same Bank Transactions
- Payment Format Analysis
- Laundering Rate by Bank
- Receiver Analysis
- Sender Analysis
- Fan-In / Fan-Out Analysis
- Window Functions
- Ranking Functions
- Running Totals
- Common Table Expressions (CTEs)

---

## SQL Query Screenshots

### SQL Screenshot 1

<img width="723" height="393" alt="Screenshot 2026-07-06 214540" src="https://github.com/user-attachments/assets/04f96855-4f15-4f83-8607-14b4ae6e9969" />


---

### SQL Screenshot 2

<img width="721" height="392" alt="Screenshot 2026-07-06 214559" src="https://github.com/user-attachments/assets/32f56b85-fad2-48f9-8aa4-88282ea8828c" />


---

### SQL Screenshot 3

<img width="721" height="392" alt="Screenshot 2026-07-06 214559" src="https://github.com/user-attachments/assets/514d2a31-a398-43b6-9da0-465825400569" />


---

# 📊 Key Insights

- Processed over **3.15 Million** transactions
- Detected **3,023** suspicious transactions
- Identified **138K+** high-value transactions
- Found **42K+** currency mismatch transactions
- Analyzed transactions across **30K+ banks**
- Built interactive dashboards using Power BI

---

# 📁 Repository Structure

```
Sentinel_AML
│
├── data
├── sql
├── notebooks
├── powerbi
└── README.md
```

---

# 🚀 How to Run

1. Clone the repository

```
git clone https://github.com/yourusername/Sentinel-AML-Dashboard.git
```

2. Open PostgreSQL and execute the SQL scripts.

3. Open the Power BI (.pbix) file.

4. Refresh the dataset if required.

5. Explore the interactive dashboards.

---

# 📚 Skills Demonstrated

- SQL
- PostgreSQL
- Power BI
- Power Query
- DAX
- Data Cleaning
- Data Modeling
- Business Intelligence
- Dashboard Design
- Exploratory Data Analysis
- Data Visualization

---

# 📌 Future Improvements


- Machine Learning risk prediction
- Real-time transaction monitoring
- Drill-through reports


---


# 👨‍💻 Author

**Shraddha Takmoge**

If you found this project interesting, feel free to ⭐ the repository and connect with me on LinkedIn.

LinkedIn:
**[Add LinkedIn Profile Link Here](https://www.linkedin.com/in/shraddha-takmoge/)**

GitHub:
**[Add GitHub Profile Link Here](https://github.com/shraddhatakmoge)**
