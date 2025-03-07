# Stored Procedure: SP_GET_ORDER_HISTORY

## Description

The `SP_GET_ORDER_HISTORY` stored procedure retrieves detailed history data for a specified order from the `ORDER_HISTORY` table. The information returned includes buyer details (email and full name), order fulfillment status, total order value, and the order creation date. This procedure is useful for quickly fetching comprehensive order history information based on the order identifier.

## Parameters

- **order_id (INT)**: The unique identifier for the order whose history is to be retrieved.

## Returns

- A JSON array (VARIANT) where each element is an object containing the following keys:
  - **BUYER_EMAIL**: The email address of the buyer.
  - **BUYER_FULLNAME**: The full name of the buyer.
  - **ORDER_FULFILLMENT_STATUS**: The current fulfillment status of the order.
  - **TOTAL_VALUE**: The total monetary value of the order.
  - **CREATION_DATE**: The date and time when the order was created.

## Usage

To call the stored procedure, execute the following command in Snowflake:

```sql
CALL "schema"."SP_GET_ORDER_HISTORY"(12345);
```

Replace `12345` with the actual order ID you wish to query.

## Implementation Details

- The procedure is implemented in JavaScript using Snowflake's stored procedure syntax.
- It utilizes a bind variable to safely pass the `order_id` parameter to the SQL query.
- The result set is iterated, converting each row into a JavaScript object, and the final collection of objects is returned as a variant.
- All table references are fully qualified with the schema name using the format "schema"."ORDER_HISTORY".

## Note

Be sure to change the schema name if your database structure uses a different schema than the one specified.
