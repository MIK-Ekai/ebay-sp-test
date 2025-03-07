-- Stored Procedure: SP_SUMMARIZE_SHIPPING_FULFILLMENTS
-- Description: This stored procedure groups shipping fulfillment details from the SHIPPING_FULFILLMENT table by carrier_code. For each carrier, it computes the total number of shipments, the earliest shipped date, and the latest shipped date.

CREATE OR REPLACE PROCEDURE SP_SUMMARIZE_SHIPPING_FULFILLMENTS()
  RETURNS VARIANT
  LANGUAGE JAVASCRIPT
  EXECUTE AS CALLER
AS
$$
  // Initialize an array to store the aggregated results
  var results = [];

  // SQL command to aggregate shipping fulfillment data
  var sql_command = `
    SELECT carrier_code,
           COUNT(*) AS total_shipments,
           MIN(shipped_date) AS earliest_shipped_date,
           MAX(shipped_date) AS latest_shipped_date
    FROM "schema"."SHIPPING_FULFILLMENT"
    GROUP BY carrier_code
    ORDER BY carrier_code
  `;

  // Create and execute the statement
  var stmt = snowflake.createStatement({sqlText: sql_command});
  var rs = stmt.execute();

  // Iterate through the result set and populate the results array
  while (rs.next()) {
    results.push({
      carrier_code: rs.getColumnValue(1),
      total_shipments: rs.getColumnValue(2),
      earliest_shipped_date: rs.getColumnValue(3),
      latest_shipped_date: rs.getColumnValue(4)
    });
  }

  // Return the results as a variant
  return results;
$$;

-- Example call:
-- CALL SP_SUMMARIZE_SHIPPING_FULFILLMENTS();
