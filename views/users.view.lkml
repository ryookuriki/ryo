# The name of this view in Looker is "Users"
view: users {

  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: "PUBLIC"."USERS"
    ;;
  drill_fields: [id]


  parameter: test_filter {
    type: unquoted
    allowed_value: {
      label: "United States"
      value: "USA"
    }
    allowed_value: {
      label: "United Kingdom"
      value: "UK"
    }
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}."COUNTRY" ;;
    # link: {
    #   label: "URL"
    #   url: "https://dcl.dev.looker.com/dashboards/2063?Country={{ _filters['users.test_filter'] | url_encode }}"
    # }
  }

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."ID" ;;
  }

  dimension: age {
    type: number
    sql: ${TABLE}."AGE" ;;
  }

  dimension: id_multiply_age {
    type: number
    sql: ${id}*${age} ;;
    drill_fields: [id]
  }

  measure: total_age {
    type: sum
    sql: ${age} ;;
  }

  measure: average_age {
    type: average
    value_format: "0.00"
    sql: ${age};;
  }


  dimension: city {
    type: string
    sql: ${TABLE}."CITY" ;;
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
      year
    ]
    sql: ${TABLE}."CREATED_AT" ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}."EMAIL" ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}."FIRST_NAME" ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}."GENDER" ;;
  }

  dimension: male {
    label: "male"
    type: yesno
    sql: ${gender} = 'Male' ;;
  }

  dimension: USA {
    type: yesno
    sql: ${country} = 'USA' ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}."LAST_NAME" ;;
  }

  dimension: latitude {
    type: number
    sql: ${TABLE}."LATITUDE" ;;
  }

  dimension: longitude {
    type: number
    sql: ${TABLE}."LONGITUDE" ;;
  }

  dimension: states {
    type: string
    sql: ${TABLE}."STATE" ;;
  }

  filter:  state_filter {
    type: string
     ## sql: {% condition state %} users.state {% endcondition %} ;;
    }

  dimension: traffic_source {
    type: string
    sql: ${TABLE}."TRAFFIC_SOURCE" ;;
  }

  dimension: zip {
    type: zipcode
    sql: ${TABLE}."ZIP" ;;
  }

  measure: count {
    type: count
    drill_fields: [id, first_name, events.count, order_items.count]
  }
}
