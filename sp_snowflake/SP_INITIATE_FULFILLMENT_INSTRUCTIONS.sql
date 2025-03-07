CREATE OR REPLACE PROCEDURE SP_INITIATE_FULFILLMENT_INSTRUCTIONS()
  RETURNS VARIANT
  LANGUAGE JAVASCRIPT
  EXECUTE AS CALLER
AS
$$

try {
  // Define the SQL command to retrieve pending fulfillment instructions
  var sql_command = `
    SELECT
      order_id,
      ship_to_email,
      ship_to_contact_address_city,
      shipping_service_code,
      min_estimate_delivery_date,
      max_estimated_delivery_date
    FROM "EBAY"."ORDERS_FULFILLMENT_START_INSTRUCTION"
    WHERE fulfillment_instructions_type = 'Pending'
  `;

  // Create and execute the statement
  var stmt = snowflake.createStatement({ sqlText: sql_command });
  var rs = stmt.execute();

  // Process the result set
  var results = [];
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

  // Return the array of results as a VARIANT
  return results;

} catch(err) {
  // In case of error, return the error message
  return { "error": err.message };
}

$$;