# SP_LIST_PAYMENT_DISPUTES Stored Procedure Documentation

## Overview

The `SP_LIST_PAYMENT_DISPUTES` stored procedure retrieves details of all payment disputes from the `PAYMENT_DISPUTE` table located in the `EBAY` schema. It selects the following columns:

- **order_id**: Identifier for the associated order.
- **buyer_username**: Username of the buyer who raised the dispute.
- **dispute_reason**: Reason provided by the buyer for the dispute.
- **open_date**: Date when the dispute was opened.
- **status**: Current status of the dispute.

This procedure is designed to provide the customer service team with an overview of disputes that require attention.

## Procedure Details

- **Name**: SP_LIST_PAYMENT_DISPUTES
- **Schema**: EBAY
- **Language**: JavaScript (Snowflake Stored Procedure)
- **Return Type**: VARIANT (JSON array)

## How It Works

1. **Initialization**: An empty JavaScript array (`resultArray`) is created to store the rows fetched from the query.

2. **SQL Statement Creation**: A SQL command is defined to select the required columns from the `PAYMENT_DISPUTE` table.

3. **Execution**: The SQL command is executed via a Snowflake statement object. The ResultSet is iterated row-by-row.

4. **Row Processing**: For each row in the ResultSet, a JSON object is built with keys corresponding to the selected columns. The object is then appended to `resultArray`.

5. **Error Handling**: In case an error occurs during execution, the procedure catches the exception and returns a JSON object containing the error message.

6. **Return**: Finally, the procedure returns the `resultArray` as a VARIANT, which is effectively a JSON array of dispute records.

## Usage

To execute the stored procedure, run the following command in Snowflake:

```sql
CALL EBAY.SP_LIST_PAYMENT_DISPUTES();
```

The output will be a JSON array where each element contains the details of a payment dispute.

## Inline Comments

The stored procedure code includes inline comments that explain each step, from SQL command creation and execution to error handling and returning the final result.
