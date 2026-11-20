MEDICAL DEPOT INVENTORY ANALYSIS — PRACTICE DATA
==================================================

All records are fictional and for learning only. They are not real clinical,
supplier, procurement, or patient records. Do not use them for actual medicine
procurement or treatment decisions.

FILES
-----
medicines.csv
  Medicine lookup table. Primary key: medicine_id.

suppliers.csv
  Supplier lookup table. Primary key: supplier_id.

inventory.csv
  Current stock snapshot. medicine_id links to medicines.csv;
  supplier_id links to suppliers.csv.

stock_movements.csv
  Stock receipt/issue transactions for August–October 2026.
  movement_type is RECEIPT or ISSUE.

purchase_orders.csv
  Purchase-order records, including status, quantities and costs in ZAR.
  Blank delivery_date means the order has not been delivered yet.

SUGGESTED PRACTICE
------------------
1. Import all CSV files into MySQL and create primary/foreign keys.
2. JOIN medicines, inventory and suppliers.
3. Find low-stock medicines (quantity <= reorder_level).
4. Find medicines expiring within 30, 60 and 90 days.
5. Analyse stock movements by medicine, month and movement_type.
6. Analyse supplier order values, delayed orders and pending orders.
7. Load CSV or SQL query results into Python/Pandas for cleaning and analysis.
8. Export a validated analysis workbook for Excel.
9. Build a Power BI dashboard with stock, expiry and supplier KPIs.

DATE NOTE
---------
The sample analysis reference date used in the accompanying example is
2026-11-05. If practising on another date, update the reference date in your
calculations. The inventory snapshot and transaction history are simplified
training data and are not intended to reconcile perfectly.
