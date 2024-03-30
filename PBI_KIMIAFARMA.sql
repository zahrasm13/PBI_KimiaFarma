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