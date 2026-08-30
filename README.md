# Client-profitability-analytics
SQL + Python pipeline that analyzes client-level profitability for a professional services firm-modeling fee realization, staffing cost, and margin drag to automatically flag underpriced or unprofitable clients and generate a partner-ready action memo.

This project goes beyond top-line revenue to answer the question that actually drives business decisions: which clients are we truly making money on, once staffing cost, fee discounting, and overhead are factored in - and why?

Using a synthetic dataset modeled on real audit/advisory engagement economics (negotiated fixed fees, staff time entries, billing vs. cost rates, quarterly overhead), the project builds a full automated pipeline: SQL rolls up granular time-entry data to the client level, Python segments and flags underperforming clients, an LLM synthesizes the findings into prose, and the result is assembled into a formatted Word document — no manual steps required after running one script.

## Business Question
Which clients and engagements are actually profitable once you account for the true cost of serving them — negotiated fee discounts, actual staffing cost, and overhead — not just top-line revenue? Where should the firm reallocate capacity, repricing, or scope?

## Data
Synthetic dataset built to mirror how a professional services firm (audit/advisory/consulting) tracks engagements. Data is randomly generated but structured to reflect realistic dynamics: fixed-fee engagements negotiated below or above standard list-rate value, variable staff realization (over/under budgeted hours), and quarterly overhead allocation.
| File | Rows | Description |
| --- | --- | --- |
| data/clients.csv | 40 | Client roster-industry, region, relationship tenure |
| data/staff.csv | 212 | Staff roster-level, billing rate, fully-loaded cost rate |
| data/engagements.csv | 81 | Projects per client-negotiated fee vs. standard value at list rates |
| data/time_entries.csv | 14,560 | Weekly hours logged per staff member per engagement, with billed and cost amounts |
| data/overhead_allocation.csv | 320 | Quarterly overhead allocation allocated per client |

## Pipeline
extract.py ----> segment.py ----> flag.py ----> report.py

1. ### SQL Analysis
(sql/profits/profitability_analysis.sql)
A layered CTE query joining time entries → engagements → clients → quarterly overhead, producing one row per client with revenue, cost, gross margin %, net margin % (after overhead), and realization rate (negotiated fee vs. standard list-rate value).

### Key decisions:
1. Percentages computed from summed dollar totals, never averaged directly
2. LEFT JOIN throughout to preserve records with missing data, with explicit NULL checks
3. MAX() used when pulling a per-client value into a query joined at a finer grain

### Output:
one row per client — engagement count, revenue, cost, gross margin %, net margin % (after overhead), and realization rate (negotiated fee vs. standard list-rate value) — exported to CSV for the Python segmentation step.

