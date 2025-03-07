-- Stored Procedure: SP_CALCULATE_TOTAL_REFUNDS
-- Description: Aggregates the total refund amount for each order by summing the amount_value from the ORDERS_LINE_ITEM_REFUND table.

CREATE OR REPLACE PROCEDURE "YOUR_SCHEMA"."SP_CALCULATE_TOTAL_REFUNDS"()
  RETURNS VARIANT
  LANGUAGE JAVASCRIPT
  EXECUTE AS CALLER
AS
$$
  // Define the SQL command to aggregate total refunds per order
  var sql_command = `
    SELECT orders_line_item_order_id AS order_id,
           SUM(amount_value) AS total_refund
      FROM "YOUR_SCHEMA"."ORDERS_LINE_ITEM_REFUND"
  GROUP BY orders_line_item_order_id
  `;

  // Create and execute the statement
  var stmt = snowflake.createStatement({ sqlText: sql_command });
  var resultSet = stmt.execute();

  // Prepare an array to hold the results
  var results = [];
  while(resultSet.next()) {
    results.push({
      order_id: resultSet.getColumnValue('ORDER_ID'),
      total_refund: resultSet.getColumnValue('TOTAL_REFUND')
    });
  }

  // Return the aggregated results as a VARIANT (JSON array)
  return results;
$$;
