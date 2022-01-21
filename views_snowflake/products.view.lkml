view: products {
  sql_table_name: "PUBLIC"."PRODUCTS"
    ;;
  drill_fields: [id]

  parameter: param_limit_date {
    label: "満期日指定フィルター"
    type: date
  }

  parameter: param_limit_date2 {
    label: "満期日指定フィルター2"
    type: date
  }

  measure: test_label_thismonth_text {
    type: string
    sql: 1;;
    html:
    これは「当月：{{param_limit_date._parameter_value | date: "%Y-%m-%d" }}〜{{param_limit_date2._parameter_value | date: "%Y-%m-%d" }}」のデータを表示しています ;;
  }


  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."ID" ;;
  }

  dimension: brand {
    type: string
    sql: ${TABLE}."BRAND" ;;
  }

   dimension: category {
     type: string
     sql: ${TABLE}."CATEGORY" ;;
  ##  html: <a href="https://www.google.com/search?q={{value | url_encode}}" > <p style="color:blue">{{value}}</p></a>
  ##  change font color to blue ↑
  ##  html: <a href="https://www.google.com/search?q={{value | url_encode}}" > {{value}}</a>;;
    html: <a href="https://lookerv2112.dev.looker.com/explore/snowflake_ryo/order_items?fields=products.brand,order_items.first_purchase_date,order_items.last_purchase_date,order_items.count,order_items.sale_price&f[products.category]={{value | url_encode}}&sorts=order_items.first_purchase_date+desc&limit=500&query_timezone=Japan&vis=%7B%7D&filter_config=%7B%22products.category%22%3A%5B%7B%22type%22%3A%22%3D%22%2C%22values%22%3A%5B%7B%22constant%22%3A%22%22%7D%2C%7B%7D%5D%2C%22id%22%3A1%7D%5D%7D&origin=share-expanded" > {{value}}</a>;;


   }



  dimension: cost {
    type: number
    sql: ${TABLE}."COST" ;;
  }

  dimension: department {
    type: string
    sql: ${TABLE}."DEPARTMENT" ;;
  }

  dimension: distribution_center_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."DISTRIBUTION_CENTER_ID" ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}."NAME" ;;
  }

  measure: name_count {
    type: sum_distinct
    sql: ${name} ;;
  }

  dimension: retail_price {
    type: number
    sql: ${TABLE}."RETAIL_PRICE" ;;
  }

  dimension: retail_price2 {
    type: number
    sql: round(${TABLE}."RETAIL_PRICE", 1) ;;
  }

  dimension: retail_price3 {
    type: number
    sql: ${retail_price2} -10 ;;
  }

  dimension: retail_prices {
    type: number
    sql: ${TABLE}."RETAIL_PRICE"-10 ;;
  }



  dimension: sku {
    type: string
    sql: ${TABLE}."SKU" ;;
  }

  measure: count {
    type: count
    drill_fields: [id, name, distribution_centers.id, distribution_centers.name, inventory_items.count]
  }
}
