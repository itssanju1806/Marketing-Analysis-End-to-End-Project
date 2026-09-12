# 🛒 ShopEasy Marketing Analysis | End-to-End Analytics Portfolio Project

![SQL](https://img.shields.io/badge/SQL-Microsoft%20SQL%20Server-blue?style=for-the-badge&logo=microsoftsqlserver)
![Python](https://img.shields.io/badge/Python-Sentiment%20Analysis-yellow?style=for-the-badge&logo=python)
![Power BI](https://img.shields.io/badge/Power%20BI-Dashboard-orange?style=for-the-badge&logo=powerbi)
![DAX](https://img.shields.io/badge/DAX-KPI%20Analysis-purple?style=for-the-badge)
![Analytics](https://img.shields.io/badge/Analytics-End--to--End-green?style=for-the-badge)

---

## 📌 Project Overview

**ShopEasy Marketing Analysis** is an end-to-end analytics portfolio project developed for a fictional online retail business, **ShopEasy**, to investigate declining customer engagement and conversion despite increased investment in digital marketing campaigns.

The project transforms raw **customer, product, geography, engagement, customer journey, and customer review data** into a unified decision-support solution using **Microsoft SQL Server, Python, Power BI, and DAX**.

The analysis focuses on understanding:

- Customer engagement and marketing content performance
- Website conversion and customer journey behavior
- Funnel drop-off activity
- Product-level performance
- Customer ratings and review patterns
- Text-based customer sentiment
- Month-over-Month KPI movement
- Opportunities to improve marketing effectiveness and customer experience

The project follows a complete analytics lifecycle:

**Business Case → Business Questions & KPIs → Data Preparation → SQL Analysis → Python Sentiment Analysis → Data Modeling → Power BI & DAX → Interactive Dashboard → Insights → Recommendations**

---

## 🏢 Company Overview

**ShopEasy** is an online retail business experiencing declining customer engagement and conversion despite increased investment in digital marketing campaigns.

Management requires a data-driven approach to understand customer interactions, identify conversion bottlenecks, evaluate marketing content performance, and uncover customer experience issues through reviews and feedback.

The project addresses these challenges by bringing together multiple analytical layers into a single reporting solution.

---

## 🚨 Business Problem

ShopEasy's key business challenges include:

1. Declining customer engagement with marketing content.
2. Lower website conversion and customer progression through the purchase journey.
3. Increasing marketing investment without the expected return.
4. Limited visibility into customer sentiment and recurring product or service issues.
5. Difficulty identifying which products, content types, journey actions, and customer feedback patterns require management attention.

The analysis is designed around three core business goals:

- **Improve Conversion**
- **Increase Customer Engagement**
- **Strengthen Customer Feedback Scores**

---

# 🎯 Business Objectives

The project aims to:

- Identify customer journey bottlenecks and funnel drop-off points.
- Measure and monitor website conversion performance.
- Determine which marketing content types generate stronger customer interaction.
- Evaluate engagement using Views, Clicks, and Likes.
- Analyze product-level customer ratings and review volume.
- Apply sentiment analysis to customer review text.
- Identify products receiving negative customer feedback.
- Understand the relationship between customer perception and review activity.
- Track KPI performance using Month-over-Month analysis.
- Translate analytical findings into actionable marketing and customer-experience recommendations.

---

# 📊 Key KPIs

The project tracks the following business KPIs:

| KPI | Definition / Purpose |
|---|---|
| **Total Customers** | Measures the customer base being analyzed |
| **Conversion Rate** | Measures the percentage of customers progressing to purchase |
| **Engagement Rate** | Measures customer interaction relative to content views |
| **Average Rating** | Measures overall customer feedback performance |
| **Views** | Measures marketing content reach |
| **Clicks** | Measures customer interaction with marketing content |
| **Likes** | Measures content engagement |
| **Review Volume** | Measures the level of customer feedback activity |
| **Sentiment** | Evaluates the tone of customer review text |
| **MoM KPI Movement** | Tracks whether key metrics are improving or declining |

---

# ❓ Business Questions

The analysis is structured around business-driven SQL questions divided into **Basic, Intermediate, and Advanced Business Analysis**.

## 🟢 Basic Business Analysis

### Q1. Customer & Product Analysis
What are the key characteristics of the ShopEasy customer and product base?

### Q2. Product Price Segmentation
How can products be categorized into Low, Medium, and High price segments?

### Q3. Customer Geographic Distribution
How are customers distributed across countries and cities?

### Q4. Customer Review Overview
What are the key characteristics of customer reviews and ratings?

### Q5. Engagement Overview
How do Views, Clicks, Likes, and content types contribute to customer engagement?

### Q6. Customer Journey Overview
What are the major stages, actions, and behaviors observed throughout the customer journey?

---

## 🟡 Intermediate Business Analysis

### Q7. Customer Engagement by Content Type
Which content types generate stronger customer engagement?

### Q8. Engagement Performance Over Time
How does customer engagement change over time?

### Q9. Product-Level Engagement
Which products receive the highest number of marketing views and interactions?

### Q10. Customer Rating Performance
How do customer ratings vary across products?

### Q11. Review Volume by Product
Which products generate the highest volume of customer feedback?

### Q12. Rating Distribution
How are customer ratings distributed across the available review data?

### Q13. Sentiment Distribution
What proportion of reviews falls into Positive, Mixed Positive, Neutral, Mixed Negative, and Negative sentiment categories?

### Q14. Customer Journey Activity
How does customer activity vary across journey stages?

### Q15. Journey Action Performance
Which customer journey actions occur most frequently?

### Q16. Conversion Performance
How does conversion performance change over time and across products?

### Q17. Product Conversion
Which products demonstrate stronger or weaker conversion performance?

### Q18. Funnel Drop-Off Analysis
Which customer journey stages have the highest customer drop-off rates?

The analysis uses the actual `DROP-OFF` journey action rather than assuming a drop-off stage based on an artificial funnel structure.

---

## 🔴 Advanced Business Analysis

### Q19. Engagement vs Rating
Which products have high marketing engagement but poor customer ratings?

### Q20. Negative Customer Feedback
Which products receive the most negative customer ratings?

### Q21. Rating & Review Volume
Which products have both poor ratings and high review volume?

### Q22. Journey Action Frequency
Which customer journey actions occur most frequently?

### Q23. Customer Activity by Journey Stage
Which journey stages have the highest customer activity?

### Q24. Rating vs Review Volume
What is the relationship between customer rating and review volume by product?

---

# 🗂️ Dataset & Data Model

The SQL database is named:

    PortfolioProject_MarketingAnalytics

The project works with the following core tables:

    PortfolioProject_MarketingAnalytics
    │
    ├── products
    ├── customers
    ├── geography
    ├── customer_reviews
    ├── engagement_data
    └── customer_journey

### Products

Contains product-level information used for product and pricing analysis.

Key analytical elements include:

- Product ID
- Product information
- Product price
- Price segmentation

### Customers

Contains customer-level information used for customer analysis.

### Geography

Provides geographic information linked to customers through `GeographyID`.

### Customer Reviews

Contains customer feedback and review information including:

- Review ID
- Customer ID
- Product ID
- Review Date
- Rating
- Review Text

### Engagement Data

Contains marketing engagement information including:

- Content Type
- Views
- Clicks
- Likes
- Engagement Date

### Customer Journey

Contains customer interaction and journey information including:

- Journey ID
- Customer ID
- Product ID
- Visit Date
- Stage
- Action
- Duration

---

# 🧹 SQL Data Preparation & Transformation

Microsoft SQL Server was used for data preparation, cleaning, transformation, validation, and business analysis.

Key data preparation activities included:

### Product Transformation

Products were segmented based on price:

    Price < 50       → Low
    Price 50–200     → Medium
    Price > 200      → High

### Customer-Geography Enrichment

Customer records were enriched using the relationship between:

    customers.GeographyID
            ↓
    geography.GeographyID

This enabled analysis by country and city.

### Review Text Cleaning

Review text was standardized by removing unnecessary double spaces.

### Engagement Data Transformation

The engagement dataset was prepared by:

- Standardizing content types.
- Correcting inconsistent `Socialmedia` naming.
- Converting it to `Social Media`.
- Separating combined Views and Clicks fields.
- Retaining Likes as an independent engagement metric.
- Excluding Newsletter records from engagement analysis.
- Formatting engagement dates.

### Customer Journey Cleaning

Customer journey data was prepared by:

- Identifying duplicate records using `ROW_NUMBER()`.
- Handling missing journey duration.
- Replacing missing duration values using date-level average duration.
- Standardizing journey-stage values.
- Preserving the actual `DROP-OFF` action for funnel analysis.

---

# 🐍 Python Customer Sentiment Analysis

Numerical ratings alone do not completely capture customer experience.

Python was therefore used to perform **text-based sentiment analysis** on customer reviews using **VADER Sentiment Analysis**.

### Workflow

    SQL Server
        ↓
    Extract Customer Reviews
        ↓
    Python / Pandas
        ↓
    VADER Sentiment Analysis
        ↓
    Compound Sentiment Score
        ↓
    Combine Text Sentiment + Numerical Rating
        ↓
    Sentiment Classification
        ↓
    Sentiment Buckets
        ↓
    Export Enriched CSV
        ↓
    Power BI

### Sentiment Score

VADER produces a compound sentiment score ranging from:

    -1 → Negative
     0 → Neutral
    +1 → Positive

### Sentiment Categories

Reviews were classified into:

- **Positive**
- **Mixed Positive**
- **Neutral**
- **Mixed Negative**
- **Negative**

### Sentiment Buckets

The sentiment scores were further grouped into:

    0.50 to 1.00   → Positive
    0.00 to 0.49   → Mixed Positive
    -0.49 to 0.00  → Mixed Negative / Neutral range
    -1.00 to -0.50 → Negative

The enriched review dataset was exported as:

    fact_customer_reviews_with_sentiment.csv

The Python layer therefore extends traditional rating analysis by combining **numerical customer ratings with textual customer sentiment**.

---

# 📐 Power BI Data Model & Reporting

Power BI was used to bring together the prepared analytical datasets and create an interactive management dashboard.

The reporting solution focuses on:

- KPI monitoring
- Conversion analysis
- Customer journey analysis
- Social media engagement
- Product performance
- Customer ratings
- Review analysis
- Sentiment analysis
- Time-based performance
- Month-over-Month KPI movement

The project maintains a data-model-first approach and avoids creating unsupported relationships simply to force cross-dimensional analysis.

---

# 📊 Power BI Dashboard

The final Power BI report contains **four analytical pages**.

## 1️⃣ Executive Overview

Provides a high-level management view of the business.

### Key Components

- Total Customers
- Conversion Rate
- Average Rating
- Engagement Rate
- Views
- Clicks
- Likes
- Customer gender distribution
- Monthly rating trend
- Monthly engagement trend
- Customer journey funnel
- Content type performance
- Customer review and sentiment analysis
- MoM KPI indicators

---

## 2️⃣ Conversion Details

Focuses specifically on customer journey and conversion performance.

### Key Components

- Conversion Rate
- Customer journey funnel
- Journey actions
- Monthly conversion trend
- Product-level conversion analysis
- Product comparison
- Year slicer
- Month slicer
- Product slicer

The page specifically incorporates actual customer journey actions, including explicit **Drop-off** activity.

---

## 3️⃣ Social Media Details

Focuses on marketing engagement and content performance.

### Key Components

- Views
- Clicks
- Likes
- Engagement Rate
- MoM engagement movement
- Monthly engagement trend
- Content type analysis
- Likes by content type
- Product-level views
- Year slicer
- Month slicer
- Quarter slicer
- Product slicer

The objective is to distinguish **reach from meaningful customer interaction**.

---

## 4️⃣ Customer Review Details

Focuses on customer experience, ratings, reviews, and sentiment.

### Key Components

- Average Rating
- Rating MoM movement
- Monthly rating trend
- Rating distribution
- Sentiment category distribution
- Review volume
- Product-level review analysis
- Customer/review scatter analysis
- Detailed review table
- Review text
- Sentiment classification
- Rating
- Year slicer
- Month slicer
- Product slicer
- Sentiment slicer

This page enables management to investigate customer feedback at both summary and review level.

---

# 🧮 DAX & KPI Development

DAX was used to create analytical measures, KPI calculations, time-based comparisons, and dynamic performance indicators.

## Engagement Rate

The project calculates Engagement Rate using customer interactions relative to views:

    Engagement Rate =
    DIVIDE(
        [Total Clicks] + [Total Likes],
        [Total Views],
        0
    )

This provides a more meaningful engagement indicator than views alone.

---

## Customers Month-over-Month %

    Customers MoM % =
    VAR CurrentMonth =
        [Total Customers]
    VAR PreviousMonth =
        CALCULATE(
            [Total Customers],
            DATEADD('Date'[Date], -1, MONTH)
        )
    RETURN
        DIVIDE(
            CurrentMonth - PreviousMonth,
            PreviousMonth,
            0
        )

The same time-intelligence framework is applied to:

    Engagement Rate MoM %
    Conversion Rate MoM %
    Rating MoM %

---

## KPI Directional Indicators

Dynamic arrows are used to communicate KPI movement:

    Customers MoM Arrow =
    IF(
        [Customers MoM %] > 0,
        UNICHAR(9650),
        IF(
            [Customers MoM %] < 0,
            UNICHAR(9660),
            UNICHAR(8212)
        )
    )

Where:

    ▲  Increase
    ▼  Decrease
    —  No Change

This makes the dashboard easier to interpret from a management perspective.

---

# 🔄 End-to-End Project Workflow

    Business Case
          ↓
    Business Questions & KPIs
          ↓
    Data Understanding
          ↓
    SQL Data Preparation
          ↓
    SQL Data Cleaning & Transformation
          ↓
    SQL Business Analysis
          ↓
    Python Sentiment Analysis
          ↓
    Enriched Review Dataset
          ↓
    Data Modeling
          ↓
    Power BI & DAX
          ↓
    Interactive Dashboard
          ↓
    Business Insights
          ↓
    Recommendations
          ↓
    Executive Summary

---

# 💡 Key Insights

## 1. Conversion Funnel is a Critical Optimization Area

The Conversion Details dashboard evaluates customer progression through journey actions and stages instead of relying only on an overall conversion percentage.

The inclusion of explicit **Drop-off** activity makes funnel diagnosis more actionable.

### Business Implication

Improving conversion requires optimization of the **customer journey**, not simply generating additional website traffic.

---

## 2. Engagement Should Be Evaluated Beyond Views

Views measure reach, but they do not necessarily represent meaningful customer interaction.

The dashboard therefore evaluates:

    Views
    +
    Clicks
    +
    Likes
    =
    Engagement Analysis

Content performance is also evaluated across content types and over time.

### Business Implication

Marketing decisions should prioritize content that generates meaningful interaction rather than optimizing purely for reach.

---

## 3. Product Performance and Customer Sentiment Should Be Considered Together

Product-level analysis combines:

- Average Rating
- Review Volume
- Sentiment Category
- Review Text

This helps distinguish between:

- Products with strong customer perception
- Products generating substantial feedback
- Products receiving weaker ratings
- Products showing negative sentiment patterns

### Business Implication

Products receiving recurring negative feedback should be investigated for potential quality, value, delivery, or customer-experience issues.

---

## 4. Customer Feedback is a Diagnostic Layer

The Customer Review dashboard provides visibility into:

- Rating distribution
- Average rating
- Review volume
- Sentiment distribution
- Product-level reviews
- Review text
- Sentiment classification

### Business Implication

Customer feedback should be treated as an input into **product improvement and marketing strategy**, not merely as a reporting metric.

---

## 5. MoM Tracking Makes the Dashboard Performance-Oriented

Month-over-Month analysis is applied to key metrics such as:

- Customer Count
- Engagement Rate
- Conversion Rate
- Average Rating
- Views
- Clicks
- Likes

Directional indicators help stakeholders quickly identify whether performance is improving or deteriorating.

### Business Implication

The dashboard can be used as an ongoing **performance-monitoring tool** rather than a static analytical report.

---

# 📌 Business Recommendations

## 1. Prioritize Lower-Funnel Conversion Optimization

Investigate customer journey actions and stages associated with the highest drop-off activity.

Potential areas of focus include:

- Product-page experience
- Checkout usability
- Purchase barriers
- Calls-to-action
- Product information
- Customer trust factors

---

## 2. Allocate Marketing Effort Based on Engagement Quality

Evaluate Views, Clicks, Likes, and Engagement Rate together.

Content generating high reach but weak interaction should be reviewed, while consistently engaging content should receive greater consideration for future campaigns.

---

## 3. Improve Campaign Efficiency Through KPI Monitoring

Monitor:

    Conversion Rate
    Engagement Rate
    MoM Movement

Marketing investment should ultimately be evaluated against meaningful customer actions and conversion outcomes rather than activity volume alone.

---

## 4. Act on Negative Customer Sentiment

Create a recurring review process for products showing:

- Low average ratings
- High negative-review volume
- Negative sentiment patterns
- High review activity combined with poor customer perception

These products should be prioritized for root-cause investigation and corrective action.

---

## 5. Close the Loop Between Customer Feedback and Product Strategy

Customer sentiment findings should flow through the broader business process:

    Product
       ↓
    Marketing
       ↓
    Customer Experience
       ↓
    Engagement
       ↓
    Conversion

Improving customer experience can strengthen satisfaction while supporting future engagement and conversion.

---

## 6. Use the Dashboard for Continuous Performance Monitoring

Establish a recurring KPI review cadence covering:

    Customers
       ↓
    Engagement
       ↓
    Conversion
       ↓
    Ratings
       ↓
    Sentiment
       ↓
    Customer Journey

The MoM indicators make it easier to identify emerging changes and determine where corrective action is required.

---

# 🛠️ Tools & Technologies

| Tool / Technology | Purpose |
|---|---|
| **Microsoft SQL Server** | Database management, cleaning, transformation, and analysis |
| **SQL Server Management Studio (SSMS)** | SQL development and query execution |
| **SQL** | Data preparation and business analysis |
| **Python** | Customer review sentiment analysis |
| **Pandas** | Data extraction, transformation, and processing |
| **NLTK / VADER** | Text-based sentiment analysis |
| **Power BI** | Interactive dashboard and business reporting |
| **DAX** | KPI calculations, time intelligence, MoM analysis, and dynamic indicators |
| **CSV** | Data exchange and enriched sentiment dataset |
| **GitHub** | Project version control and portfolio presentation |

---

# 🧠 SQL Concepts & Techniques Used

This project demonstrates practical application of SQL for business analytics.

### Data Retrieval & Filtering

    SELECT
    WHERE
    DISTINCT
    TOP

### Aggregation

    SUM()
    COUNT()
    AVG()

### Grouping & Sorting

    GROUP BY
    ORDER BY

### Conditional Logic

    CASE WHEN

### Window Functions

    ROW_NUMBER() OVER()

Used for identifying duplicate customer-journey records.

### String Transformation

    REPLACE()
    UPPER()

Used for review-text cleaning and engagement content standardization.

### Mathematical Calculations

Used for:

- Conversion analysis
- Engagement calculations
- Customer ratings
- Review analysis
- Journey metrics

### NULL Handling

    NULLIF()
    COALESCE()

Used where appropriate for robust analytical calculations.

### Common Table Expressions

    WITH

Used for structured analytical queries.

### Data Type Conversion

    CAST()
    ROUND()

---

# 📈 Analytical Areas

### 👥 Customer Analysis

Analyze customer distribution and customer-level behavior.

### 🛍️ Product Analysis

Evaluate product-level engagement, conversion, ratings, and review activity.

### 📣 Marketing Engagement

Analyze Views, Clicks, Likes, content types, and Engagement Rate.

### 🧭 Customer Journey

Analyze journey stages, actions, activity, conversion, and explicit Drop-off behavior.

### 🔄 Conversion Analysis

Evaluate conversion trends and product-level conversion performance.

### ⭐ Customer Ratings

Analyze average rating, rating distribution, and rating movement over time.

### 💬 Customer Sentiment

Combine review text with numerical ratings using VADER sentiment analysis.

### 📅 Time-Series Analysis

Track monthly performance and MoM KPI movement.

### 🎯 Management Reporting

Provide a consolidated view of marketing, customer journey, conversion, and customer experience performance.

---

# 📂 Repository Structure

    ShopEasy-Marketing-Analysis/
    │
    ├── 📂 Dashboard/
    │   ├── Marketing_Analysis_Dashboard.png
    │
    ├── 📂 Dataset/
    │   ├── Episode 2 - PortfolioProject_MarketingAnalytics.bak
    │   └── fact_customer_reviews_with_sentiment.csv
    │
    ├── 📂 SQL/
    │   └── Marketing_Analysis.sql
    │
    ├── 📂 Python/
    │   └── Customer_Sentiment_Analysis.ipynb
    │
    ├── 📂 Reports/
    │   └── Marketing_Analysis.pbix
    │   └── Executive Summary.docx
    │
    └── 📄 README.md

---

# 📊 Dashboard Pages at a Glance

| Page | Primary Focus | Key Analysis |
|---|---|---|
| **Executive Overview** | Management Summary | Customers, Conversion, Engagement, Ratings, Funnel, Sentiment |
| **Conversion Details** | Conversion & Journey | Funnel, Drop-offs, Actions, Product Conversion, Trends |
| **Social Media Details** | Marketing Engagement | Views, Clicks, Likes, Content Type, Engagement Trends |
| **Customer Review Details** | Customer Experience | Ratings, Reviews, Sentiment, Products, Review Text |

---

# 🚀 Project Highlights

- Built a complete **end-to-end marketing analytics solution** using SQL, Python, Power BI, and DAX.
- Converted a real-world-style business problem into structured analytical questions and KPIs.
- Designed a SQL database containing product, customer, geography, engagement, journey, and review datasets.
- Performed SQL-based data cleaning and transformation.
- Standardized engagement content types and separated combined Views and Clicks fields.
- Identified and handled duplicate customer-journey records using `ROW_NUMBER()`.
- Treated missing customer-journey duration using date-level average duration.
- Preserved explicit `DROP-OFF` journey activity for funnel analysis.
- Developed structured SQL business analysis across customer, product, engagement, journey, rating, review, and conversion dimensions.
- Used Python and VADER to analyze customer review sentiment.
- Combined numerical ratings with textual sentiment classification.
- Exported an enriched review dataset for Power BI.
- Developed a multi-page interactive Power BI dashboard.
- Created DAX measures for Engagement Rate and MoM KPI analysis.
- Added dynamic directional indicators for KPI movement.
- Analyzed marketing content beyond simple reach metrics.
- Connected customer feedback analysis with product and customer-experience decision-making.
- Converted analytical findings into actionable business recommendations.
- Created an executive-level reporting layer for continuous performance monitoring.

---

# 💼 Business Impact

The project demonstrates how an organization can move from fragmented marketing, customer journey, and customer feedback data toward a unified decision-support solution.

The analytical workflow enables ShopEasy to:

- Identify customer journey drop-off points.
- Monitor conversion performance.
- Evaluate marketing engagement.
- Compare content performance.
- Track customer and engagement trends.
- Analyze product-level customer feedback.
- Combine numerical ratings with text sentiment.
- Identify products requiring customer-experience attention.
- Monitor KPI performance through MoM analysis.
- Translate analytical findings into targeted marketing and customer-experience recommendations.

Ultimately, the project addresses the core business challenge of understanding **why increased marketing activity is not translating into stronger engagement and conversion**, while using customer feedback to identify opportunities for improvement.

---

# 🎯 Conclusion

The **ShopEasy Marketing Analysis** project demonstrates a complete analytics lifecycle—from business problem definition and SQL data preparation to Python-based sentiment analysis, data modeling, DAX-driven KPI development, and interactive Power BI reporting.

The final solution provides a unified view of:

    Customer Engagement
            +
    Marketing Performance
            +
    Customer Journey
            +
    Conversion
            +
    Product Performance
            +
    Customer Ratings
            +
    Customer Sentiment

The primary strategic opportunity is to move beyond simply measuring marketing activity and instead optimize the **complete customer journey**:

    Attract the Right Audience
              ↓
    Create Meaningful Engagement
              ↓
    Reduce Funnel Drop-Offs
              ↓
    Understand Customer Feedback
              ↓
    Improve Customer Experience
              ↓
    Monitor KPI Movement
              ↓
    Drive Sustainable Conversion Improvement

---

# 👨‍💻 About the Project

**Project Name:** ShopEasy Marketing Analysis  
**Project Type:** End-to-End Analytics Portfolio Project  
**Domain:** E-Commerce / Retail / Marketing Analytics  
**Database:** Microsoft SQL Server  
**Data Analysis:** SQL + Python  
**Visualization:** Microsoft Power BI  
**Analytics Language:** DAX + Python  
**Sentiment Analysis:** VADER  
**Reporting:** Interactive Power BI Dashboard

---

# 👨‍💻 About Me

**Sanjay Singh**  
**Data Analyst | SQL | Excel | Power BI | Python**

I am building a portfolio of practical data analytics projects focused on solving business problems through **data analysis, visualization, and actionable insights**.

This project demonstrates hands-on experience across the complete analytics workflow, including:

    Business Problem Solving
            ↓
    SQL Data Analysis
            ↓
    Python Analytics
            ↓
    Data Modeling
            ↓
    Power BI Visualization
            ↓
    DAX
            ↓
    Business Insights
            ↓
    Recommendations

---

# ⭐ Connect & Explore

If you found this project useful or interesting:

⭐ **Star this repository**  
🍴 **Fork the repository**  
💼 **Connect with me on LinkedIn**  
📂 **Explore my other Data Analytics projects**

---

# 📬 Let's Connect

**Sanjay Singh**

📧 **Email:** singhsanjay846@gmail.com

💼 **LinkedIn:** www.linkedin.com/in/sanjay-singh-509aa7135

🐙 **GitHub:** https://github.com/itssanju1806

I'm always open to connecting with fellow data enthusiasts, analysts, recruiters, and professionals working in the analytics space.

---

## 🚀 Thanks for visiting this project!
