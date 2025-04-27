select * from ecommerce.ecomm;
SELECT product_name, price
FROM ecommerce.ecomm
ORDER BY price DESC
LIMIT 5;
SELECT product_name, review_score
FROM ecommerce.ecomm
WHERE review_score > 4.0
ORDER BY review_score DESC;
SELECT 
    product_id,
    product_name,
    (sales_month_1 + sales_month_2 + sales_month_3 + sales_month_4 + sales_month_5 +
     sales_month_6 + sales_month_7 + sales_month_8 + sales_month_9 + sales_month_10 +
     sales_month_11 + sales_month_12) AS total_sales
FROM ecommerce.ecomm
ORDER BY total_sales DESC;
SELECT 
    category,
    SUM(sales_month_1 + sales_month_2 + sales_month_3 + sales_month_4 + sales_month_5 +
        sales_month_6 + sales_month_7 + sales_month_8 + sales_month_9 + sales_month_10 +
        sales_month_11 + sales_month_12) AS total_category_sales
FROM ecommerce.ecomm
GROUP BY category
ORDER BY total_category_sales DESC;

CREATE TABLE category_master (
    category_name VARCHAR(100) PRIMARY KEY,
    department VARCHAR(100)
);

-- Insert some example data
INSERT INTO category_master VALUES 
('Clothing', 'Apparel'),
('Toys', 'Kids'),
('Books', 'Entertainment'),
('Home & Kitchen', 'Home');

-- Now JOIN:
SELECT 
    es.product_name,
    es.category,
    cm.department
FROM ecommerce.ecomm es
INNER JOIN category_master cm
ON es.category = cm.category_name;

SELECT product_name, price
FROM ecommerce.ecomm
WHERE price > (SELECT AVG(price) FROM ecommerce_sales)
ORDER BY price DESC;
SELECT category
FROM (
    SELECT 
        category,
        SUM(sales_month_1 + sales_month_2 + sales_month_3 + sales_month_4 + sales_month_5 +
            sales_month_6 + sales_month_7 + sales_month_8 + sales_month_9 + sales_month_10 +
            sales_month_11 + sales_month_12) AS total_sales
    FROM ecommerce.ecomm
    GROUP BY category
) AS category_sales
ORDER BY total_sales DESC
LIMIT 1;

SELECT 
    SUM((sales_month_1 + sales_month_2 + sales_month_3 + sales_month_4 + sales_month_5 +
         sales_month_6 + sales_month_7 + sales_month_8 + sales_month_9 + sales_month_10 +
         sales_month_11 + sales_month_12) * price) AS total_revenue
FROM ecommerce.ecomm;
SELECT AVG(review_score) AS avg_review
FROM ecommerce.ecomm;

CREATE VIEW category_sales_view AS
SELECT 
    category,
    SUM(sales_month_1 + sales_month_2 + sales_month_3 + sales_month_4 + sales_month_5 +
        sales_month_6 + sales_month_7 + sales_month_8 + sales_month_9 + sales_month_10 +
        sales_month_11 + sales_month_12) AS total_sales
FROM ecommerce.ecomm
GROUP BY category;
SELECT * FROM category_sales_view
ORDER BY total_sales DESC;


CREATE INDEX idx_category ON ecommerce.ecomm (category);
CREATE INDEX idx_price ON ecommerce.ecomm (price);
CREATE INDEX idx_review_score ON ecommerce.ecomm (review_score);








