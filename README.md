# Wish-Final-TechOf-Final-Project

Exploratory performance and market analysis of the Wish e-commerce platform (Europe) using MySQL and Power BI.

📌 Project Overview

This project focuses on a strategic analysis of real e-commerce data from the Wish platform, centered on the European market during August 2020. Using MySQL for data processing and Power BI for interactive visualization, the main goal was to evaluate sales performance, detect trending products, analyze customer sentiment, and examine price margins.

🛠️ Tech Stack
* **MySQL:** Used for data cleaning, structural filtering and modeling.
* **Power BI / DAX:** Applied for data modeling, creating business metrics, and build the dashboard.
* **PowerPoint:** Used as the development environment for the presentation structure.

📊 Key Analyses & Logic

1. Data Preparation & Cleaning (ETL in MySQL)
* Removed the `title` column as it was completely identical to `title_orig`, optimizing storage.
* Excluded columns irrelevant to business performance, such as merchant profile pictures (`merchant_profile_picture`, `merchant_has_profile_picture`), product URLs, and product pictures.
* Removed `crawl_month` and `theme` columns since the dataset was strictly restricted to August (Summer season), avoiding biased interpretations.
* Created columns for price segment comparison (Merchant Price vs. Retail Price) and market sales status (Above/Below market average).
  * Calculated gross revenue (`Revenue`) as a normalized metric by multiplying product price by total units sold.
* Extracted and normalized product tags into a separate table to allow granular niche filtering without duplicating core product records.

2. Product Performance & Satiation Analysis
* Identified top-performing tags, with "Women's Fashion" emerging as the most used.
* The store specialises in women's clothing and caters to the needs of its female customers.

3. Rating & Customer Sentiment Analysis
* Analyzed the distribution of product ratings to understand the impact of quality on sales volume.


4. The Premium Price Comparing to the Competition
* Investigated the behavior of products priced above the market average.


📈 Visualizations

<img width="1396" height="787" alt="image" src="https://github.com/user-attachments/assets/f9d4fe85-e254-4f28-9c62-49a2db00a12b" />
<img width="1393" height="786" alt="image" src="https://github.com/user-attachments/assets/701440c5-68e9-4937-8fe8-17eb5ff043cb" />



💡 Business Insights

📅 Sales Performance & "Summer Effect"
*  In terms of sales volume, Women's Fashion is the clear market leader. However, it's important to note that this analysis is based on data from August alone. This introduces a significant seasonal bias towards summer clothing. To avoid sudden drops in revenue during quieter periods, it is vital to spread the strategy across a range of other products. It is not possible for us to determine whether the male fashion is dominant in other seasons.

⭐ Customer Sentiment & Supplier Risk
* **20% Negative Ratings:** The analysis revealed a critical pain point—nearly 1 in 5 customers (17.41%) leaves unsatisfying feedback after purchase. 
*  Higher ratings are directly correlated with increased sales volume. Products with higher ratings always sell better. This means that merchants with low ratings have a negative effect on the platform's overall conversion rate.

🏷️ Pricing Strategies
* Products that are significantly more expensive than average retail prices sell more. Products with a more competitive price have lower sales velocity, which can cause cash generation, meaning targeted marketing campaigns or renegotiated margins with merchants may be required.

🔍 Conclusions
* **Supplier Quality Audit:**  The most actionable finding is the 20% negative feedback rate. So, if you're going to manage this operation, the main thing I'd suggest is that you get some quality audits done straight away on the bottom-tier suppliers.
* **Wowen's Fashion: The “Summer Effect”**: Although women's fashion leads in sales, the data is based on a summer month, which artificially inflates the results for this category.
* **Data Limitation**: The data is frozen in August 2020, we lack visibility on other seasons performance. Furthermore, critical metrics such as shipping times, purchase costs (COGS), and clicks are missing.
 *  Relying too heavily on a single seasonal category is a structural risk. Expanding the catalog focus toward timeless categories (e.g., gadgets, accessories) is essential for long-term operational stability.
* **Premium Price Paradox**: Products priced above the market average are among the best-selling items.
 * Perceived quality > Low price.
 * Opportunity to increase the average value.

