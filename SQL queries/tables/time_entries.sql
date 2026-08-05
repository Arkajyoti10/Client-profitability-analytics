CREATE TABLE time_entries(
	time_entry_id VARCHAR(250),
	engagement_id VARCHAR(250),
	client_id VARCHAR(250),
	staff_id VARCHAR(250),
	staff_level VARCHAR(250),
	week_start_date DATE,
	hours_logged NUMERIC,
	billing_rate_per_hr NUMERIC,
	cost_rate_per_hr NUMERIC,
	billed_amount NUMERIC,
	cost_amount NUMERIC
);

SELECT *
FROM time_entries;