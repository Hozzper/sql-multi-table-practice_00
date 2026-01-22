-- Criação das tabelas do banco de dados do restaurante
CREATE TABLE R1_Ordes AS 
SELECT * FROM "restaurant_dataset/restaurant-1-orders.csv";

CREATE TABLE R1_Products_Price AS 
SELECT * FROM "restaurant_dataset/restaurant-1-products-price.csv";

--Aliases
SELECT * FROM (
  SELECT 
    "Order Number", "Total products", SUM(Quantity) AS Total
  FROM R1_Ordes 
  GROUP BY 
    "Order Number", "Total products"
  )
WHERE Total != "Total products";

SELECT "Order Number", "Total products", SUM(Quantity)
FROM R1_Ordes
GROUP BY "Order Number", "Total products"
ORDER BY "Order Number", "Total products";

--A tabela tem um error, não bate a quantidade das orders com Total products, assim
-- que o certo e fazer um update da tabela.
UPDATE R1_Ordes r1
SET "Total products" = tp.total_products_calculado
FROM (
  SELECT 
    "Order Number", SUM(Quantity) AS total_products_calculado
  FROM R1_Ordes
  GROUP BY
    "Order Number"
  ) tp
WHERE r1."Order Number" = tp."Order Number";

ALTER TABLE R1_Ordes
DROP COLUMN "Product Price";

SELECT * FROM R1_Ordes;
SELECT * FROM R1_Products_Price;

-- Quero fazer uma relação nas tabulas e trazer o product price para as orders
-- Para fazer essa relação, parece que e preciso usar JOINS

-- JOIN CLAUSE
-- Nosso dataset, temos em R1_Orders e R1_Products_Price a columna Item Name que 
-- são iguais. 

SELECT 
  o."Order Number", o."Order Date", o."Item NAme", pp."Product Price"
FROM R1_Ordes o
INNER JOIN R1_Products_Price pp
  ON o."Item Name" = pp."Item Name";

