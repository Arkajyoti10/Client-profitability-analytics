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
	SUM(total_billed) AS total_billed,
	SUM(negotiated_fee) AS total_revenue,
	ROUND((SUM(negotiated_fee)/SUM(total_billed))*100,2) AS realization_rate
FROM engagement_margin em
GROUP BY client_id
ORDER BY realization_rate DESC;