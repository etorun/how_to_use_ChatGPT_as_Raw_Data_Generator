CREATE VIEW saas.revenue_subscription_performance AS
SELECT 
    s.subscription_id,
    s.customer_id,
    c.company_name,
    c.country,
    c.plan_type,
    s.start_date,
    s.end_date,
    s.amount_paid,
    s.payment_status,
    DATE_TRUNC('month', s.start_date) AS revenue_month,
    COALESCE(s.amount_paid, 0) AS mrr, -- Monthly Recurring Revenue
    CASE 
        WHEN s.end_date IS NULL THEN 'Active'
        WHEN s.end_date > CURRENT_DATE THEN 'Active'
        ELSE 'Canceled'
    END AS subscription_status
FROM saas.subscriptions s
LEFT JOIN saas.customers c 
    ON s.customer_id = c.customer_id;
