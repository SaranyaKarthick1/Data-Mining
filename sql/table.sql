-- =========================
-- DIMENSION TABLES
-- =========================

CREATE TABLE IF NOT EXISTS dim_category (
    category_key SERIAL PRIMARY KEY,
    category_id INT UNIQUE,
    category_name TEXT
);

INSERT INTO dim_category (category_id, category_name)
VALUES (-1, 'UNKNOWN')
ON CONFLICT DO NOTHING;

CREATE TABLE IF NOT EXISTS dim_user (
    user_key SERIAL PRIMARY KEY,
    user_id TEXT UNIQUE,
    user_name TEXT
);

INSERT INTO dim_user (user_id, user_name)
VALUES ('UNKNOWN', 'UNKNOWN')
ON CONFLICT DO NOTHING;

CREATE TABLE IF NOT EXISTS dim_product (
    product_key SERIAL PRIMARY KEY,
    product_id TEXT UNIQUE,
    product_name TEXT,
    category_key INT REFERENCES dim_category(category_key)
);

CREATE TABLE IF NOT EXISTS dim_date (
    date_key DATE PRIMARY KEY,
    year INT,
    month INT,
    day INT
);

-- =========================
-- FACT TABLE
-- =========================

CREATE TABLE IF NOT EXISTS fact_product_review (
    review_key SERIAL PRIMARY KEY,
    product_key INT REFERENCES dim_product(product_key),
    user_key INT REFERENCES dim_user(user_key),
    date_key DATE REFERENCES dim_date(date_key),
    review_id TEXT,
    rating NUMERIC,
    rating_count INT,
    discounted_price NUMERIC,
    actual_price NUMERIC,
    discount_amount NUMERIC,
    load_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
