-- Create or replace the stored procedure in the EBAY schema
CREATE OR REPLACE PROCEDURE EBAY.SP_INITIATE_FULFILLMENT_INSTRUCTIONS()
RETURNS VARIANT
LANGUAGE JAVASCRIPT
AS
$$
  // Initialize an empty array to hold the result rows
  var results = [];

  try {
    // Define the SQL query to retrieve pending fulfillment instructions
    var sql_command = `
      SELECT order_id, 
             ship_to_email, 
             ship_to_contact_address_city, 
             shipping_service_code, 
             MIN(estimated_delivery_date) AS min_estimated_delivery_date, 
             MAX(estimated_delivery_date) AS max_estimated_delivery_date
      FROM "EBAY"."ORDERS_FULFILLMENT_START_INSTRUCTION"
      WHERE fulfillment_instructions_type = 'Pending'
      GROUP BY order_id, ship_to_email, ship_to_contact_address_city, shipping_service_code
    `;

    // Create a statement object using the SQL query
    var stmt = snowflake.createStatement({ sqlText: sql_command });

    // Execute the SQL query and store the result set
    var rs = stmt.execute();

    // Iterate over each row in the result set
    while (rs.next()) {
      // Build an object for each row with the required columns and push it to the results array
      results.push({
        order_id: rs.getColumnValue('ORDER_ID'),
        ship_to_email: rs.getColumnValue('SHIP_TO_EMAIL'),
        ship_to_contact_address_city: rs.getColumnValue('SHIP_TO_CONTACT_ADDRESS_CITY'),
        shipping_service_code: rs.getColumnValue('SHIPPING_SERVICE_CODE'),
        min_estimated_delivery_date: rs.getColumnValue('MIN_ESTIMATED_DELIVERY_DATE'),
        max_estimated_delivery_date: rs.getColumnValue('MAX_ESTIMATED_DELIVERY_DATE')
      });
    }

    // Return the results array as a VARIANT (JSON array)
    return results;

  } catch (err) {
    // If any errors occur, throw an error with additional information
    throw 'Failed to execute SP_INITIATE_FULFILLMENT_INSTRUCTIONS: ' + err;
  }
$$;
