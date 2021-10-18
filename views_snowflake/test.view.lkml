include: "events.view"
explore:  test {}
view: test {
  derived_table: {
    sql: select *
      from "PUBLIC"."EVENTS"
      where country = 'USA'
      ;;
  }
  dimension: country {
    type: string
    sql: ${TABLE}.country ;;
  }
  }
