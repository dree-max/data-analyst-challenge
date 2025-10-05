# Data-analyst-challenge

## SQL Test Prompt – First Call Resolution

You are given a schema with these simplified tables:

- customer (customer_id PK, ...)

- operator (operator_id PK, ...)

- call (call_id PK, customer_id FK, operator_id FK, created_at TIMESTAMP, direction TEXT)

## Definition:

We say a call has achieved first call resolution (FCR) if the same customer does not place another call within 7 days after that call.
If the customer makes another call within 7 days, then the issue is considered unresolved.
