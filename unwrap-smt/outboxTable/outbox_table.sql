CREATE TABLE outbox (
                        id CHAR(36) NOT NULL,
                        aggregatetype VARCHAR(255) NOT NULL,
                        aggregateid VARCHAR(255) NOT NULL,
                        type VARCHAR(255) NOT NULL,
                        payload JSON NOT NULL,
                        PRIMARY KEY (id)
);

INSERT INTO outbox (id, aggregatetype, aggregateid, type, payload) VALUES
                                                                       ('550e8400-e29b-41d4-a716-446655440000', 'Order', '12345', 'OrderCreated', '{"orderId": "12345", "amount": 100.0, "currency": "USD"}'),
                                                                       ('550e8400-e29b-41d4-a716-446655440001', 'Order', '12346', 'OrderCreated', '{"orderId": "12346", "amount": 150.0, "currency": "USD"}'),
                                                                       ('550e8400-e29b-41d4-a716-446655440002', 'Order', '12347', 'OrderUpdated', '{"orderId": "12347", "status": "Shipped"}'),
                                                                       ('550e8400-e29b-41d4-a716-446655440003', 'Customer', 'cust123', 'CustomerCreated', '{"customerId": "cust123", "name": "John Doe"}'),
                                                                       ('550e8400-e29b-41d4-a716-446655440004', 'Customer', 'cust124', 'CustomerCreated', '{"customerId": "cust124", "name": "Jane Smith"}'),
                                                                       ('550e8400-e29b-41d4-a716-446655440005', 'Product', 'prod567', 'ProductAdded', '{"productId": "prod567", "name": "Laptop", "price": 1200.0}'),
                                                                       ('550e8400-e29b-41d4-a716-446655440006', 'Product', 'prod568', 'ProductAdded', '{"productId": "prod568", "name": "Smartphone", "price": 800.0}'),
                                                                       ('550e8400-e29b-41d4-a716-446655440007', 'Order', '12348', 'OrderCreated', '{"orderId": "12348", "amount": 200.0, "currency": "USD"}'),
                                                                       ('550e8400-e29b-41d4-a716-446655440008', 'Order', '12349', 'OrderCancelled', '{"orderId": "12349", "reason": "Out of stock"}'),
                                                                       ('550e8400-e29b-41d4-a716-446655440009', 'Customer', 'cust125', 'CustomerUpdated', '{"customerId": "cust125", "email": "cust125@example.com"}');


create DATABASE db_sink;