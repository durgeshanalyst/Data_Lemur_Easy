WITH prime AS (
    SELECT
        FLOOR(500000 / SUM(square_footage)) AS prime_item_count, 
        500000 - (SUM(square_footage) * FLOOR(500000 / SUM(square_footage))) AS space_left
    FROM
        inventory
    WHERE
        item_type LIKE 'prime_eligible'
)
SELECT
    'prime_eligible' AS item_type,
    (SELECT prime_item_count FROM prime) * COUNT(DISTINCT item_id) AS total_items
FROM
    inventory
WHERE
    item_type LIKE 'prime_eligible'
UNION ALL
SELECT
    'not_prime' AS item_type,
    FLOOR((SELECT space_left FROM prime) / SUM(square_footage)) * COUNT(DISTINCT item_id) AS total_items
FROM
    inventory
WHERE
    item_type LIKE 'not_prime';
