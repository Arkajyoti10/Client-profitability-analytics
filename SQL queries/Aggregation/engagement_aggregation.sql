SELECT t.client_id,
	t.engagement_id,
	COUNT(*) AS total_entries,
	SUM(t.hours_logged) AS total_hours,
	SUM(t.cost_amount) AS total_cost,
	SUM(t.billed_amount) AS total_bill_standard
FROM time_entries AS t
GROUP BY t.client_id,t.engagement_id;