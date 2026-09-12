USE PortfolioProject_MarketingAnalytics;

SELECT * FROM products;

-- ****************************************************************************** --

-- Categorize products based on their price --

SELECT 
	ProductID,
	ProductName,
	Category,
	PRICE,

CASE
	WHEN Price < 50 THEN 'Low'
	WHEN Price BETWEEN 50 AND 200 THEN 'Medium'
	ELSE 'High'
END AS PriceCategory
FROM products;

-- ****************************************************************************** --

SELECT * FROM customers;

SELECT * FROM geography;

-- ****************************************************************************** --

-- Joining customers and geography table to enrich customer data with geographic information --

SELECT
	c.CustomerID,
	c.CustomerName,
	c.Email, 
	c.Gender,
	c.Age,
	g.Country,
	g.City

FROM
	customers as c

LEFT JOIN
	geography g
ON
	c.GeographyID = g.GeographyID;

-- ************************************************************** --

SELECT * FROM customer_reviews;

-- ************************************************************** --

-- Cleaning white spaces from the ReveiwText column

SELECT
	ReviewID,
	CustomerID,
	ProductID,
	ReviewDate,
	Rating,
	REPLACE(ReviewText, '  ', ' ') AS ReviewText
FROM
	customer_reviews;

-- ************************************************************** --

SELECT * FROM engagement_data;

-- ************************************************************* --

SELECT
	EngagementID,
	ContentID,
	CampaignID,
	ProductID,
	UPPER(REPLACE(ContentType, 'Socialmedia', 'Social Media')) AS ContentType,
	LEFT(ViewsClicksCombined, CHARINDEX('-', ViewsClicksCombined) -1) AS Views,
	RIGHT(ViewsClicksCombined, LEN(ViewsClicksCombined) - CHARINDEX('-', ViewsClicksCombined)) AS Clicks,
	Likes,
	FORMAT(CONVERT(DATE, EngagementDate), 'dd.MM.yyyy') AS EngagementDate
FROM
	engagement_data
WHERE
	ContentType != 'Newsletter';

-- ************************************************** --

SELECT * FROM customer_journey;

-- ************************************************** --

-- Common Table Expression (CTE) to identify and tag duplicate records --

WITH DuplicateRecords AS (
	SELECT
		JourneyID,
		CustomerID,
		ProductID,
		VisitDate,
		Stage,
		Action,
		Duration,
		ROW_NUMBER() OVER(
			PARTITION BY CustomerID, ProductID, VisitDate, Action
			ORDER BY JourneyID
		) AS row_num
	FROM customer_journey
)

SELECT * 
FROM DuplicateRecords
WHERE row_num > 1
ORDER BY JourneyID

-- Removing the duplicates and null values from the table --

SELECT
	JourneyID,
	CustomerID,
	ProductID,
	VisitDate,
	Stage,
	Action,
	COALESCE (Duration, avg_duration) AS Duration
FROM
	(
		SELECT
			JourneyID,
			CustomerID,
			ProductID,
			VisitDate,
			UPPER(Stage) AS Stage,
			Action,
			Duration,
			AVG(Duration) OVER (PARTITION BY VisitDate) AS avg_duration,
			ROW_NUMBER() OVER (
				PARTITION BY CustomerID, ProductID, VisitDate, UPPER(Stage), Action 
				ORDER BY JourneyID
			) AS row_num
		FROM 
			customer_journey
		) AS subquery
WHERE
	row_num = 1;

-- Basic Business Analysis --

-- Q1. What is the total number of customers? -- 

SELECT
	COUNT(DISTINCT CustomerID) AS Total_Customers
FROM customers; 

-- Q2. How are customers distributed by gender? -- 

SELECT
	Gender,
	COUNT(DISTINCT CustomerID) AS CustomerCount
FROM customers
GROUP BY Gender
ORDER BY CustomerCount DESC;

-- Q3. How are customers distributed across countries? -- 

SELECT
	g.Country,
	COUNT(DISTINCT c.CustomerID) AS CustomerCount
FROM customers c
LEFT JOIN geography g
ON c.GeographyID = g.GeographyID
GROUP BY g.Country
ORDER BY CustomerCount DESC; 
	
