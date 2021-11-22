view: inventory_items {
  parameter: date_granularity {
    type: string
    allowed_value: { value: "Day" }
    allowed_value: { value: "Month" }
    allowed_value: { value: "Quarter" }
    allowed_value: { value: "Fiscal Quarter" }
    allowed_value: { value: "Year" }
  }
  sql_table_name: "PUBLIC"."INVENTORY_ITEMS"
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."ID" ;;
  }

  dimension: cost {
    type: number
    sql: ${TABLE}."COST" ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      fiscal_quarter,
      year
    ]
    sql: ${TABLE}."CREATED_AT" ;;
  }

  dimension: dynamic_created_at_date {
    label_from_parameter: date_granularity
    sql:
    CASE
      WHEN {% parameter date_granularity %} = 'Day'
        THEN ${created_date}::VARCHAR
      WHEN {% parameter date_granularity %} = 'Month'
        THEN ${created_month}::VARCHAR
      WHEN {% parameter date_granularity %} = 'Quarter'
        THEN ${created_quarter}::VARCHAR
      WHEN {% parameter date_granularity %} = 'Fiscal Quarter'
        THEN ${created_fiscal_quarter}::VARCHAR
      WHEN {% parameter date_granularity %} = 'Year'
        THEN ${created_year}::VARCHAR
      ELSE NULL
    END ;;
    html:  {% if value == '2017-01' %}
    <font color="goldenrod">FY{{rendered_value}}</font>
    {% else %}
    {{rendered_value}}
    {% endif %}  ;;
  }



  # dimension: dynamic_created_at_date {
  #   label_from_parameter: date_granularity
  #   sql:
  #   {% if date_granularity._parameter_value == 'Day' %}
  #   ${created_date}
  #   {% elsif date_granularity._parameter_value == 'Month' %}
  #   ${created_month}
  #   {% elsif date_granularity._parameter_value == 'Quarter' %}
  #   ${created_quarter}
  #   {% elsif date_granularity._parameter_value == 'Fiscal Quarter' %}
  #   ${created_fiscal_quarter}
  #   {% elsif date_granularity._parameter_value == 'Year' %}
  #   ${created_year}
  #   {% else %}
  #   NULL
  #   {% endif %};;
  # }

  # dimension: dynamic_created_at_date {
  #   label_from_parameter: date_granularity
  #   sql:
  #       {% if date_granularity._parameter_value == 'day' %}
  #         ${created_date}
  #       {% elsif date_granularity._parameter_value == 'month' %}
  #         ${created_month}
  #       {% else %}
  #         ${created_fiscal_quarter}
  #       {% endif %};;
  # }


  dimension: product_brand {
    type: string
    sql: ${TABLE}."PRODUCT_BRAND" ;;
  }

  dimension: product_category {
    type: string
    sql: ${TABLE}."PRODUCT_CATEGORY" ;;
  }

  dimension: product_department {
    type: string
    sql: ${TABLE}."PRODUCT_DEPARTMENT" ;;
  }

  dimension: product_distribution_center_id {
    type: number
    sql: ${TABLE}."PRODUCT_DISTRIBUTION_CENTER_ID" ;;
  }

  dimension: product_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."PRODUCT_ID" ;;
  }

  dimension: product_name {
    type: string
    sql: ${TABLE}."PRODUCT_NAME" ;;
  }

  dimension: product_retail_price {
    type: number
    sql: ${TABLE}."PRODUCT_RETAIL_PRICE" ;;
  }

  dimension: product_sku {
    type: string
    sql: ${TABLE}."PRODUCT_SKU" ;;
  }

  dimension_group: sold {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."SOLD_AT" ;;
  }

  measure: count {
    type: count
    drill_fields: [id, product_name, products.name, products.id, order_items.count]
  }
}
