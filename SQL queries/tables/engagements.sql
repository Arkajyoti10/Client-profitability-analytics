CREATE TABLE engagements(
	engagement_id VARCHAR(250),
	client_id VARCHAR(250),
	engagement_type VARCHAR(250),
	start_date DATE,
	end_date DATE,
	duration_weeks INT,
	negotiated_fee NUMERIC,
	standard_value_at_list_rates NUMERIC,
	team_size INT
);

SELECT *
FROm engagements;