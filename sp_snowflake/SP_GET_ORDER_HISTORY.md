# Stored Procedure Documentation

## Procedure Name
**SP_GET_ORDER_HISTORY**

## Schema
**EBAY**

## Description
This stored procedure accepts an `order_id` as an input parameter and retrieves detailed history for that order from the `ORDER_HISTORY` table. The returned information includes the buyer’s email, buyer’s full name, order status, total order value, and the creation date. This data provides a quick review of an order's timeline and key data points.

## Parameters
- **order_id (NUMBER):** The identifier of the order whose history is to be retrieved.

## Return Value
- The procedure returns a VARIANT (JSON array) containing objects where each object represents a row with the following fields:
  - `order_id`: Order identifier
  - `BUYER_EMAIL`: Customer's email address
  - `BUYER_FULLNAME`: Customer's full name
  - `order_status`: Current status of the order
  - `TOTAL_VALUE`: Total monetary value of the order
  - `creation_date`: Date and time when the order was created

## Implementation Details
1. **Initialization:** An empty JavaScript array `results` is created to store each retrieved row as a JSON object.

2. **SQL Query:** A SQL SELECT statement is constructed using a bind parameter (`:1`) for the `order_id`. The query retrieves the necessary columns from `EBAY.ORDER_HISTORY`.

3. **Statement Execution:** The SQL command is executed using Snowflake's `snowflake.createStatement` method, with the provided order_id bound to the query.

4. **ResultSet Iteration:** The procedure iterates over the ResultSet using a `while` loop. For each row, a JSON object is created and appended to the `results` array.

5. **Return:** Finally, the procedure returns the `results` array, which is a JSON array containing all rows that match the specified order_id.

## Example Usage
```sql
CALL EBAY.SP_GET_ORDER_HISTORY(12345);
```

This call will return a JSON array with the detailed history of the order with identifier `12345`.
