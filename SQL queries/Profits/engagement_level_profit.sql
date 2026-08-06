WITH engagement_totals AS (
	SELECT engagement_id,
		SUM(cost_amount) AS total_cost,
		SUM(billed_amount) AS total_billed
	FROM time_entries
	GROUP BY engagement_id
)
SELECT e.client_id,
	e.engagement_id,
	e.negotiated_fee,
	t.total_cost,
	t.total_billed,
	(e.negotiated_fee-t.total_cost) AS gross_margin,
	ROUND(((e.negotiated_fee-t.total_cost)/e.negotiated_fee)*100,2) AS "gross_margin%"
FROM engagements e
LEFT JOIN engagement_totals t 
ON e.engagement_id=t.engagement_id
WHERE t.total_cost IS NOT NULL;



















