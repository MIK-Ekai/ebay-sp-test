# Stored Procedure: SP_SUMMARIZE_SHIPPING_FULFILLMENTS

## Description
This stored procedure groups records from the `"schema"."SHIPPING_FULFILLMENT"` table by the `carrier_code` column. For each shipping carrier, it calculates:

- The total number of shipments
- The earliest shipped date
- The latest shipped date

These aggregated statistics help in summarizing the shipping fulfillment performance by carrier.

## Logic
1. A SQL query is executed to group the records in the `"schema"."SHIPPING_FULFILLMENT"` table by `carrier_code`.
2. The COUNT function is used to calculate the total shipments per carrier.
3. The MIN and MAX functions are used to determine the earliest and latest shipment dates respectively.
4. The result is returned as a variant (JSON array of objects) from the procedure.

## Stored Procedure Details

- **Name:** SP_SUMMARIZE_SHIPPING_FULFILLMENTS
- **Language:** JavaScript (Snowflake Stored Procedure)
- **Parameters:** None
- **Return Type:** VARIANT (an array of JSON objects containing the carrier code, total shipments, earliest shipped date, and latest shipped date)

## Table Referenced

- `"schema"."SHIPPING_FULFILLMENT"`
  - **carrier_code:** Code representing the shipping carrier
  - **shipped_date:** Timestamp indicating when the shipment was dispatched

## Usage

To execute the stored procedure, run the following command in Snowflake:

```
CALL SP_SUMMARIZE_SHIPPING_FULFILLMENTS();
```

The output will be a JSON array similar to the following:

```json
[
  {
    "carrier_code": "UPS",
    "total_shipments": 100,
    "earliest_shipped_date": "2023-01-01",
    "latest_shipped_date": "2023-10-15"
  },
  {
    "carrier_code": "DHL",
    "total_shipments": 50,
    "earliest_shipped_date": "2023-02-10",
    "latest_shipped_date": "2023-10-10"
  }
]
```

## Notes

- Ensure that the `shipped_date` field in the `"schema"."SHIPPING_FULFILLMENT"` table is stored in a format that supports MIN and MAX aggregation functions properly (ideally a date or timestamp type).
- The procedure references the table using the Snowflake schema format `"schema"."SHIPPING_FULFILLMENT"`. Replace `schema` with the actual schema name as appropriate in your environment.
