use `customerchurnanalysis`;
select count(*) from `customerchurn`;
select * from `customerchurn`;
/* Total Number of customer */
select Distinct count(`ï»¿CustomerID`) from `customerchurn`;

/* Checking any duplicate row */
select 'CustomerID', count('CustomerID') as TotalID from `customerchurn` group by 'CustomerID' having count('CustomerID')>1;

/* Checking Null Values */
select 'Tenure' as ColName, count(*) as Nullcount from `customerchurn` where 'Tenure' IS NULL 
Union
select 'PreferredLoginDevice' as ColName, count(*) as Nullcount from `customerchurn` where 'PreferredLoginDevice' IS NULL 
union
select 'CityTier' as ColName, count(*) as Nullcount from `customerchurn` where 'CityTier' IS NULL 
Union
select 'WarehouseToHome' as ColName, count(*) as Nullcount from `customerchurn` where 'WarehouseToHome' IS NULL 
Union
select 'PreferredPaymentMode' as ColName, count(*) as Nullcount from `customerchurn` where 'PreferredPaymentMode' IS NULL 
Union
select 'Churn' as ColName, count(*) as Nullcount from `customerchurn` where 'Churn' IS NULL 
Union
select 'Complain' as ColName, count(*) as Nullcount from `customerchurn` where 'Complain' IS NULL ;

/* adding new churn col in table for specifying 1 = churn and 0 = not churn*/

Alter table `customerchurn` Add CustomerStatus nvarchar(20);
update `customerchurn` set CustomerStatus =
Case 
when Churn = 1 Then ' Churned'
when  Churn= 0 Then ' Not Churned'
end;

Select distinct churn from `customerchurn`;

/* adding new Complaint col in table for specifying 1 = Yes and 0 = No*/

Alter table `customerchurn` Add ComplaintRegister nvarchar(10);
update `customerchurn` set ComplaintRegister =
Case 
when Complain = 1 Then 'Yes'
when Complain = 0 Then 'No'
end;

/* checking the values in each col for correctness and accuracy */
/*fixing redundancy */

select distinct PreferredLoginDevice from `customerchurn`;

/* result is Mobile phone, phone, computer. updating mobile phone to phone*/

update `customerchurn` set PreferredLoginDevice='Phone' where PreferredLoginDevice='Mobile Phone';

select distinct PreferredPaymentMode from `customerchurn`;

update `customerchurn` set PreferredPaymentMode='Cash on Delivery' where PreferredPaymentMode='COD';

update `customerchurn` set PreferredPaymentMode='Credit Card' where PreferredPaymentMode='CC';

select distinct Gender from `customerchurn`;

select distinct WarehouseToHome from `customerchurn` order by WarehouseToHome Desc;

update `customerchurn` set WarehouseToHome='26' where WarehouseToHome='126';

select distinct HourSpendOnApp from `customerchurn`;

select distinct PreferedOrderCat from `customerchurn`;

update `customerchurn` set PreferedOrderCat='Phone' where PreferedOrderCat='Mobile Phone' or PreferedOrderCat='Mobile';

select distinct MaritalStatus from `customerchurn`;


/* Data Exlporation */
/* What is the overall Customer Churn Rate ? */

select TotalNumofCust, TotalNumofChurn, cast((TotalNumofChurn *1.0 / TotalNumofCust * 1.0 )*100 as Decimal(10,2)) As ChurnRate
from
((select count(*) As TotalNumofCust from `customerchurn`) As TotalCustomer ,
( select count(*) as TotalNumofChurn from `customerchurn` where 
CustomerStatus = ' Churned') As TotalChurned );

/* HOw does the churn rate vary based on te preferredlogin device? */

select PreferredLoginDevice, count(*) as TotalCustomer, Sum(Churn) as TotalChurn , cast((sum(Churn)*1.0 / count(*) *1.0)*100 as Decimal(10,2))
as ChurnRate from customerchurn group by PreferredLoginDevice;

