CREATE VIEW saas.customer_growth_retention AS
SELECT 
    c.customer_id,
    c.company_name,
    c.industry,
    c.country,
    c.signup_date,
    c.plan_type,
    s.subscription_id,
    s.start_date,
    s.end_date,
    CASE 
        WHEN s.end_date IS NULL THEN 'Active'
        WHEN s.end_date > CURRENT_DATE THEN 'Active'
        ELSE 'Churned'
    END AS customer_status
FROM saas.customers c
LEFT JOIN saas.subscriptions s 
    ON c.customer_id = s.customer_id;