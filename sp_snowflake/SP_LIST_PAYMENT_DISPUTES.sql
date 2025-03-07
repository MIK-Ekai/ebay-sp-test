CREATE OR REPLACE PROCEDURE "schema"."SP_LIST_PAYMENT_DISPUTES"()
RETURNS VARIANT
LANGUAGE JAVASCRIPT
AS
$$
    // Construct the SQL command to fetch payment dispute details
    var sql_command = `SELECT order_id, buyer_username, reason, open_date, status
                       FROM "schema"."PAYMENT_DISPUTE"`;

    // Create a statement object
    var stmt = snowflake.createStatement({sqlText: sql_command});
    var result = stmt.execute();
    var disputes = [];

    // Iterate over the result set and push each record into the disputes array
    while(result.next()){
        disputes.push({
            "order_id": result.getColumnValue(1),
            "buyer_username": result.getColumnValue(2),
            "reason": result.getColumnValue(3),
            "open_date": result.getColumnValue(4),
            "status": result.getColumnValue(5)
        });
    }

    // Return the array of dispute records
    return disputes;
$$;