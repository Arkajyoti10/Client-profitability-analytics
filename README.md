# Client-profitability-analytics
This project analyzes client-level profitability for a professional services firm, going beyond top-line revenue to answer the question that actually drives business decisions: which clients are we truly making money on, once staffing cost, fee discounting, and overhead are factored in?

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

## Approach
1. SQL — join time_entries → engagements → clients, roll up to client-level revenue, cost, and margin

