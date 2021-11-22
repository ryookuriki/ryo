view: users {
  suggestions: no
  sql_table_name: "PUBLIC"."USERS"
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."ID" ;;
  }

  dimension: age {
    type: number
    sql: ${TABLE}."AGE" ;;
  }
###################

  measure: max_age {
    type: number
    sql: max ${age} ;;
  }

  measure: max_age2 {
    type: max
    sql:${age} ;;
  }

  measure: max_ages {
    type: string
    sql:concat(${max_age}, 'years old') ;;
  }
  ##################

  dimension: tier_age {
    type: tier
    tiers: [10,20,30,40,50,60,70]
    style:integer
    sql:${age};;
  }

  dimension: city {
    type: string
    sql: ${TABLE}."CITY" ;;
  }

  dimension: country {
    type: string
    suggestions: ["USA"]
    map_layer_name: countries
    sql: ${TABLE}."COUNTRY" ;;
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

  dimension: state {
    type: string
    sql: ${TABLE}."STATE" ;;
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
    drill_fields: [id, last_name, first_name, events.count, order_items.count]
  }

  measure: count_dist {
    type: count_distinct
    drill_fields: [id, last_name, first_name, events.count, order_items.count]
  }

  measure: count_USA_users {
    type: count_distinct
    sql:  ${id} ;;
    drill_fields: [id, users.id, users.first_name, users.last_name, order_items.count]
    filters: {
      field: country
      value: "USA"
    }
    }

  measure: percent_USA_users {
    type: number
    sql: ${count_USA_users}/${count} ;;
    value_format: "0.00"
  }

}
