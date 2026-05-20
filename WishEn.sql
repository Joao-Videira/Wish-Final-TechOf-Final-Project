/*******************************************************************************
   WISH E-COMMERCE Final Project
*******************************************************************************/

-- =============================================================================
-- 1. DATA QUALITY AUDITING & EXPLORATORY PROFILING
-- =============================================================================

-- 1.1. Detailed validation of specific merchant data profiles
SELECT *
FROM summer_products
WHERE merchant_title = 'wushein';

-- 1.2. Analyzing product tag density based on string character offsets
SELECT 
    tags,
    units_sold,
    LEN(tags) - LEN(REPLACE(tags, ',', '')) AS total_commas
FROM Summer_Products;

-- 1.3. Auditing active urgency conversion banners
SELECT *
FROM Summer_Products
WHERE has_urgency_banner = 1;

-- 1.4. Validating seasonal theme consistency (checking for non-summer items)
SELECT *
FROM Summer_Products
WHERE theme != 'summer';

-- 1.5. Isolating products with an absolute absence of customer ratings
SELECT *
FROM Summer_Products
WHERE rating_count = 0;

-- 1.6. Auditing express logistics infrastructure fulfillment
SELECT *
FROM Summer_Products
WHERE shipping_is_express = 1;

-- 1.7. Examining cross-border supply chains originating outside standard hubs (China)
SELECT *
FROM Summer_Products
WHERE origin_country != 'CN';

-- 1.8. Checking for inventory levels that deviate from the standard baseline
SELECT *
FROM Summer_Products
WHERE inventory_total != 50;

-- 1.9. Identifying regional domestic localization badges
SELECT *
FROM Summer_Products
WHERE badge_local_product = 1;

-- 1.10. Mapping specific merchants managing non-standard inventory volumes
SELECT
    merchant_title,
    inventory_total
FROM Summer_Products
WHERE inventory_total != 50;


-- =============================================================================
-- 2. DATA CLEANSING & SCHEMA OPTIMIZATION (ETL)
-- =============================================================================

-- Dropping redundant, high-null, or uninformative variables to clean the schema
ALTER TABLE summer_products DROP COLUMN title;                        -- Duplicated by title_orig
ALTER TABLE summer_products DROP COLUMN merchant_profile_picture;     -- High concentration of NULL values
ALTER TABLE summer_products DROP COLUMN merchant_has_profile_picture; -- Irrelevant for performance analysis
ALTER TABLE summer_products DROP COLUMN crawl_month;                  -- Redundant (all records from August)
ALTER TABLE summer_products DROP COLUMN merchant_name;                 -- Duplicated by merchant_title
ALTER TABLE summer_products DROP COLUMN theme;                         -- Redundant (all records are summer themed)
ALTER TABLE summer_products DROP COLUMN product_url;                   -- Non-informative hypermedia string
ALTER TABLE summer_products DROP COLUMN product_picture;               -- Non-informative hypermedia string


-- =============================================================================
-- 3. ADVANCED FEATURE ENGINEERING
-- =============================================================================

-- 3.1. Generating a quantitative column to evaluate total tag density per product
ALTER TABLE summer_products
ADD total_tags INT;

UPDATE summer_products
SET total_tags = LEN(tags) - LEN(REPLACE(tags, ',', '')) + 1;


-- 3.2. Creating a declarative computed column for discount segment categorization
ALTER TABLE Summer_Products
DROP COLUMN categoria_desconto; -- Dropping old reference if exists

ALTER TABLE Summer_Products
ADD categoria_desconto AS (
    CASE 
        WHEN price > retail_price THEN 'Priced Above Market'
        WHEN (retail_price - price) / retail_price * 100 < 10 THEN 'Under 10% Markdown'
        WHEN (retail_price - price) / retail_price * 100 < 30 THEN '10-30% Markdown'
        WHEN (retail_price - price) / retail_price * 100 < 60 THEN '30-60% Markdown'
        ELSE 'Over 60% Clearance'
    END
);


-- =============================================================================
-- 4. RELATIONAL VIEW MODELING & TEXT TOKENIZATION
-- =============================================================================

-- Normalizing multi-valued tag strings into explicit atomic records using a CTE
CREATE OR ALTER VIEW vw_tags_merchant AS
WITH separated_tags AS (
    SELECT   
        units_sold,
        price, 
        merchant_title,     
        tags,     
        TRIM(value) AS tag 
    FROM summer_products 
    CROSS APPLY STRING_SPLIT(tags, ',') 
    WHERE TRIM(value) NOT LIKE 'T' -- Purging system anomalies
)
SELECT 
    merchant_title,
    tag,
    COUNT(*) AS tag_frequency,
    SUM(units_sold) AS total_units_sold,
    SUM(units_sold * price) AS total_revenue_generated
FROM separated_tags
GROUP BY merchant_title, tag
HAVING COUNT(*) >= 2; -- Filtering for recurring keyword patterns


-- =============================================================================
-- 5. BUSINESS INTELLIGENCE & EXPLORATORY QUERIES
-- =============================================================================

-- 5.1. Extracting global pricing boundaries (Average, Minimum, and Maximum)
SELECT 
    AVG(price) AS average_price,
    MIN(price) AS minimum_price,
    MAX(price) AS maximum_price
FROM summer_products;

-- 5.2. Isolating maximum price boundary
SELECT MAX(price) AS max_price FROM summer_products;

-- 5.3. Top 10 products by sales velocity (sorted ascending to track bottom-performing tail)
SELECT TOP 10
    product_id,
    title_orig,
    price,
    units_sold,
    rating
FROM summer_products
ORDER BY units_sold ASC;

-- 5.4. Top 10 products by customer score (with a strict minimum visibility threshold)
SELECT TOP 10
    title_orig,
    rating,
    rating_count,
    units_sold
FROM summer_products
WHERE rating_count >= 50 -- Ensures statistical relevance
ORDER BY rating DESC;

-- 5.5. A/B Analysis: Assessing the impact of paid visibility (Ad Boosts) on performance
SELECT 
    uses_ad_boosts,
    COUNT(*) AS total_products,
    AVG(units_sold) AS average_sales_velocity,
    AVG(rating) AS average_customer_rating
FROM summer_products
GROUP BY uses_ad_boosts;

-- 5.6. Top 10 volume-driving merchants by aggregated sales
SELECT TOP 10
    merchant_title,
    COUNT(*) AS product_variety,
    SUM(units_sold) AS total_units_sold,
    AVG(merchant_rating) AS average_merchant_rating
FROM summer_products
GROUP BY merchant_title
ORDER BY total_units_sold DESC;

-- 5.7. Mapping merchant portfolio scale against sales averages
SELECT
    merchant_title,
    COUNT(*) AS total_listed_products,
    SUM(units_sold) AS aggregated_sales_volume,
    AVG(units_sold) AS average_sales_per_item
FROM summer_products
GROUP BY merchant_title
ORDER BY total_listed_products DESC;