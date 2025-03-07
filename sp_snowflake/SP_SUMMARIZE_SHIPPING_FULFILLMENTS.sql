CREATE OR REPLACE PROCEDURE "EBAY"."SP_SUMMARIZE_SHIPPING_FULFILLMENTS"()
  RETURNS VARIANT
  LANGUAGE JAVASCRIPT
  EXECUTE AS CALLER
AS
$$
  // SQL query to aggregate shipping fulfillment details by carrier_code
  var sql_command = `
    SELECT 
      carrier_code,
      COUNT(*) AS total_shipments,
      MIN(shipped_date) AS earliest_shipped_date,
      MAX(shipped_date) AS latest_shipped_date
    FROM "EBAY"."SHIPPING_FULFILLMENT"
    GROUP BY carrier_code
    ORDER BY carrier_code;
  `;

  // Create and execute the statement
  var stmt = snowflake.createStatement({ sqlText: sql_command });
  var resultSet = stmt.execute();

  // Create an array to hold the results
  var results = [];

  // Iterate over the result set and build the results array
  while(resultSet.next()) {
    results.push({
      carrier_code: resultSet.getColumnValue('CARRIER_CODE'),
      total_shipments: resultSet.getColumnValue('TOTAL_SHIPMENTS'),
      earliest_shipped_date: resultSet.getColumnValue('EARLIEST_SHIPPED_DATE'),
      latest_shipped_date: resultSet.getColumnValue('LATEST_SHIPPED_DATE')
    });
  }

  // Return the aggregated results as a variant (JSON array)
  return results;
$$;