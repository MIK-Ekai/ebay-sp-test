-- Stored Procedure: SP_GET_ORDER_HISTORY
-- Schema: EBAY
-- Description: This stored procedure accepts an order ID as a parameter and retrieves detailed history for that order from the EBAY.ORDER_HISTORY table. 
-- It returns a VARIANT (JSON array) containing buyer email, buyer full name, order status, total order value, and creation date.

CREATE OR REPLACE PROCEDURE EBAY.SP_GET_ORDER_HISTORY(order_id NUMBER)
RETURNS VARIANT
LANGUAGE JAVASCRIPT
AS
$$
  // Initialize an empty array to hold the result rows
  var results = [];

  // Define the SQL query with a bind parameter for order_id
  var sql_command = `
    SELECT order_id, BUYER_EMAIL, BUYER_FULLNAME, order_status, TOTAL_VALUE, creation_date
    FROM EBAY.ORDER_HISTORY
    WHERE order_id = :1
  `;

  // Prepare the SQL statement with the bind parameter
  var stmt = snowflake.createStatement({
    sqlText: sql_command,
    binds: [order_id]
  });

  // Execute the statement and obtain the result set
  var rs = stmt.execute();

  // Iterate through the result set
  while (rs.next()) {
    // Create a JSON object for each row with relevant columns
    var row = {
      "order_id": rs.getColumnValue(1),
      "BUYER_EMAIL": rs.getColumnValue(2),
      "BUYER_FULLNAME": rs.getColumnValue(3),
      "order_status": rs.getColumnValue(4),
      "TOTAL_VALUE": rs.getColumnValue(5),
      "creation_date": rs.getColumnValue(6)
    };
    // Add the row object to the results array
    results.push(row);
  }

  // Return the results array as a VARIANT (JSON array)
  return results;
$$;
