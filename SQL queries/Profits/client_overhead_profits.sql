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
),
client_overhead AS (
	SELECT client_id,
		SUM(allocated_overhead) AS total_overhead
	FROM overhead_allocation
	GROUP BY client_id
)
SELECT em.client_id,
	COUNT(em.engagement_id) As total_engagements,
	SUM(em.negotiated_fee) AS total_revenue,
	SUM(em.total_cost) AS total_cost,
	SUM(em.gross_margin) AS gross_margin,
	ROUND(SUM(em.gross_margin)/SUM(em.negotiated_fee)*100,2) AS "gross_margin_%",
	(SUM(em.gross_margin)-MAX(co.total_overhead)) AS net_margin,
	ROUND((SUM(em.gross_margin)-MAX(co.total_overhead))/SUM(em.negotiated_fee)*100,2) AS "net_margin_%"
FROM engagement_margin em
LEFT JOIN client_overhead co
ON em.client_id=co.client_id
GROUP BY em.client_id
ORDER BY "net_margin_%" DESC;
