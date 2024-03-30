# PBI_KimiaFarma
 Analysis of Kimia Farma's business performance  Year 2020-2023

## Challenge
One of the main projects as a Big Data Analytics Intern at Kimia Farma is to evaluate Kimia Farma's business performance from 2020 to 2023. Here are the steps of the project:

### 1. Importing Dataset to PostgreSQL
**Dataset** <br>
The provided dataset consists of the following tables:
- kf_final_transaction
- kf_inventory
- kf_kantor_cabang
- kf_product
  
### 2. Make Analysis Table
Here are the columns contained in the table:
- transaction_id:transaction id code,
- date: transaction date,
- branch_id: Kimia Farma branch id code,
- branch_name: Kimia Farma branch name,
- kota: Kimia Farma branch city,
- provinsi: Kimia Farma branch province,
- rating_cabang: consumer ratings of Kimia Farma branches,
- customer_name: name of the customer who made a transaction,
- product_id: medicine product code,
- product_name: medicine name,
- actual_price: medicine price,
- discount_percentage:  percentage discount given on medicine,
- persentase_gross_laba: percentage of profit that should be  received from the medicine with some conditions, 
- nett_sales: the price after discount,
- nett_profit: profit earned by Kimia Farma,
- rating_transaksi: consumer rating of the transaction made.

<details>
  <summary> Click to View Query </summary>
    <br>
    
```sql
CREATE TABLE PBI_KF AS
SELECT 
      ft.transaction_id,
      ft.date,
      kc.branch_id,
      kc.branch_name,
      kc.kota,
      kc.provinsi,
      kc.rating AS rating_cabang,
      ft.customer_name, 
      p.product_id,
      p.product_name,
      p.price AS actual_price,
      ft.discount_percentage,
      CASE 
          WHEN p.price <= 50000 THEN 0.1
          WHEN p.price BETWEEN 50000 AND 100000 THEN 0.15
          WHEN p.price BETWEEN 100000 AND 300000 THEN 0.2
          WHEN p.price BETWEEN 300000 AND 500000 THEN 0.25
          ELSE 0.3
      END AS persentase_gross_laba,
      ft.price-(ft.price*ft.discount_percentage) as nett_sales,
      ft.price-(ft.price*ft.discount_percentage) *
      CASE 
          WHEN p.price <= 50000 THEN 0.1
          WHEN p.price BETWEEN 50000 AND 100000 THEN 0.15
          WHEN p.price BETWEEN 100000 AND 300000 THEN 0.2
          WHEN p.price BETWEEN 300000 AND 500000 THEN 0.25
          ELSE 0.3
      END AS nett_profit,
      ft.rating AS rating_transaksi
FROM kf_inventory as i
LEFT JOIN kf_product as p 
  USING (product_id)
LEFT JOIN kf_kantor_cabang as kc
  USING (branch_id)
LEFT JOIN kf_final_transaction as ft
  USING (branch_id)
```

### 3.  Create Dashboard Performance Analytics Kimia Farma Business Year 2020-2023
![Screenshot 2024-03-30 231026](https://github.com/zahrasm13/PBI_KimiaFarma/assets/165493458/0a016775-cc05-4d5c-8558-26b67410cadc)

