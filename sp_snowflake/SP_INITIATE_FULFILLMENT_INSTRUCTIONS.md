# SP_INITIATE_FULFILLMENT_INSTRUCTIONS Stored Procedure Documentation

## Overview

The `SP_INITIATE_FULFILLMENT_INSTRUCTIONS` stored procedure is designed to assist the fulfillment team by retrieving pending order fulfillment instructions. It filters records in the `ORDERS_FULFILLMENT_START_INSTRUCTION` table (located in the `EBAY` schema) where the `fulfillment_instructions_type` is set to `'Pending'`. The retrieved details include key information required to initiate fulfillment.

## Functionality

- **Data Retrieval:**
  - Fetches records based on the condition that the `fulfillment_instructions_type` equals `'Pending'`.
  
- **Retrieved Columns:**
  - `order_id`: Identifier for the order.
  - `ship_to_email`: Recipient email address for shipping notifications.
  - `ship_to_contact_address_city`: The shipping address city.
  - `shipping_service_code`: Represents the shipping service used (e.g., USPS_PRIORITY, FEDEX_OVERNIGHT).
  - `min_estimate_delivery_date`: Earliest estimated delivery date for the order.
  - `max_estimated_delivery_date`: Latest estimated delivery date for the order.

## Usage

To call the stored procedure, execute the following command in Snowflake:

```sql
CALL SP_INITIATE_FULFILLMENT_INSTRUCTIONS();
```

The procedure returns a VARIANT (JSON array) containing the records that match the specified criteria. Each record in the result set is a JSON object with the key details outlined above.

## Implementation Details

- **Language:** JavaScript (Snowflake Stored Procedure)
- **Execution Context:** Executes with the privileges of the caller (`EXECUTE AS CALLER`).
- **Error Handling:** If any error occurs during execution, the procedure returns a JSON object with an `error` property containing the error message.

## Code Explanation

1. **SQL Command Definition:**
   - The SELECT query retrieves data from `"EBAY"."ORDERS_FULFILLMENT_START_INSTRUCTION"`, filtering for records with `fulfillment_instructions_type = 'Pending'`.

2. **Statement Execution:**
   - The SQL command is executed using Snowflake's `createStatement` and `execute` methods.

3. **Result Processing:**
   - The result set is iterated over, and each row is pushed into an array as a JSON object.

4. **Return Value:**
   - The procedure returns the collected array of objects as a VARIANT. In case of an error, a JSON object with an `error` key is returned.

## Schema Reference

The procedure references the following table in the `EBAY` schema:

- `ORDERS_FULFILLMENT_START_INSTRUCTION`:
  - Contains fulfillment instructions with estimated delivery dates and shipping details.

This stored procedure is designed to facilitate the rapid identification of pending orders requiring fulfillment actions.
