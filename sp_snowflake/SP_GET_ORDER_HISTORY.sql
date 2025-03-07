-- Stored Procedure: SP_GET_ORDER_HISTORY
-- Description: Retrieves detailed history for a specified order from the ORDER_HISTORY table including buyer information (BUYER_EMAIL, BUYER_FULLNAME), order fulfillment status, total order value, and creation date.

CREATE OR REPLACE PROCEDURE "schema"."SP_GET_ORDER_HISTORY"(order_id INT)
RETURNS VARIANT
LANGUAGE JAVASCRIPT
EXECUTE AS CALLER
AS
$$
    // Construct the SQL query to retrieve order history details for the given order_id
    var sql_command = `
        SELECT
            BUYER_EMAIL,
            BUYER_FULLNAME,
            ORDER_FULFILLMENT_STATUS,
            TOTAL_VALUE,
            CREATION_DATE
        FROM "schema"."ORDER_HISTORY"
        WHERE ID = :1
    `;

    // Create the statement with a bind variable
    var stmt = snowflake.createStatement({
        sqlText: sql_command,
        binds: [order_id]
    });

    // Execute the statement
    var resultSet = stmt.execute();
    var resultArray = [];

    // Iterate through the result set and push each record as a JavaScript object
    while (resultSet.next()) {
        resultArray.push({
            BUYER_EMAIL: resultSet.getColumnValue(1),
            BUYER_FULLNAME: resultSet.getColumnValue(2),
            ORDER_FULFILLMENT_STATUS: resultSet.getColumnValue(3),
            TOTAL_VALUE: resultSet.getColumnValue(4),
            CREATION_DATE: resultSet.getColumnValue(5)
        });
    }

    // Return the array of results as a variant
    return resultArray;
$$;