CREATE OR REPLACE PROCEDURE MY_SCHEMA.SP_INITIATE_FULFILLMENT_INSTRUCTIONS()
  RETURNS VARIANT
  LANGUAGE JAVASCRIPT
  EXECUTE AS CALLER
AS
$$
try {
    // Array to store the result rows
    var results = [];
    
    // Define SQL query to retrieve required fields from ORDERS_FULFILLMENT_START_INSTRUCTION
    var sql_command = `
      SELECT order_id,
             ship_to_email,
             ship_to_contact_address_city,
             shipping_service_code,
             min_estimate_delivery_date,
             max_estimated_delivery_date
      FROM "MY_SCHEMA"."ORDERS_FULFILLMENT_START_INSTRUCTION"
      WHERE fulfillment_instructions_type = 'Pending'
    `;
    
    // Create and execute the statement
    var stmt = snowflake.createStatement({ sqlText: sql_command });
    var rs = stmt.execute();
    
    // Iterate over the result set and build the results array
    while (rs.next()) {
      results.push({
        order_id: rs.getColumnValue(1),
        ship_to_email: rs.getColumnValue(2),
        ship_to_contact_address_city: rs.getColumnValue(3),
        shipping_service_code: rs.getColumnValue(4),
        min_estimate_delivery_date: rs.getColumnValue(5),
        max_estimated_delivery_date: rs.getColumnValue(6)
      });
    }
    
    // Return the results as a variant JSON
    return results;

} catch(err) {
    // In case of error, throw it
    throw 'Error executing SP_INITIATE_FULFILLMENT_INSTRUCTIONS: ' + err;
}
$$;