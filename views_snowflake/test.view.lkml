include: "/views_snowflake/products.view"
explore:  test {}
view: test {
  derived_table: {
    sql: select
    category,
    sum(retail_price) as retail_price,
    count(category) as count_category
      from products
      group by 1
      ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: retail_price {
    type: number
    sql: ${TABLE}.retail_price ;;
  }

  dimension: count_category {
    type: number
    sql: ${TABLE}.count_category ;;
  }

  }
