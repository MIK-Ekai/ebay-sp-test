-- Stored Procedure: SP_CALCULATE_TOTAL_REFUNDS
-- Schema: EBAY

CREATE OR REPLACE PROCEDURE EBAY.SP_CALCULATE_TOTAL_REFUNDS()
RETURNS VARIANT
LANGUAGE JAVASCRIPT
EXECUTE AS CALLER
AS
$$
/**
 * This stored procedure aggregates the total refund amount for each order by summing the amount_value
 * in the EBAY.ORDERS_LINE_ITEM_REFUND table. It returns the results as a JSON array (VARIANT) containing
 * objects with order_id and total_refund_amount properties.
 */

// Initialize an array to hold the result rows
var resultArray = [];

// Define the SQL query to aggregate the refund amounts by order_id
var sql_command = `
    SELECT order_id, SUM(amount_value) AS total_refund_amount
    FROM EBAY.ORDERS_LINE_ITEM_REFUND
    GROUP BY order_id;
`;

// Create a statement object using the SQL command
var stmt = snowflake.createStatement({ sqlText: sql_command });

// Execute the SQL statement
var rs = stmt.execute();

// Iterate over the result set and collect each row into the resultArray
while (rs.next()) {
    // Create an object for the current row with order_id and total_refund_amount
    var row = {
        "order_id": rs.getColumnValue(1),
        "total_refund_amount": rs.getColumnValue(2)
    };
    // Push the object into the result array
    resultArray.push(row);
}

// Return the array as a VARIANT (JSON array)
return resultArray;
$$;