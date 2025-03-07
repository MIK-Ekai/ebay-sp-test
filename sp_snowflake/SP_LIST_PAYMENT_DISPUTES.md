# SP_LIST_PAYMENT_DISPUTES Stored Procedure

## Overview
The `SP_LIST_PAYMENT_DISPUTES` stored procedure retrieves details of all payment disputes from the `PAYMENT_DISPUTE` table. It returns a list of dispute records including the following fields:

- **order_id:** Identifier of the order associated with the dispute.
- **buyer_username:** Username of the buyer who raised the dispute.
- **reason:** The reason provided for the payment dispute.
- **open_date:** The timestamp when the dispute was opened.
- **status:** Current status of the payment dispute.

## Usage
This stored procedure does not require any input parameters. It is executed as follows:

```sql
CALL "schema"."SP_LIST_PAYMENT_DISPUTES"();
```

## Return Value
The procedure returns a JSON array (of variant data type) where each element represents a dispute record with the following structure:

```json
{
  "order_id": <number>,
  "buyer_username": <string>,
  "reason": <string>,
  "open_date": <string>,
  "status": <string>
}
```

## Implementation Details
- **Language:** The stored procedure is written in JavaScript (Snowflake's supported language for stored procedures).
- **SQL Query:** The procedure executes a simple SELECT statement against the `"schema"."PAYMENT_DISPUTE"` table to retrieve the required fields.
- **Result Processing:** The result set is iterated over, and each record is stored in a JavaScript array, which is then returned as output.

## Schema References
The procedure references the following table using the Snowflake format "schema"."table":

- PAYMENT_DISPUTE

## Example
After deploying the stored procedure, execute the following command in Snowflake to view all payment disputes:

```sql
CALL "schema"."SP_LIST_PAYMENT_DISPUTES"();
```

The output will be a JSON array of disputes, each containing the order ID, buyer username, dispute reason, open date, and status.

---

*This documentation provides an overview of how the stored procedure works and how to integrate it into your Snowflake environment.*