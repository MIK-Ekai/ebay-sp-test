# Stored Procedure: SP_CALCULATE_TOTAL_REFUNDS

## Description
The `SP_CALCULATE_TOTAL_REFUNDS` stored procedure aggregates the total refund amount for each order. It achieves this by summing the `amount_value` column from the `ORDERS_LINE_ITEM_REFUND` table, grouping the results by the `order_id` (which is derived from the `orders_line_item_order_id` field).

## Schema References
- Table: "YOUR_SCHEMA"."ORDERS_LINE_ITEM_REFUND"
  - Columns Used:
    - `orders_line_item_order_id`: References the order associated with the refund.
    - `amount_value`: The monetary value of the refund issued.

## Procedure Details
- **Name**: SP_CALCULATE_TOTAL_REFUNDS
- **Language**: JavaScript (Snowflake Stored Procedure)
- **Return Type**: VARIANT (JSON array of objects)
- **Execution Context**: Executes with the privileges of the caller

## Logic
1. **SQL Query Execution:**
   - The procedure builds an SQL query that selects the `orders_line_item_order_id` as `order_id` and calculates the sum of `amount_value` as `total_refund` from the `ORDERS_LINE_ITEM_REFUND` table.
   - The query groups results by `orders_line_item_order_id` to compile refund totals per order.

2. **Processing Results in JavaScript:**
   - The procedure executes the SQL query using Snowflake's JavaScript API (`snowflake.createStatement`).
   - It iterates over the result set, pushing each record (as an object containing `order_id` and `total_refund`) into an array.

3. **Return Value:**
   - Finally, the procedure returns the array of aggregated results.

## How to Call the Procedure
You can call the procedure using the following SQL command:

```sql
CALL "YOUR_SCHEMA"."SP_CALCULATE_TOTAL_REFUNDS"();
```

The output will be a JSON array where each object represents an order with its aggregated total refund amount. For example:

```json
[
  { "order_id": 1001, "total_refund": 150.00 },
  { "order_id": 1002, "total_refund": 200.00 }
]
```

## Considerations
- **Schema Name:** Ensure that you replace `YOUR_SCHEMA` with your actual schema name if different.
- **Data Types:** The procedure assumes that `amount_value` is stored in a numeric data type that supports aggregation.
- **Error Handling:** This procedure does not include explicit error handling. In production, consider adding try/catch blocks to handle potential errors gracefully.

## Summary
The `SP_CALCULATE_TOTAL_REFUNDS` procedure provides a straightforward aggregation of refund amounts per order, enabling quick reporting on refund data across orders.