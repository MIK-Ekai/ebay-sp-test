# Stored Procedure: SP_GET_ORDER_HISTORY

## Description

The `SP_GET_ORDER_HISTORY` stored procedure retrieves detailed history for a specified order from the `EBAY.ORDER_HISTORY` table. It is designed to enable customer service or finance teams to review the timeline and key data points of an order.

## Functionality

- Accepts a single parameter `order_id` (integer) representing the unique identifier of the order.
- Fetches buyer information including `BUYER_EMAIL` and `BUYER_FULLNAME`.
- Retrieves the order status (returned as `ORDER_STATUS`), the total order value (as `ORDER_TOTAL`), and the creation date (`CREATION_DATE`).
- Returns the result as a variant containing an array of records. Each record encapsulates the data points mentioned above.

## Usage

To call the stored procedure, execute the following command in Snowflake:

```sql
CALL EBAY.SP_GET_ORDER_HISTORY(<order_id>);
```

Replace `<order_id>` with the actual identifier of the order you wish to query.

## Procedure Implementation

The procedure is implemented using Snowflake's JavaScript API. Here is a summary of the control flow:

1. **Input Parameter:** The procedure accepts the `order_id` parameter.
2. **SQL Statement:** A SQL query is constructed to retrieve columns from `EBAY.ORDER_HISTORY` where the `ID` matches the provided `order_id`.
3. **Execution:** The query is executed with proper parameter binding.
4. **Result Set Processing:** A loop iterates over the result set to build an array of JSON objects where each object contains the buyer email, buyer full name, order status, order total, and creation date.
5. **Error Handling:** If any error occurs during execution, an error message is thrown.

## Example

Calling the stored procedure to get order history for order ID `12345`:

```sql
CALL EBAY.SP_GET_ORDER_HISTORY(12345);
```

This call returns data similar to:

```json
[
  {
    "BUYER_EMAIL": "buyer@example.com",
    "BUYER_FULLNAME": "John Doe",
    "ORDER_STATUS": "Delivered",
    "ORDER_TOTAL": 150.75,
    "CREATION_DATE": "2023-09-15T12:34:56Z"
  }
]
```

## Notes

- The stored procedure uses Snowflake style variables and control flow within a JavaScript block.
- It references the `ORDER_HISTORY` table using the fully-qualified name `"EBAY"."ORDER_HISTORY"`.
- Ensure that you have the necessary permissions to execute stored procedures in the `EBAY` schema.