-- Q4. Which cities have the highest number of customers? --

SELECT
	g.City,
	COUNT(DISTINCT c.CustomerID) AS CustomerCount
FROM customers c
LEFT JOIN geography g
ON c.GeographyID = g.GeographyID
GROUP BY g.city
ORDER BY CustomerCount DESC;

-- Q5. What is the distribution of products by category? --

SELECT
	Category,
	COUNT(DISTINCT ProductID) AS ProductCount
FROM products
GROUP BY Category
ORDER BY ProductCount DESC;

-- Note : We only have one product category : Sports -- 

-- How are products distributed across price categories? -- 

SELECT
	CASE
		WHEN Price < 50 THEN 'Low'
        WHEN Price BETWEEN 50 AND 200 THEN 'Medium'
        ELSE 'High'
    END AS PriceCategory,
	COUNT(*) AS ProductCount
FROM products
GROUP BY 
	CASE
		WHEN Price < 50 THEN 'Low'
        WHEN Price BETWEEN 50 AND 200 THEN 'Medium'
        ELSE 'High'
	END
ORDER BY 
	ProductCount DESC;

-- Q7. What is the average customer review rating? -- 

SELECT
	ROUND(AVG(CAST(Rating AS DECIMAL(10,2))),2) AS AverageRating
FROM customer_reviews;

-- Q8. How many reviews have been submitted for each rating? --

SELECT
	Rating,
	COUNT(*) AS ReviewCount
FROM customer_reviews
GROUP BY Rating
ORDER BY ReviewCount DESC;

-- Q9. Which products have received the most customer reviews? --

SELECT
	p.ProductID,
	p.ProductName,
	COUNT(r.ReviewID) AS ReviewCount
FROM products p
INNER JOIN customer_reviews r
ON p.ProductID = r.ProductID
GROUP BY 
	p.ProductID,
	p.ProductName
ORDER BY
	ReviewCount DESC;

-- Intermediate Business Analysis -- 

-- Q10. Which products have the highest average customer ratings? --

SELECT
	p.ProductID,
	p.ProductName,
	ROUND(AVG(CAST(r.Rating AS DECIMAL(10,2))),2) AS AverageRating
FROM customer_reviews r
INNER JOIN products p
ON r.ProductID = p.ProductID
GROUP BY
	p.ProductID,
	p.ProductName
HAVING COUNT (r.Rating) >= 5  -->> Having clause will prevent products with only one or two reviews from dominating the ranking. 
ORDER BY 
	AverageRating DESC;

-- Q11. Which products have the lowest average customer ratings? --

SELECT
	p.ProductID,
	p.ProductName,
	ROUND(AVG(CAST(r.Rating AS DECIMAL(10,2))),2) AS AverageRating
FROM customer_reviews r
INNER JOIN products p
ON r.ProductID = p.ProductID
GROUP BY
	p.ProductID,
	p.ProductName
HAVING COUNT (r.Rating) >= 5  -->> Having clause will prevent products with only one or two reviews from dominating the ranking. 
ORDER BY 
	AverageRating ASC;

-- Q12. Which content types generate the highest number of views? --

SELECT
	UPPER(REPLACE(ContentType, 'Socialmedia', 'Social Media')) AS ContentType,
    SUM(
        TRY_CAST(
            LEFT(ViewsClicksCombined, CHARINDEX('-', ViewsClicksCombined) - 1)
            AS INT
        )
    ) AS TotalViews
FROM engagement_data
WHERE
	ContentType != 'Newsletter'
GROUP BY UPPER(REPLACE(ContentType, 'Socialmedia', 'Social Media'))
ORDER BY TotalViews DESC;

-- Q13. Which content types generate the highest number of clicks? --

SELECT
	UPPER(REPLACE(ContentType, 'Socialmedia', 'Social Media')) AS ContentType,
	SUM(
        TRY_CAST(
            RIGHT(
                ViewsClicksCombined,
                LEN(ViewsClicksCombined) - CHARINDEX('-', ViewsClicksCombined)
            )
            AS INT
        )
    ) AS TotalClicks
