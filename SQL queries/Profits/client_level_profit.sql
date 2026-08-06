WITH engagement_margin AS (
	SELECT e.client_id,
		e.engagement_id,
		e.negotiated_fee,
		SUM(cost_amount) AS total_cost,
		SUM(billed_amount) AS total_billed,
		(e.negotiated_fee - SUM(t.cost_amount)) AS gross_margin
	FROM engagements e
	LEFT JOIN time_entries t 
	ON e.engagement_id=t.engagement_id
	GROUP BY e.client_id,e.engagement_id,e.negotiated_fee
)
SELECT client_id,
	COUNT(engagement_id) As total_engagements,
	SUM(negotiated_fee) AS total_revenue,
	SUM(total_cost) AS total_cost,
	SUM(gross_margin) AS gross_margin,
	ROUND(SUM(gross_margin)/SUM(negotiated_fee)*100,2) AS "gross_margin_%"
FROM engagement_margin
GROUP BY client_id
ORDER BY "gross_margin_%" DESC;



















