-- Stored Procedure: SP_LIST_PAYMENT_DISPUTES
-- Description: Retrieves details of all payment disputes from the EBAY.PAYMENT_DISPUTE table including order_id, buyer_username, dispute_reason, open_date, and current status.

CREATE OR REPLACE PROCEDURE EBAY.SP_LIST_PAYMENT_DISPUTES()
  RETURNS VARIANT
  LANGUAGE JAVASCRIPT
  EXECUTE AS CALLER
AS
$$
  try {
    // Define the SQL command to retrieve payment dispute details
    var sql_command = `
      SELECT 
        order_id, 
        buyer_username, 
        reason AS dispute_reason, 
        open_date, 
        status 
      FROM "EBAY"."PAYMENT_DISPUTE"
    `;

    // Create a statement object
    var stmt = snowflake.createStatement({ sqlText: sql_command });
    var resultSet = stmt.execute();

    // Collect results into an array
    var results = [];
    while(resultSet.next()) {
      results.push({
        ORDER_ID: resultSet.getColumnValue(1),
        BUYER_USERNAME: resultSet.getColumnValue(2),
        DISPUTE_REASON: resultSet.getColumnValue(3),
        OPEN_DATE: resultSet.getColumnValue(4),
        STATUS: resultSet.getColumnValue(5)
      });
    }

    // Return the results as a VARIANT (JSON array)
    return results;

  } catch(err) {
    // On error, return an error message
    return { "error": err.message };
  }
$$;

-- To execute this stored procedure, use:
-- CALL EBAY.SP_LIST_PAYMENT_DISPUTES();
