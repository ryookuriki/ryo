include: "/views_snowflake/inventory_items.view"
explore:  inventory_items2 {}
view: inventory_items2 {
  derived_table: {
    sql: select
          CREATED_AT,
          SOLD_AT,
          count(SOLD_AT) as ticket_sold_count,
          count(CREATED_AT) as ticket_created_count
          from inventory_items
          group by 1, 2
            ;;
  }

  dimension: CREATED_AT {
    type: date
    sql: ${TABLE}.CREATED_AT ;;
  }

  dimension: ticket_created_count {
    type: number
    sql: ${TABLE}.ticket_created_count ;;
  }

  dimension: SOLD_AT {
    type: date
    sql: ${TABLE}.SOLD_AT ;;
  }

  dimension: ticket_sold_count {
    type: number
    sql: ${TABLE}.ticket_sold_count ;;
  }
}




view: inventory_items2_2 {
  derived_table: {
    sql: select
          SOLD_AT,
          count(SOLD_AT) as ticket_sold_count
          from inventory_items
          group by 1
            ;;
  }

  dimension: SOLD_AT {
    type: date
    sql: ${TABLE}.SOLD_AT ;;
  }

  dimension: ticket_sold_count {
    type: number
    sql: ${TABLE}.ticket_sold_count ;;
  }
}
