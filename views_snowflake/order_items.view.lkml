view: order_items {
  sql_table_name: "PUBLIC"."ORDER_ITEMS"
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."ID" ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      day_of_week,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."CREATED_AT" ;;
    html:  {% if value == 'Saturday' %}
          <font color="blue"> {{ created_date._value }} </font>
          {% elsif value == 'Sunday' %}
          <font color="red"> {{ created_date._value }} </font>
          {% else %}
          {{ created_date._value }}
          {% endif %};;
  }

  dimension: days_in_filter {
    ##hidden: yes
    type: number
    sql: TO_NUMBER(DATEDIFF(day, {% date_start created_date %},{% date_end created_date %})) ;;
  }


  dimension: dynamic_date {
    label:
    "{% if days_in_filter._value <= '1' %}
    Hour
    {% else %}
    Month
    {%endif%}"
    sql: ${created_date} ;;
  }



  # dimension: dynamic_date {
  #   label:
  #   "{% if days_in_filter._value <= '1' %}
  #   Hour
  #   {% elsif days_in_filter._value < '32' %}
  #   Date
  #   {% elsif days_in_filter._value < '90' %}
  #   Week
  #   {% else %}
  #   Month
  #   {%endif%}"
  #   sql: ${created_date} ;;
  # }

  # dimension: dynamic_date {
  #   type: string
  #   sql:
  #   {% if days_in_filter._value <= '1' %}
  #   'Hour'
  #   {% else %}
  #   'Month'
  #   {%endif%};;
  # }

  # colors the name of week
  # dimension_group: created {
  #   type: time
  #   timeframes: [
  #     raw,
  #     time,
  #     date,
  #     day_of_week,
  #     week,
  #     month,
  #     quarter,
  #     year
  #   ]
  #   sql: ${TABLE}."CREATED_AT" ;;
  #   html:  {% if value == 'Saturday' %}
  #         <font color="blue"> {{ value }} </font>
  #         {% elsif value == 'Sunday' %}
  #         <font color="red"> {{ value }} </font>
  #         {% else %}
  #         {{ value }}
  #         {% endif %};;
  # }

  measure: most_recent_order {
    type: date
    sql: max(${created_date}) ;;
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


dimension_group: order_ship_diff {
  type: duration
  intervals: [
    hour,
    day,
    week
    ]
  sql_start: ${created_raw};;
  sql_end: ${shipped_raw} ;;
}

  dimension_group: ship_deliv_diff {
    type: duration
    intervals: [
      hour,
      day,
      week
    ]
    sql_start: ${shipped_raw};;
    sql_end: ${delivered_raw} ;;
  }

  dimension_group: ship_deliv_diff2 {
    type: duration
    intervals: [
      hour,
      day,
      week
    ]
    sql_start: ${shipped_date};;
    sql_end: ${delivered_date} ;;
  }

  dimension_group: duration {
    type: duration
    sql_start: ${shipped_date} ;;
    sql_end: ${delivered_date} ;;
    timeframes: [minute, hour, date, week, time]
  }

  dimension_group: current_date {
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
    sql: current_date ;;
  }

  dimension_group: current_date_tc {
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
    sql: convert_timezone('America/Los_Angeles', 'America/New_York', current_date) ;;
  }



dimension_group: since_purchase {
  type: duration
  intervals: [
    hour,
    day,
    week
  ]
  sql_start: ${created_raw} ;;
  sql_end: current_date ;;
}

  dimension: long_time {
    type: yesno
    description: "Yes means arrival took more than 4 days from shipment"
    sql: ${days_ship_deliv_diff} > 4;;
  }


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

  measure: sale_price {
    type: sum
    sql: ${TABLE}."SALE_PRICE" ;;
  }

  measure: sale_prices {
    type: sum
    sql: ${TABLE}."SALE_PRICE" ;;
  }

  measure: discounted_sale_price {
    type: number
    sql: ${sale_price} * 0.8 ;;
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
    html: {% if value == 1 %}
          <font color="blue"> {{ 1 }} </font>
          {% elsif value == 2 %}
          <font color="red"> {{ 2 }} </font>
          {% else %}
          {{ value }}
          {% endif %};;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: first_purchase_date {
    type: date
    sql: min ${created_date} ;;
  }

  measure: last_purchase_date {
    type: date
    sql: max ${created_date} ;;
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
}
