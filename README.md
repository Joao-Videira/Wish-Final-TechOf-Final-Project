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
* **Redundancy Elimination:** Removed the `title` column as it was completely identical to `title_orig`, optimizing storage.
* **Structural Filtering:** Excluded columns irrelevant to business performance, such as merchant profile pictures (`merchant_profile_picture`, `merchant_has_profile_picture`), product URLs, and product pictures.
* **Seasonal Context Isolation:** Removed `crawl_month` and `theme` columns since the dataset was strictly restricted to August (Summer season), avoiding biased interpretations.
* **Feature Engineering:** Created columns for price segment comparison (Merchant Price vs. Retail Price) and market sales status (Above/Below market average).
  * Calculated gross revenue (`Revenue`) as a normalized metric by multiplying product price by total units sold.
* **Relational Modeling:** Extracted and normalized product tags into a separate table to allow granular niche filtering without duplicating core product records.

2. Product Performance & Satiation Analysis
* Identified top-performing niches, with "Women's Fashion" emerging as the dominant category.
* Cross-referenced sales volume with seasonal factors to isolate the *"Summer Effect"*.

3. Rating & Customer Sentiment Analysis
* Analyzed the distribution of product ratings to understand the impact of quality on sales volume.
* Segmented negative feedback to identify structural issues in merchant shipping or product description accuracy.

4. The Premium Price Paradox
* Investigated the behavior of products priced above the market average.
* Evaluated whether a premium price strategy correlates with lower conversion rates or higher customer status perception.

📈 Visualizations
*(Note: To display your Power BI screenshots here, save them in your repository and update the paths below)*

* **Overview and Sales Performance**
  

* **Rating and Customer Sentiment Analysis**
  

* **The Premium Price Paradox**


💡 Business Insights

📅 Sales Performance & "Summer Effect"
* Women's Fashion is the absolute leader in sales volume, but this insight comes with a major caveat: the dataset is restricted to August. This introduces a heavy seasonal bias (Summer clothes). Strategy must be diversified to other niches to mitigate sharp revenue drops during the winter season.

⭐ Customer Sentiment & Supplier Risk
* **20% Negative Ratings:** The analysis revealed a critical pain point—nearly 1 in 5 customers (20%) leaves unsatisfying feedback after purchase. 
* There is an absolute, direct correlation between higher ratings and sales volume. Products with higher ratings consistently drive the most sales volume, meaning merchants with consistent low scores act as a drag on the platform's overall conversion rate.

🏷️ Pricing Strategies
* Products with prices significantly higher than the average retail baseline face higher friction. The "Premium Price Paradox" shows that while margins look attractive, lower sales velocity often reduces total cash generation, requiring targeted marketing campaigns or renegotiated margins with merchants.

🔍 Conclusions
* **Supplier Quality Audit:** The most actionable finding is the 20% negative feedback rate. My primary recommendation if managing this operation would be to enforce immediate quality audits on bottom-tier suppliers. Reviewing and screening the quality of products before they go live would directly protect customer lifetime value (LTV).
* **Data Constraints:** The data is frozen in August 2020, we lack visibility on other seasons performance. Furthermore, critical metrics such as shipping times, purchase costs (COGS), and clicks are missing.
* **Niche Diversification:** Relying too heavily on a single seasonal category is a structural risk. Expanding the catalog focus toward timeless categories (e.g., gadgets, accessories) is essential for long-term operational stability.
