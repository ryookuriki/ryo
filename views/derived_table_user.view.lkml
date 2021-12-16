view: derived_table_user {
    derived_table: {
      sql:
      SELECT
        TO_NUMBER(AVG(age), 10, 2) as average_age
      FROM
        users;;
    }
    dimension: average_age {
      type: string
      primary_key: yes
      sql: ${TABLE}.average_age||'★' ;;
    }

    # dimension:  average_age {
    #   type: string
    #   sql: ${average_age_hidden} ;;
    # }
  }
