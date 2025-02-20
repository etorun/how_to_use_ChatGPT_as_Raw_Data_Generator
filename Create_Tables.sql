CREATE TABLE saas.customers (
    customer_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    company_name  TEXT NOT NULL,
    industry TEXT NOT NULL,
    country TEXT NOT NULL,
    signup_date TIMESTAMP,
	plan_type TEXT NOT NULL
);


CREATE TABLE saas.subscriptions (
    subscription_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    customer_id UUID NOT NULL,
    start_date TIMESTAMP NOT NULL,
    end_date TIMESTAMP, 
    billing_cycle TEXT NOT NULL,
    amount_paid DECIMAL(10,2) NOT NULL,
    payment_status TEXT NOT NULL CHECK (payment_status IN ('Paid', 'Failed', 'Pending')),
    FOREIGN KEY (customer_id) REFERENCES saas.customers(customer_id) ON DELETE CASCADE
);


CREATE TABLE saas.usage_logs (
    usage_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    customer_id UUID NOT NULL,
    feature_name TEXT, 
    usage_timestamp TIMESTAMP NOT NULL,
    duration_seconds INTEGER NOT NULL, 
    actions_performed INTEGER NOT NULL, 
    FOREIGN KEY (customer_id) REFERENCES saas.customers(customer_id) ON DELETE CASCADE
);

CREATE TABLE saas.support_tickets (
    ticket_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    customer_id UUID NOT NULL,
    ticket_open_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ticket_close_date TIMESTAMP,
    issue_type TEXT NOT NULL,
    ticket_status TEXT NOT NULL CHECK (ticket_status IN ('Open', 'In Progress', 'Closed')),
    cs_agent_id UUID NOT NULL,    
    FOREIGN KEY (customer_id) REFERENCES saas.customers(customer_id) ON DELETE CASCADE
);