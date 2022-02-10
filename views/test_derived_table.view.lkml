view: test_derived_table {
  derived_table: {
    datagroup_trigger: ryo_test_default_datagroup
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
