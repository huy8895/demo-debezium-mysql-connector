# tạo bảng mapping
CREATE TABLE customer_address_mapping AS
SELECT concat(c.id,a.id,'_') AS customer_id_address_id,
       first_name,
       last_name,
       email,
       street,
       city,
       state,
       zip,
       type
FROM customers c
         LEFT JOIN addresses a ON c.id = a.customer_id;

# tao primary key
alter table customer_address_mapping
    add constraint customer_address_mapping_pk
        primary key (customer_id_address_id);


SELECT *
FROM customer_address_mapping;

DELIMITER //
CREATE TRIGGER after_customer_update
    AFTER UPDATE ON customers
    FOR EACH ROW
BEGIN
    INSERT INTO customer_address_mapping SELECT concat(c.id,a.id,'_') AS customer_id_address_id,
                                                first_name,
                                                last_name,
                                                email,
                                                street,
                                                city,
                                                state,
                                                zip,
                                                type FROM customers c INNER JOIN addresses a ON c.id = a.customer_id
    WHERE c.id = NEW.id
    ON DUPLICATE KEY UPDATE
                         customer_address_mapping.first_name = VALUES(first_name),
                         customer_address_mapping.last_name = VALUES(last_name),
                         customer_address_mapping.email = VALUES(email);
END;//
DELIMITER ;



DELIMITER //
CREATE TRIGGER after_address_update
    AFTER UPDATE ON addresses
    FOR EACH ROW
BEGIN
    INSERT INTO customer_address_mapping SELECT concat(c.id,a.id,'_') AS customer_id_address_id,
                                                first_name,
                                                last_name,
                                                email,
                                                a.id AS address_id,
                                                street,
                                                city,
                                                state,
                                                zip,
                                                type FROM customers c INNER JOIN addresses a ON c.id = a.customer_id
    WHERE a.customer_id = NEW.customer_id
    ON DUPLICATE KEY UPDATE
                         customer_address_mapping.address_id = VALUES(address_id),
                         customer_address_mapping.customer_id = VALUES(customer_id),
                         customer_address_mapping.street = VALUES(street),
                         customer_address_mapping.city = VALUES(city),
                         customer_address_mapping.state = VALUES(state),
                         customer_address_mapping.zip = VALUES(zip),
                         customer_address_mapping.type = VALUES(type);
END;//
DELIMITER ;

DELIMITER //
CREATE TRIGGER after_customer_insert
    AFTER INSERT ON customers
    FOR EACH ROW
BEGIN
    INSERT INTO customer_address_mapping SELECT c.id as customer_id,
                                                first_name,
                                                last_name,
                                                email,
                                                a.id AS address_id,
                                                street,
                                                city,
                                                state,
                                                zip,
                                                type FROM customers c INNER JOIN addresses a ON c.id = a.customer_id
    WHERE c.id = NEW.id
    ON DUPLICATE KEY UPDATE
                         customer_address_mapping.customer_id = VALUES(customer_id),
                         customer_address_mapping.first_name = VALUES(first_name),
                         customer_address_mapping.last_name = VALUES(last_name),
                         customer_address_mapping.email = VALUES(email);
END;//
DELIMITER ;



DELIMITER //
CREATE TRIGGER after_address_insert
    AFTER INSERT ON addresses
    FOR EACH ROW
BEGIN
    INSERT INTO customer_address_mapping SELECT c.id as customer_id,
                                                first_name,
                                                last_name,
                                                email,
                                                a.id AS address_id,
                                                street,
                                                city,
                                                state,
                                                zip,
                                                type FROM customers c INNER JOIN addresses a ON c.id = a.customer_id
    WHERE a.customer_id = NEW.customer_id
    ON DUPLICATE KEY UPDATE
                         customer_address_mapping.address_id = VALUES(address_id),
                         customer_address_mapping.customer_id = VALUES(customer_id),
                         customer_address_mapping.street = VALUES(street),
                         customer_address_mapping.city = VALUES(city),
                         customer_address_mapping.state = VALUES(state),
                         customer_address_mapping.zip = VALUES(zip),
                         customer_address_mapping.type = VALUES(type);
END;//
DELIMITER ;

# show TRIGGERS ;
#
# drop TRIGGER after_address_update;
# drop TRIGGER after_customer_update;

INSERT INTO inventory.customers (id, first_name, last_name, email) VALUES (1005, 'huy', 'Trịnh Văn', 'huy8895@test.com');
INSERT INTO inventory.addresses (id, customer_id, street, city, state, zip, type) VALUES (17, 1005, 'Nhà Số 5 Ngõ 165/30/16 Dương Quảng Hàm
Hà Nội
Việt Nam', 'hà nội', 'hà nội', '100000', 'LIVING');
