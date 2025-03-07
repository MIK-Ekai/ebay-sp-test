-- Create or replace the stored procedure in the EBAY schema
CREATE OR REPLACE PROCEDURE EBAY.SP_LIST_PAYMENT_DISPUTES()
RETURNS VARIANT
LANGUAGE JAVASCRIPT
EXECUTE AS CALLER
AS
$$
// Initialize an empty array to hold the result rows
var resultArray = [];

try {
  // Define the SQL command to retrieve payment dispute details
  var sql_command = 'SELECT order_id, buyer_username, dispute_reason, open_date, status FROM "EBAY"."PAYMENT_DISPUTE"';

  // Create a Snowflake statement object
  var stmt = snowflake.createStatement({ sqlText: sql_command });

  // Execute the statement and obtain a ResultSet
  var rs = stmt.execute();

  // Iterate over each row in the ResultSet
  while(rs.next()) {
    // Construct a JSON object for the current row
    var row = {
      order_id: rs.getColumnValue(1),
      buyer_username: rs.getColumnValue(2),
      dispute_reason: rs.getColumnValue(3),
      open_date: rs.getColumnValue(4),
      status: rs.getColumnValue(5)
    };

    // Append the row object to the result array
    resultArray.push(row);
  }
} catch(err) {
  // In case of an error, return a JSON object with the error message
  return { "error": err.message };
}

// Return the collected result set as a VARIANT (JSON array)
return resultArray;
$$;
