# Stored Procedure: SP_INITIATE_FULFILLMENT_INSTRUCTIONS

## Overview
The `SP_INITIATE_FULFILLMENT_INSTRUCTIONS` stored procedure retrieves all records from the `ORDERS_FULFILLMENT_START_INSTRUCTION` table where the `fulfillment_instructions_type` is set to `'Pending'`. The procedure returns key details about each order fulfillment instruction including:

- `order_id`
- `ship_to_email`
- `ship_to_contact_address_city`
- `shipping_service_code`
- `min_estimate_delivery_date`
- `max_estimated_delivery_date`

This procedure is implemented using Snowflake's JavaScript stored procedure syntax.

## SQL Logic

1. **Select Query:**
   - The procedure constructs a SQL query that selects the required columns from the table `"MY_SCHEMA"."ORDERS_FULFILLMENT_START_INSTRUCTION"`.
   - It filters the records where `fulfillment_instructions_type = 'Pending'`.

2. **Execution:**
   - The SQL statement is executed using Snowflake's `createStatement` and `execute` methods.

3. **Result Set Processing:**
   - The result set is iterated row by row, and each row's values are stored in a JavaScript array as objects.

4. **Output:**
   - The array of results is returned as a VARIANT type, effectively outputting a JSON array of records.

## Parameters
This procedure does not accept any parameters.

## Return Value
The stored procedure returns a VARIANT (JSON array) containing the list of records with the following attributes:

- `order_id`: Identifier for the order.
- `ship_to_email`: Email address used for shipping notifications.
- `ship_to_contact_address_city`: City of the shipping address.
- `shipping_service_code`: Code representing the shipping service.
- `min_estimate_delivery_date`: Earliest estimated delivery date.
- `max_estimated_delivery_date`: Latest estimated delivery date.

## Error Handling
The procedure uses a try/catch block to capture and throw any errors that occur during the execution of the SQL query or the processing of the results.

## Usage
To call the stored procedure:

```sql
CALL MY_SCHEMA.SP_INITIATE_FULFILLMENT_INSTRUCTIONS();
```

## Notes
- Ensure that the schema name (`MY_SCHEMA`) is replaced with the appropriate schema name as needed in your Snowflake environment.
- This stored procedure is read-only and does not modify any data in the database.
