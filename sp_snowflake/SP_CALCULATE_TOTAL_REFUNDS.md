# Stored Procedure: SP_CALCULATE_TOTAL_REFUNDS

## Description

This stored procedure aggregates the total refund amount for each order. It accomplishes this by summing the `amount_value` field from the `EBAY.ORDERS_LINE_ITEM_REFUND` table and grouping the results by the order identifier (`orders_line_item_order_id`). This procedure is designed to assist in financial reconciliation and refund tracking for orders.

## Schema and Table Reference

- **Schema:** EBAY
- **Table:** ORDERS_LINE_ITEM_REFUND

The procedure relies on the following column from the table:

- `orders_line_item_order_id`: Represents the order identifier associated with each refund record.
- `amount_value`: The monetary value of each refund issued.

## Procedure Signature

```sql
CALL EBAY.SP_CALCULATE_TOTAL_REFUNDS();
```

### Input Parameters

This stored procedure does not require any input parameters.

### Return Value

The procedure returns a result set (as a table) with the following columns:

- **order_id (INT):** The identifier for the order.
- **total_refund_amount (DECIMAL):** The sum of the refund amounts for the corresponding order.

## Implementation Details

- The procedure is written using Snowflake's JavaScript stored procedure syntax.
- It constructs a SQL query that selects and aggregates the refund amounts from the `ORDERS_LINE_ITEM_REFUND` table.
- The SQL query groups rows by the `orders_line_item_order_id`, ensuring the refund totals are calculated per order.
- The procedure returns the result set directly.

## Example Usage

To call the stored procedure and view the results:

```sql
CALL EBAY.SP_CALCULATE_TOTAL_REFUNDS();
```

The result set will look similar to:

| order_id | total_refund_amount |
|----------|---------------------|
| 101      | 45.00               |
| 102      | 30.00               |
| ...      | ...                 |

## Remarks

- Ensure that the user executing this stored procedure has the necessary privileges to access the `EBAY.ORDERS_LINE_ITEM_REFUND` table.
- The procedure is optimized for simplicity and clarity, and can be extended if more complex refund analytics are needed in the future.
