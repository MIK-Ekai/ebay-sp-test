CREATE OR REPLACE PROCEDURE EBAY.SP_CALCULATE_TOTAL_REFUNDS()
RETURNS TABLE (order_id INT, total_refund_amount DECIMAL)
LANGUAGE JAVASCRIPT
EXECUTE AS CALLER
AS
$$
    // This stored procedure aggregates the total refund amount per order by summing the amount_value from the EBAY.ORDERS_LINE_ITEM_REFUND table
    // and grouping by orders_line_item_order_id, which represents the order identifier.
    var sql_command = "SELECT orders_line_item_order_id AS order_id, SUM(amount_value) AS total_refund_amount " +
                      "FROM EBAY.ORDERS_LINE_ITEM_REFUND " +
                      "GROUP BY orders_line_item_order_id";
    var stmt = snowflake.createStatement({ sqlText: sql_command });
    return stmt.execute();
$$;