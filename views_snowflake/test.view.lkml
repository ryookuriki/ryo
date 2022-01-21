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
    group_label: "group1"
  }

  dimension: retail_price {
    type: number
    sql: ${TABLE}.retail_price ;;
    view_label: "view1"
  }

  dimension: count_category {
    type: number
    sql: ${TABLE}.count_category ;;
    #group_label: "group1"
    view_label: "view1"
  }

  dimension: count_category2 {
    type: number
    sql: ${TABLE}.count_category ;;
    #group_label: "group1"
    group_label: "group1"
    }

  }
