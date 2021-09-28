connection: "snowlooker"

# include all the views
include: "/views_snowflake/**/*.view"

explore: products {
  extends: [products]
}



explore: users {}
