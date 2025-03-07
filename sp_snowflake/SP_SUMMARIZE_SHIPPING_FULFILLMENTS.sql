-- Create or replace the stored procedure in the EBAY schema
CREATE OR REPLACE PROCEDURE EBAY.SP_SUMMARIZE_SHIPPING_FULFILLMENTS()
RETURNS VARIANT
LANGUAGE JAVASCRIPT
EXECUTE AS CALLER
AS
$$
  // Initialize an empty JavaScript array to hold the result rows
  var resultArray = [];

  // Define the SQL command that groups shipping fulfillment details by carrier_code
  var sqlCommand = `SELECT carrier_code, 
                           COUNT(*) AS total_shipments, 
                           MIN(shipped_date) AS earliest_shipped_date, 
                           MAX(shipped_date) AS latest_shipped_date 
                    FROM "EBAY"."SHIPPING_FULFILLMENT" 
                    GROUP BY carrier_code`;

  // Create a statement object to execute the SQL command
  var stmt = snowflake.createStatement({sqlText: sqlCommand});

  // Execute the statement and obtain a result set
  var rs = stmt.execute();

  // Iterate over each row in the result set
  while(rs.next()) {
    // For each row, retrieve the column values and store in an object
    var row = {
      carrier_code: rs.getColumnValue(1),
      total_shipments: rs.getColumnValue(2),
      earliest_shipped_date: rs.getColumnValue(3),
      latest_shipped_date: rs.getColumnValue(4)
    };

    // Add the row object to the results array
    resultArray.push(row);
  }

  // Return the result array as a VARIANT (JSON) value
  return resultArray;
$$;