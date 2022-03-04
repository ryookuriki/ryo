# The name of this view in Looker is "Order Items"
view: order_items {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: "PUBLIC"."ORDER_ITEMS"
    ;;
  drill_fields: [id]
  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."ID" ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      month_name,
      quarter,
      year,
      week_of_year,
      day_of_week
    ]
    sql: ${TABLE}."CREATED_AT" ;;
  }

  dimension: month {
    type:  string
    sql: ${created_month_name} ;;
  }

  dimension: week_of_year {
    type: string
    sql: cast(${created_week_of_year} as string) ;;
  }

  dimension: day_of_week {
    type: string
    sql: cast(${created_day_of_week} as string) ;;
  }

  dimension_group: delivered {
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
    sql: ${TABLE}."DELIVERED_AT" ;;
  }

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Inventory Item ID" in Explore.

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."INVENTORY_ITEM_ID" ;;
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}."ORDER_ID" ;;
  }

  dimension_group: returned {
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
    sql: ${TABLE}."RETURNED_AT" ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}."SALE_PRICE" ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_sale_price {
    type: sum
    sql: ${sale_price} ;;
  }

  measure: average_sale_price {
    type: average
    sql: ${sale_price} ;;
  }

  dimension_group: shipped {
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
    sql: ${TABLE}."SHIPPED_AT" ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}."STATUS" ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."USER_ID" ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      inventory_items.product_name,
      inventory_items.id,
      users.last_name,
      users.id,
      users.first_name
    ]
  }

  #------------------------------------------

  dimension_group: esc_time {
    label: "Escalation Time:"
    type: time
    description: "The date and time when the ticket was escalated to the Product Specialist"
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."created_at"" ;;
  }


  dimension: esc_time_period {
    type: string
    sql:  {% if date_bucket._parameter_value == 'date' %}
            ${created_date}
         {% elsif date_bucket._parameter_value == 'week' %}
             concat(EXTRACT(YEAR FROM ${created_raw}),"-W",EXTRACT(WEEK(MONDAY) FROM ${created_raw}))
         {% elsif date_bucket._parameter_value == 'month' %}
             concat(FORMAT_DATE('%b', ${created_raw}) ," ",EXTRACT(YEAR FROM ${created_raw}))
         {% elsif date_bucket._parameter_value == 'quarter' %}
             concat(EXTRACT(YEAR FROM ${created_raw})," Q",EXTRACT(QUARTER FROM ${created_raw}))
         {% elsif date_bucket._parameter_value == 'year' %}
             EXTRACT(YEAR FROM ${created_raw})
         {% else %}
             concat(EXTRACT(YEAR FROM ${created_raw}),"-W",EXTRACT(WEEK(MONDAY) FROM ${created_raw}))
         {% endif %}
   ;;
    order_by_field: esc_time_period_order
  }

  dimension: esc_time_period_order {
    hidden: yes
    type: string
    sql:  {% if date_bucket._parameter_value == 'week' %}
           concat(EXTRACT(YEAR FROM ${created_raw}),"-W",EXTRACT(WEEK FROM ${created_raw}))
         {% else %}
           ${created_date}
         {% endif %} ;;
  }

  dimension: esc_time_period_with_week_date {
    label: "Escalation Time Period (Filtered)"
    type: string
    sql:  {% if date_bucket._parameter_value == 'date' %}
            ${created_date}
         {% elsif date_bucket._parameter_value == 'month' %}
             concat(FORMAT_DATE('%b', ${created_raw}) ," ",EXTRACT(YEAR FROM ${created_raw}))
         {% elsif date_bucket._parameter_value == 'quarter' %}
             concat(EXTRACT(YEAR FROM ${created_raw})," Q",EXTRACT(QUARTER FROM ${created_raw}))
         {% elsif date_bucket._parameter_value == 'year' %}
             EXTRACT(YEAR FROM ${created_raw})
         {% else %}
             DATE_TRUNC(${created_raw},WEEK(MONDAY))
         {% endif %}
   ;;
  }

  parameter: date_bucket {
    type: unquoted
    default_value: "week"
    allowed_value: {
      label: "Date"
      value: "date"
    }
    allowed_value: {
      label: "Week"
      value: "week"
    }
    allowed_value: {
      label: "Month"
      value: "month"
    }
    allowed_value: {
      label: "Quarter"
      value: "quarter"
    }
    allowed_value: {
      label: "Year"
      value: "year"
    }
    }

}
