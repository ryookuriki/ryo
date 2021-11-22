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
    html: <a href="https://www.google.com/search?q={{value | url_encode}}" > {{value}}</a>
    ;;

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

  dimension: retail_price {
    type: number
    sql: ${TABLE}."RETAIL_PRICE" ;;
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
