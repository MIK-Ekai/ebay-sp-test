# Stored Procedure: SP_INITIATE_FULFILLMENT_INSTRUCTIONS

## Overview

The `SP_INITIATE_FULFILLMENT_INSTRUCTIONS` stored procedure is designed to retrieve all records from the `ORDERS_FULFILLMENT_START_INSTRUCTION` table in the `EBAY` schema where the `fulfillment_instructions_type` is `'Pending'`. It returns key details such as:

- `order_id`
- `ship_to_email`
- `ship_to_contact_address_city`
- `shipping_service_code`
- `min_estimated_delivery_date` (the minimum estimated delivery date)
- `max_estimated_delivery_date` (the maximum estimated delivery date)

These details help the fulfillment team quickly identify orders that need to be initiated.

## SQL Query Logic

The following SQL query is executed by the procedure:

```sql
SELECT order_id, 
       ship_to_email, 
       ship_to_contact_address_city, 
       shipping_service_code, 
       MIN(estimated_delivery_date) AS min_estimated_delivery_date, 
       MAX(estimated_delivery_date) AS max_estimated_delivery_date
FROM "EBAY"."ORDERS_FULFILLMENT_START_INSTRUCTION"
WHERE fulfillment_instructions_type = 'Pending'
GROUP BY order_id, ship_to_email, ship_to_contact_address_city, shipping_service_code;
```

This query groups the records by order details and calculates the minimum and maximum estimated delivery dates for each group.

## Implementation Details

- **Language:** The procedure is written in JavaScript, following Snowflake's stored procedure syntax.
- **Return Type:** The procedure returns a `VARIANT` data type, which in this case is a JSON array containing the results.
- **Execution Flow:**
  - The stored procedure builds and executes the SQL command.
  - It iterates over the returned `ResultSet`.
  - Each row is collected into an array as a JSON object.
  - The final array is returned as the output of the procedure.

## How to Use

1. **Deploy the Procedure:**
   - Run the SQL script (located at `sp_snowflake/SP_INITIATE_FULFILLMENT_INSTRUCTIONS.sql`) to create or replace the stored procedure in the `EBAY` schema.

2. **Call the Procedure:**
   - Execute the procedure using the following command:
     
   ```sql
   CALL EBAY.SP_INITIATE_FULFILLMENT_INSTRUCTIONS();
   ```

3. **Result:**
   - The procedure returns a JSON array (a VARIANT) containing the pending fulfillment instructions with the required order details.

## Notes

- Ensure that the `ORDERS_FULFILLMENT_START_INSTRUCTION` table exists in the `EBAY` schema and contains the expected columns.
- The procedure includes inline comments to explain each step and uses standard Snowflake syntax for variable declaration and control flow.
