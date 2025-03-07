# Stored Procedure Documentation: SP_LIST_PAYMENT_DISPUTES

## Overview
The `SP_LIST_PAYMENT_DISPUTES` stored procedure is designed to retrieve an overview of all payment disputes from the `EBAY.PAYMENT_DISPUTE` table. It is intended to support the customer service team by providing essential details about disputes raised by buyers.

## Functionality
- **Retrieves Data:** Extracts records from the `EBAY.PAYMENT_DISPUTE` table.
- **Returned Fields:**
  - `order_id`: Identifier of the order associated with the dispute.
  - `buyer_username`: Username of the buyer who initiated the dispute.
  - `dispute_reason`: The reason provided by the buyer for the dispute (aliased from the `reason` column).
  - `open_date`: Timestamp when the dispute was opened.
  - `status`: The current status of the dispute.

## Technical Details
- **Database:** The procedure queries the `EBAY` schema.
- **Stored Procedure Language:** The procedure is written in JavaScript and utilizes Snowflake's stored procedure framework.
- **Return Type:** The stored procedure returns a `VARIANT` containing a JSON array of dispute records.
- **Error Handling:** Any errors during execution will be captured and returned as a JSON object containing an `error` key with the error message.

## Usage
To call this stored procedure from Snowflake, use the following command:

```sql
CALL EBAY.SP_LIST_PAYMENT_DISPUTES();
```

This command will execute the procedure and return the list of payment disputes with the corresponding fields.

## Additional Notes
- **Schema & Table Referencing:** All table references are made using the `"schema"."table"` notation, in this case, `"EBAY"."PAYMENT_DISPUTE"`.
- **Modifications:** If additional fields or logic are required (e.g., filtering or joining with other tables), modifications to the SQL query within the procedure may be necessary.

## Conclusion
The `SP_LIST_PAYMENT_DISPUTES` stored procedure is a simple yet effective tool for retrieving dispute data, intended to provide customer service teams with the information needed to address payment disputes in a timely manner.
