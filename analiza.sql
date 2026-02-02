DROP VIEW IF EXISTS v_abc_analysis;
DROP VIEW IF EXISTS v_current_inventory;

CREATE VIEW v_current_inventory AS
SELECT 
    p.product_id,
    p.product_name,
    p.category,
    p.unit_price,
    p.safety_stock,
    SUM(m.quantity) as current_stock,
    (SUM(m.quantity) * p.unit_price) as inventory_value
FROM products p
JOIN movements m ON p.product_id = m.product_id
GROUP BY p.product_id, p.product_name, p.category, p.unit_price, p.safety_stock; -- <--- I TUTAJ TEŻ!

CREATE VIEW v_abc_analysis AS
WITH calculated_data AS (
    SELECT 
        product_id,
        product_name,
        category,
        current_stock,
        safety_stock, 
        inventory_value,
        SUM(inventory_value) OVER (ORDER BY inventory_value DESC) as running_total,
        SUM(inventory_value) OVER () as total_warehouse_value
    FROM v_current_inventory
    WHERE current_stock > 0
)
SELECT 
    product_id,
    product_name,
    category,
    current_stock,
    safety_stock,
    inventory_value,
    ROUND((running_total / total_warehouse_value) * 100, 2) as cumulative_pct,
    CASE 
        WHEN (running_total / total_warehouse_value) <= 0.80 THEN 'A'
        WHEN (running_total / total_warehouse_value) <= 0.95 THEN 'B'
        ELSE 'C'
    END as abc_class
FROM calculated_data;