/* What is the distribution of customer across different city tiers*/

select CityTier, count(*) as Totalcustomer, sum(Churn) as Totalchurn, cast((sum(churn)*1.0/count(*)*1.0)*100 as decimal(10,2)) as ChurnRate
from customerchurn group by CityTier order by CityTier ;

/* Is there any relation between the warehousetohome distance and customre churnrate ?*/

select distinct WarehouseToHome from customerchurn order by WarehouseToHome ;

Alter table customerchurn
Add WarehouseRange nvarchar(25);

update customerchurn set WarehouseRange =
Case 
when WarehouseToHome <= 10 Then 'Very Close Distance'
when WarehouseToHome > 10 and WarehouseToHome <= 20 Then 'Close Distance'
when WarehouseToHome > 20 and WarehouseToHome <= 30 Then 'Moderate Distance'
when WarehouseToHome > 30 then 'Far Distance'
end;

select WarehouseRange, count(*) as TotalCustomer, sum(churn) as Totalchurn , cast((sum(churn)*1.0/count(*)*1.0)*100 as decimal(10,2)) as ChurnRate
from customerchurn group by WarehouseRange;

/* What is the most prefered payment mode among the churned customer*/

select PreferredPaymentMode, count(*) as TotalCustomer, sum(churn) as Totalchurn , cast((sum(churn)*1.0/count(*)*1.0)*100 as decimal(10,2)) as ChurnRate
from customerchurn group by PreferredPaymentMode order by ChurnRate desc;

/* what is the typical tenure for churned cusotmer */

select distinct Tenure from customerchurn order by Tenure;

Alter table customerchurn
Add TenureRange nvarchar(25);

update customerchurn set TenureRange =
Case 
when Tenure <= 6 Then '6 Month'
when Tenure > 6 and Tenure <= 12 Then '1 Year'
when Tenure > 12 and Tenure <= 24 Then '2 Year'
when Tenure > 24 and Tenure <=36  then '3 Year'
when Tenure > 36 and Tenure <=48  then '4 Year'
when Tenure > 48    then 'More than 4 Year'
end;

select TenureRange, count(*) as TotalCustomer, sum(churn) as Totalchurn , cast((sum(churn)*1.0/count(*)*1.0)*100 as decimal(10,2)) as ChurnRate
from customerchurn group by TenureRange order by ChurnRate desc;

/* Is there any difference in churn between male and female ?*/

select Gender, count(*) as TotalCustomer, sum(churn) as Totalchurn , cast((sum(churn)*1.0/count(*)*1.0)*100 as decimal(10,2)) as ChurnRate
from customerchurn group by Gender order by ChurnRate desc;

/* how does the avg time spent on the app differ for churned and non churned customer ?*/

select CustomerStatus, avg(HourSpendOnApp) as AverageTime from customerchurn group by CustomerStatus;

/* which order category is most prefered among the churned?*/

select PreferedOrderCat, count(*) as TotalCustomer, sum(churn) as Totalchurn , cast((sum(churn)*1.0/count(*)*1.0)*100 as decimal(10,2)) as ChurnRate
from customerchurn group by PreferedOrderCat order by ChurnRate desc;

/* is there any relation between customer satifaction and churnrate?*/
select SatisfactionScore, count(*) as TotalCustomer, sum(churn) as Totalchurn , cast((sum(churn)*1.0/count(*)*1.0)*100 as decimal(10,2)) as ChurnRate
from customerchurn group by SatisfactionScore order by ChurnRate desc;

/* do customer complaint influence churned behaviour */
select ComplaintRegister, count(*) as TotalCustomer, sum(churn) as Totalchurn , cast((sum(churn)*1.0/count(*)*1.0)*100 as decimal(10,2)) as ChurnRate
from customerchurn group by ComplaintRegister order by ChurnRate desc;

