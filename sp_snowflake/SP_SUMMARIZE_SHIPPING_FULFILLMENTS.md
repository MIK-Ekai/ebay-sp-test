# Stored Procedure: SP_SUMMARIZE_SHIPPING_FULFILLMENTS

## Description
The `SP_SUMMARIZE_SHIPPING_FULFILLMENTS` stored procedure aggregates shipping fulfillment data from the `EBAY.SHIPPING_FULFILLMENT` table. It groups the records by the `carrier_code` and returns, for each carrier, the total number of shipments along with basic statistical information including the earliest and latest shipment dates.

This procedure provides logistics teams with performance insights for each shipping carrier, enabling them to monitor and optimize shipping operations.

## Schema References
- Database Schema: `EBAY`
- Table: `EBAY.SHIPPING_FULFILLMENT`

## Procedure Details
- **Name:** SP_SUMMARIZE_SHIPPING_FULFILLMENTS
- **Language:** JavaScript (Snowflake Stored Procedure)
- **Returns:** VARIANT (JSON array of records)
- **Execution Context:** CALLER

## Parameters
This stored procedure does not accept any parameters.

## SQL Logic
The stored procedure executes the following steps:

1. Constructs a SQL query to group records by `carrier_code` from the `EBAY.SHIPPING_FULFILLMENT` table.
2. Aggregates the data to compute:
   - **Total Shipments:** Count of shipments for each carrier.
   - **Earliest Shipped Date:** The minimum `shipped_date` for each carrier.
   - **Latest Shipped Date:** The maximum `shipped_date` for each carrier.
3. Executes the query using Snowflake's JavaScript API.
4. Iterates over the result set to build an array of JSON objects.
5. Returns the results as a JSON array (i.e., a VARIANT data type).

## Example Returned Result
```json
[
  {
    "carrier_code": "UPS",
    "total_shipments": 150,
    "earliest_shipped_date": "2023-01-05",
    "latest_shipped_date": "2023-07-20"
  },
  {
    "carrier_code": "FedEx",
    "total_shipments": 200,
    "earliest_shipped_date": "2023-02-10",
    "latest_shipped_date": "2023-07-19"
  }
]
```

## Usage
To execute the stored procedure, use the following command in Snowflake:

```sql
CALL "EBAY"."SP_SUMMARIZE_SHIPPING_FULFILLMENTS"();
```

This will return a JSON array with aggregated shipping fulfillment data per carrier.

## Notes
- Ensure that you have the correct privileges to execute procedures within the `EBAY` schema.
- The stored procedure uses JavaScript and Snowflake's API for statement execution and result processing.
- The results are returned as a VARIANT, which can be further parsed or processed within your application.