CREATE VIEW saas.support_ticket_analysis AS
SELECT 
    t.ticket_id,
    t.customer_id,
    c.company_name,
    c.country,
    t.issue_type,
    t.ticket_open_date,
    t.ticket_close_date,
    t.ticket_status,
    t.cs_agent_id,
    s.payment_status,
    EXTRACT(EPOCH FROM (t.ticket_close_date - t.ticket_open_date))/3600 AS resolution_time_hours
FROM saas.support_tickets t
LEFT JOIN saas.customers c 
    ON t.customer_id = c.customer_id
LEFT JOIN saas.subscriptions s  
    ON t.customer_id = s.customer_id;