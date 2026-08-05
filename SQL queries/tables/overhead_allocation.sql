CREATE TABLE overhead_allocation(
	client_id VARCHAR(250),
	fiscal_quarter VARCHAR(250),
	allocated_overhead NUMERIC
);

SELECT *
FROM overhead_allocation;