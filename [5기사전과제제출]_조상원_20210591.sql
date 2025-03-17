/*해당 데이터셋의 전체 기간 확인*/
SELECT max(order_date), min(order_date)
FROM DArt_B db;

/*각각의 customer_segment의 수*/
SELECT customer_segment, count(*)
FROM DArt_B db 
GROUP BY customer_segment;

/*전체 oreder_region명 및 개수 확인*/
SELECT oreder_region
FROM DArt_B db 
UNION
SELECT oreder_region
FROM DArt_B db

/*각각의 customer_segment의 가장 count가 높은 상위 3개의 order_region*/
WITH OrderedCounts AS (
    SELECT 
        customer_segment,
        oreder_region,
        COUNT(*) AS count,
        ROW_NUMBER() OVER (PARTITION BY customer_segment ORDER BY COUNT(*) DESC) as rn
    FROM 
        DArt_B
    GROUP BY 
        customer_segment, oreder_region
)
SELECT 
    customer_segment,
    oreder_region,
    count
FROM 
    OrderedCounts
WHERE 
    rn <= 3;

/*각각의 customer_segment의 가장 count가 높은 상위 3개의 category*/
WITH OrderedCounts AS (
    SELECT 
        customer_segment,
        category,
        COUNT(*) AS count,
        ROW_NUMBER() OVER (PARTITION BY customer_segment ORDER BY COUNT(*) DESC) as rn
    FROM 
        DArt_B
    GROUP BY 
        customer_segment, category
)
SELECT 
    customer_segment,
    category,
    count
FROM 
    OrderedCounts
WHERE 
    rn <= 3;

/*각각의 customer_segment의 quantity의 합과 평균*/
SELECT customer_segment, SUM(quantity), AVG(quantity)
FROM DArt_B db 
GROUP BY customer_segment;

/*각각의 customer_segment의 sales의 합과 평균*/
SELECT customer_segment, SUM(sales), AVG(sales)
FROM DArt_B db 
GROUP BY customer_segment;

/*각각의 customer_segment의 profit의 합과 평균*/
SELECT customer_segment, SUM(profit), AVG(profit)
FROM DArt_B db 
GROUP BY customer_segment;

/*각각의 customer_segment의 discount의 합과 평균*/
SELECT customer_segment, SUM(discount), AVG(discount)
FROM DArt_B db 
GROUP BY customer_segment;


