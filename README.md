# Customer-Churn-Analysis-Using-SQL
Customer churn is the percentage of customers that stopped using your company's product or service during a certain time frame. 
This Dataset is downloaded from Kaggle.com which contains 20 columns and 1097 rows.
Information is regarding the customers' personal details, satisfaction scores, preferred payment mode, days since the last order, and cashback amount.
I used MySQL Workbench to clean and analyze this dataset.\
Queries includes\
  Count the total number of customers.\
  Check for duplicate rows.\
  Identify and handle null values in specific columns.\
  Add new columns for customer status (churned or not churned) and complaint registration.\
  Update and standardize values in various columns for consistency and accuracy.\
  Perform data exploration and analyze churn rates based on different factors such as preferred login device, city tier, warehouse-to-home distance, payment mode, tenure, gender, app usage,
  order category, satisfaction score, and customer complaints.\
  
## Insights :
The dataset includes 1097 customers.
The overall churn rate is 14.49%.
Customers who prefer logging in with a computer have slightly higher churn rates compared to phone users.
Tier 1 cities have lower churn rates than Tier 2 and Tier 3 cities.
The warehouse affects churn rates, with far customers showing high churn.
“Cash on Delivery” and “E-wallet” payment modes have higher churn rates, while “Credit Card” and “Debit Card” have lower churn rates.
Longer tenure is associated with lower churn rates.
Male customers have slightly higher churn rates than female customers.
“Mobile Phone” order category has the highest churn rate, while “Grocery” has the lowest.
Highly satisfied customers (rating 5) have a relatively higher churn rate.
Customer complaints are prevalent among churned customers.
