CREATE OR REPLACE PROCEDURE EBAY.SP_GET_ORDER_HISTORY(order_id INT)
RETURNS VARIANT
LANGUAGE JAVASCRIPT
EXECUTE AS CALLER
AS
$$
try {
  // Define the SQL statement to retrieve order history details
  var sql_command = `
    SELECT 
      BUYER_EMAIL,
      BUYER_FULLNAME,
      ORDER_FULFILLMENT_STATUS AS ORDER_STATUS,
      TOTAL_VALUE AS ORDER_TOTAL,
      CREATION_DATE
    FROM "EBAY"."ORDER_HISTORY"
    WHERE ID = ?
  `;
  
  // Create the statement with parameter binding
  var stmt = snowflake.createStatement({
    sqlText: sql_command,
    binds: [order_id]
  });
  
  // Execute the statement and build the result array
  var result = stmt.execute();
  var results_array = [];
  while(result.next()) {
    results_array.push({
      "BUYER_EMAIL": result.getColumnValue(1),
      "BUYER_FULLNAME": result.getColumnValue(2),
      "ORDER_STATUS": result.getColumnValue(3),
      "ORDER_TOTAL": result.getColumnValue(4),
      "CREATION_DATE": result.getColumnValue(5)
    });
  }
  
  // Return the results as a variant
  return results_array;
} catch(err) {
  // In case of error, raise an exception with the error message
  throw "SP_GET_ORDER_HISTORY failed: " + err.message;
}
$$;