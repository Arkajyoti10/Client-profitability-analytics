# Client-profitability-analytics
This project analyzes client-level profitability for a professional services firm, going beyond top-line revenue to answer the question that actually drives business decisions: which clients are we truly making money on, once staffing cost, fee discounting, and overhead are factored in?

Using a synthetic dataset modeled on real audit/advisory engagement economics — negotiated fixed fees, staff time entries, billing vs. cost rates, and quarterly overhead allocation — the project builds a full profitability pipeline: SQL to roll up granular time-entry data to the client level, Python to calculate margin and segment clients into a profitability matrix, and an Excel model as the final auditable deliverable. The goal is to identify underpriced engagements, quantify margin drag from heavy discounting, and recommend where the firm should reprice, scale back, or double down.

## Business Question
Which clients and engagements are actually profitable once you account for the true cost of serving them — negotiated fee discounts, actual staffing cost, and overhead — not just top-line revenue? Where should the firm reallocate capacity, repricing, or scope?
