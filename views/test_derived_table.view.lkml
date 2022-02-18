view: test_derived_table {
  derived_table: {
sql_trigger_value: select 1;;
sql:
    SELECT
    id
    FROM
    users
    GROUP BY
    id ;;

}
dimension: id {}
}