FROM engagement_data
WHERE
	ContentType != 'Newsletter'
GROUP BY
	UPPER(REPLACE(ContentType, 'Socialmedia', 'Social Media'))
ORDER BY
	TotalClicks DESC;

-- Q14. Which content types have the highest engagement rate? --

SELECT
	UPPER(REPLACE(ContentType, 'SocialMedia', 'Social Media')) AS ContentType,
	SUM(
		TRY_CAST(
			LEFT(ViewsClicksCombined,
				CHARINDEX('-',ViewsClicksCombined) -1)
				AS INT
			)
		) AS TotalViews,
	SUM(
		TRY_CAST(
		RIGHT(ViewsClicksCombined,
		LEN(ViewsClicksCombined)-CHARINDEX('-',ViewsClicksCombined)
		)
		AS INT
		)
) AS TotalClicks,

SUM(Likes) AS TotalLikes,

ROUND(
	(
	SUM(
		TRY_CAST(
		RIGHT(ViewsClicksCombined,
		LEN(ViewsClicksCombined)-CHARINDEX('-',ViewsClicksCombined)
		) AS INT
		) 
	) + SUM(Likes)
) * 100
/
NULLIF(
	SUM(
		TRY_CAST(
			LEFT(ViewsClicksCombined,
				CHARINDEX('-',ViewsClicksCombined) -1)
				AS INT
			)
		), 0
	), 2
) AS EngagementRate

FROM engagement_data
WHERE ContentType != 'Newsletter'
GROUP BY 
	UPPER(REPLACE(ContentType, 'SocialMedia', 'Social Media'))
ORDER BY 
	EngagementRate DESC;

-- Q15. Which products generate the highest customer engagement? --

SELECT
	p.ProductID,
	p.ProductName,

	SUM(
		TRY_CAST(
			LEFT(e.ViewsClicksCombined,
				CHARINDEX('-',e.ViewsClicksCombined) -1)
				AS INT
			)
		) AS TotalViews,
	SUM(
		TRY_CAST(
		RIGHT(e.ViewsClicksCombined,
		LEN(e.ViewsClicksCombined)-CHARINDEX('-',e.ViewsClicksCombined)
		)
		AS INT
		)
) AS TotalClicks,

SUM(e.Likes) AS TotalLikes,

ROUND(
	(
	SUM(
		TRY_CAST(
		RIGHT(e.ViewsClicksCombined,
		LEN(e.ViewsClicksCombined)-CHARINDEX('-',e.ViewsClicksCombined)
		) AS INT
		) 
	) + SUM(e.Likes)
) * 100
/
NULLIF(
	SUM(
		TRY_CAST(
			LEFT(e.ViewsClicksCombined,
				CHARINDEX('-',e.ViewsClicksCombined) -1)
				AS INT
			)
		), 0
	), 2
) AS EngagementRate

FROM engagement_data e

INNER JOIN products p
ON e.ProductID = p.ProductID

WHERE ContentType != 'Newsletter'

GROUP BY
    p.ProductID,
    p.ProductName

ORDER BY
    TotalClicks DESC,
    TotalLikes DESC;

-- Q16. What is the customer distribution across journey stages? --

SELECT
	UPPER(Stage) AS Stage,
	COUNT(DISTINCT CustomerID) AS CustomerCount
FROM
	customer_journey
GROUP BY 
	UPPER(Stage)
ORDER BY CustomerCount DESC;

-- Q17. Which journey stages have the highest average duration? --

SELECT
	UPPER(Stage) AS Stage,
	COUNT(*) AS JourneyRecords,
	ROUND(AVG(CAST(Duration AS DECIMAL(10,2))),2) AS AverageDuration
FROM customer_journey
WHERE Duration IS NOT NULL
GROUP BY
	UPPER(Stage)
ORDER BY 
	AverageDuration DESC;

-- Advanced Business Analysis --

-- Q18. What is the customer drop-off between journey stages? --

SELECT
	UPPER(Stage) AS Stage,

	COUNT(DISTINCT CustomerID) AS TotalCustomers,

	COUNT(DISTINCT CASE
		WHEN UPPER(Action) = 'DROP-OFF'
		THEN CustomerID
	END) AS DropOffCustomers,

