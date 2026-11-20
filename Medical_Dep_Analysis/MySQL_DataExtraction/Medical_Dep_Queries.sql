-- =======================================================INVENTORY TABLE========================================================================
-- ADD FK to inventory

ALTER TABLE inventory
ADD CONSTRAINT fk_inventory_one
FOREIGN KEY (supplier_id)
REFERENCES suppliers(supplier_id),

ADD CONSTRAINT fk_inventory_two
FOREIGN KEY (medicine_id)
REFERENCES medicine(medicine_id);

-- ADD PK to inventoy

ALTER TABLE inventory
ADD CONSTRAINT pk_inventory
PRIMARY KEY (medicine_id, supplier_id);

-- Change Data Type from text -> date inventory (expiry_date)

ALTER TABLE inventory
MODIFY expiry_date date;

-- =======================================================MEDICINES TABLE========================================================================
-- ADD PK to medicines

ALTER TABLE medicines
ADD CONSTRAINT PRIMARY KEY (medicine_id);

-- =======================================================PURCHASE ORDERS TABLE==================================================================
-- ADD PK to purchase_orders

ALTER TABLE purchase_orders
ADD CONSTRAINT PRIMARY KEY (order_id);

-- ADD FK to purchase_orders

ALTER TABLE purchase_orders
ADD CONSTRAINT fk_order_one
FOREIGN KEY (supplier_id)
REFERENCES suppliers(supplier_id),

ADD CONSTRAINT fk_order_two
FOREIGN KEY (medicine_id)
REFERENCES medicine(medicine_id);

-- Purchase_orders_date_fix

ALTER TABLE purchase_orders
ADD COLUMN new_delivery_date_col DATE;

UPDATE purchase_orders
SET new_delivery_date_col = str_to_date(delivery_date, '%Y-%m-%d')
WHERE delivery_date IS NOT NULL AND delivery_date != "";

ALTER TABLE purchase_orders 
DROP COLUMN delivery_date;

ALTER TABLE purchase_orders
RENAME COLUMN new_delivery_date_col TO delivery_date;

-- =======================================================STOCK MOVEMENTS TABLE==================================================================
-- ADD PK to stock_movements

ALTER TABLE stock_movements
ADD CONSTRAINT PRIMARY KEY (movement_id);

-- ADD FK to stock_movements

ALTER TABLE stock_movements
ADD CONSTRAINT fk_movement_one
FOREIGN KEY (supplier_id)
REFERENCES suppliers(supplier_id),

ADD CONSTRAINT fk_movement_two
FOREIGN KEY (medicine_id)
REFERENCES medicine(medicine_id);

-- Change the data type from text -> date stock_movements(movement_date)

ALTER TABLE stock_movements
MODIFY movement_date date;

-- =======================================================SUPPLIERS TABLE========================================================================
-- ADD PK to suppliers

ALTER TABLE suppliers
ADD CONSTRAINT PRIMARY KEY (supplier_id);


-- ========================================================Export Data==========================================================================
-- 1st Data
SELECT m.medicine_name, m.category, i.quantity as 'Inventory Quatity', i.reorder_level, i.expiry_date, p.order_date, p.quantity_ordered, p.order_status, p.delivery_date, sm.movement_date, sm.movement_type, sm.quantity as "Stock Movement Quantity", s.supplier_name
FROM inventory i
JOIN medicines m 
ON i.medicine_id = m.medicine_id
JOIN purchase_orders p
ON m.medicine_id = p.medicine_id
JOIN suppliers s
ON p.supplier_id = s.supplier_id
JOIN stock_movements sm
ON s.supplier_id = sm.supplier_id
ORDER BY m.medicine_name;

-- 2nd Data
SELECT DISTINCT m.medicine_name, m.category, i.quantity as 'Inventory Quatity', i.reorder_level, i.expiry_date, p.order_date, p.quantity_ordered, p.order_status, p.delivery_date, s.supplier_name
FROM inventory i
JOIN medicines m 
ON i.medicine_id = m.medicine_id
JOIN purchase_orders p
ON m.medicine_id = p.medicine_id
JOIN suppliers s
ON p.supplier_id = s.supplier_id
ORDER BY m.medicine_name;

-- 3rd Data
SELECT sm.movement_id, m.medicine_name, m.category, sm.movement_date, sm.movement_type, sm.quantity as "stock_movement_quantity", sm.reference
FROM inventory i
JOIN medicines m 
ON i.medicine_id = m.medicine_id
JOIN purchase_orders p
ON m.medicine_id = p.medicine_id
JOIN suppliers s
ON p.supplier_id = s.supplier_id
JOIN stock_movements sm
ON s.supplier_id = sm.supplier_id
ORDER BY m.medicine_name;