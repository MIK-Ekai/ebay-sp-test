# Stored Procedure: SP_SUMMARIZE_SHIPPING_FULFILLMENTS

## Overview

This stored procedure, `SP_SUMMARIZE_SHIPPING_FULFILLMENTS`, is created in the `EBAY` schema and is designed to summarize shipping fulfillment details. It groups records by `carrier_code` from the `SHIPPING_FULFILLMENT` table and computes key statistics for each carrier:

- **Total Shipments:** The total number of shipments handled by the carrier.
- **Earliest Shipped Date:** The earliest shipment date from the carrier's records.
- **Latest Shipped Date:** The latest shipment date from the carrier's records.

The results are returned as a VARIANT (JSON array), making it easy to integrate with applications or further processing.

## Procedure Details

- **Schema:** EBAY
- **Procedure Name:** SP_SUMMARIZE_SHIPPING_FULFILLMENTS
- **Return Type:** VARIANT (JSON array of objects)
- **Language:** JavaScript (Snowflake stored procedure syntax)

## Logic

The core SQL query used in the stored procedure is:

```sql
SELECT carrier_code, 
       COUNT(*) AS total_shipments, 
       MIN(shipped_date) AS earliest_shipped_date, 
       MAX(shipped_date) AS latest_shipped_date 
FROM "EBAY"."SHIPPING_FULFILLMENT" 
GROUP BY carrier_code;
```

This query aggregates all shipping fulfillments by carrier and computes the total count as well as the minimum and maximum shipment dates.

## Code Walkthrough

1. **Initialize Result Array:**
   The procedure begins by creating an empty JavaScript array (`resultArray`) to store the results that will be returned.

2. **Define SQL Command:**
   The SQL command, which aggregates the data from `SHIPPING_FULFILLMENT`, is defined as a JavaScript string. Notice how the table is referenced using the format "EBAY"."SHIPPING_FULFILLMENT".

3. **Create and Execute Statement:**
   A Snowflake statement object is created using the SQL command, and it is then executed to obtain a result set.

4. **Process Result Set:**
   The procedure iterates over each row in the result set. For every row, it builds a JavaScript object mapping column values to their respective keys (`carrier_code`, `total_shipments`, `earliest_shipped_date`, and `latest_shipped_date`). Each object is pushed into the `resultArray`.

5. **Return Result:**
   Finally, the procedure returns the constructed `resultArray` as a VARIANT, which is essentially a JSON array.

## How to Execute

To execute this stored procedure in Snowflake, use the following command:

```sql
CALL EBAY.SP_SUMMARIZE_SHIPPING_FULFILLMENTS();
```

The procedure will return a JSON array with the summarized shipment data.

## Inline Code Comments

The stored procedure code contains inline comments that explain each major step, ensuring the procedure's logic is clear and maintainable.