ROUND(
	COUNT(DISTINCT CASE
		WHEN UPPER(Action) = 'DROP-OFF'
            THEN CustomerID
        END) * 100.0
        / NULLIF(COUNT(DISTINCT CustomerID), 0),
        2
    ) AS DropOffRate

FROM customer_journey

GROUP BY UPPER(Stage)

ORDER BY DropOffRate DESC;

-- Which products have high engagement but poor customer ratings? -- 

WITH Engagement AS
(
	SELECT
		ProductID,
		SUM(
			TRY_CAST(
				LEFT(ViewsClicksCombined, CHARINDEX('-', ViewsClicksCombined) -1)
				AS INT
				)
			) AS TotalViews,

		SUM(
			TRY_CAST(
				RIGHT(
					ViewsClicksCombined,
					LEN(ViewsClicksCombined) - CHARINDEX('-',ViewsClicksCombined)
					)
					AS INT
				)
			) AS TotalClicks,

		SUM(Likes) AS TotalLikes

	FROM engagement_data
	WHERE ContentType != 'Newsletter'
	GROUP BY ProductID
),

Reviews AS
(
	SELECT
		ProductID,
		COUNT(*) AS ReviewCount,
		AVG(CAST(Rating AS DECIMAL(10,2))) AS AverageRating
	FROM customer_reviews
	GROUP BY ProductID
)

SELECT
	p.ProductID,
	p.ProductName,
	e.TotalViews,
    e.TotalClicks,
    e.TotalLikes,
    r.ReviewCount,
    ROUND(r.AverageRating, 2) AS AverageRating

FROM products p

INNER JOIN Engagement e
    ON p.ProductID = e.ProductID

INNER JOIN Reviews r
    ON p.ProductID = r.ProductID

WHERE r.ReviewCount >= 5

ORDER BY
    e.TotalClicks DESC,
    r.AverageRating ASC;
						
-- Q20. Which products receive the most negative customer ratings? --

SELECT
	p.ProductID,
	p.ProductName,
	COUNT(*) AS NegativeReviewsCount
FROM customer_reviews r
INNER JOIN
	products p
ON r.ProductID = p.ProductID
WHERE r.Rating <= 2
GROUP BY
	p.ProductID,
	p.ProductName
ORDER BY
NegativeReviewsCount DESC;

-- Q21 - Which products have both poor ratings and high review volume? --

SELECT
	p.ProductID,
	p.ProductName,
	COUNT(r.ReviewID) AS ReviewCount,
	ROUND(
		AVG(CAST(r.Rating AS DECIMAL(10,2))),2) AS AverageRating

FROM customer_reviews r

INNER JOIN products p
ON r.ProductID = p.ProductID

GROUP BY 
	p.ProductID,
	p.ProductName

HAVING
	COUNT(r.ReviewID) >= 60
	AND AVG(CAST(r.Rating AS DECIMAL(10,2))) <= 3.5

ORDER BY
	ReviewCount DESC;

-- Q22. Which journey actions occur most frequently? --

SELECT
	Action,
	COUNT(*) AS ActionCount
FROM customer_journey
GROUP BY Action
ORDER BY ActionCount DESC;

-- Q23. Which journey stages have the highest customer activity? --

SELECT
	UPPER(Stage) AS Stage,
	COUNT(*) AS TotalInteractions,
	COUNT(DISTINCT CustomerID) AS UniqueCustomers
FROM customer_journey
GROUP BY UPPER(Stage)
ORDER BY TotalInteractions DESC;

-- Q24. What is the relationship between customer rating and review volume by product? --

SELECT
	p.ProductID,
    p.ProductName,
    COUNT(r.ReviewID) AS ReviewCount,
    ROUND(
        AVG(CAST(r.Rating AS DECIMAL(10,2))),
        2
    ) AS AverageRating

FROM products p

LEFT JOIN customer_reviews r
    ON p.ProductID = r.ProductID

GROUP BY
    p.ProductID,
    p.ProductName

ORDER BY
    ReviewCount DESC;