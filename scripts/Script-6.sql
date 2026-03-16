-- ============================================
--  CREACIÓN DE TABLAS PRINCIPALES
--  Estas tablas representan las entidades base
--  del sistema: foodtrucks, productos, órdenes,
--  ítems de órdenes y ubicaciones.
-- ============================================

-- Tabla de foodtrucks
create table foodtrucks(
    foodtruck_id INT primary key,
    name varchar(100) not null,
    cuisine_tipe varchar(100) not null,
    city varchar(100) not null
);

-- Tabla de productos ofrecidos por cada foodtruck
create table products (
    product_id int primary key,
    foodtruck_id int not null references foodtrucks(foodtruck_id),
    name varchar(100) not null,
    price numeric(10,2) not null,
    stock int not null
);

-- Tabla de órdenes realizadas a cada foodtruck
create table orders (
    order_id int primary key,
    foodtruck_id int not null references foodtrucks(foodtruck_id),
    order_date date not null,
    status varchar(50) not null,
    total numeric(10,2) not null
);

-- Tabla de ítems dentro de cada orden
create table order_items (
    order_item_id int primary key,
    order_id int not null references orders(order_id),
    product_id int not null references products(product_id),
    quantity int not null
);

-- Tabla de ubicaciones donde opera cada foodtruck
create table locations(
    location_id int primary key,
    foodtruck_id int not null references foodtrucks (foodtruck_id),
    location_date date not null,
    zone varchar(100) not null
);

-- ============================================
--  CONSULTAS DE VERIFICACIÓN DE ESTRUCTURA
--  Se usan para revisar que las tablas estén
--  creadas correctamente y con los tipos esperados.
-- ============================================

SELECT column_name 
FROM information_schema.columns
WHERE table_name = 'foodtrucks';

SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'products';

SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'locations';

-- ============================================
--  INSERCIÓN DE DATOS DE EJEMPLO
--  Carga inicial para probar relaciones y consultas.
-- ============================================

INSERT INTO locations (location_id, foodtruck_id, location_date, zone)
VALUES
    (1, 1, '2024-05-10', 'Centro'),
    (2, 2, '2024-05-11', 'Parque');

-- ============================================
--  CONSULTAS DE PRUEBA
--  Permiten validar que las relaciones entre tablas
--  funcionan correctamente mediante JOINs.
-- ============================================

-- Productos ofrecidos por cada foodtruck
SELECT f.name AS foodtruck, p.name AS producto, p.price
FROM products p
JOIN foodtrucks f ON p.foodtruck_id = f.foodtruck_id;

-- Ítems dentro de cada orden con su producto
SELECT o.order_id, p.name, oi.quantity
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
JOIN products p ON oi.product_id = p.product_id;
