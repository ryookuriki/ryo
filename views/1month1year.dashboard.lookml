- dashboard: 1month_1_year
  title: 1month 1 year
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  elements:
  - title: 1 month
    name: 1 month
    model: ryo_test
    explore: order_items
    type: looker_grid
    fields: [order_items.count]
    filters:
      order_items.created_month: 1 months
    limit: 500
    query_timezone: America/Los_Angeles
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    listen:
      Created Date: order_items.created_date
    row: 0
    col: 0
    width: 8
    height: 6
  - title: 1 year
    name: 1 year
    model: ryo_test
    explore: order_items
    type: looker_grid
    fields: [order_items.count]
    filters:
      order_items.created_year: 1 years
    limit: 500
    query_timezone: America/Los_Angeles
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    listen:
      Created Date: order_items.created_date
    row: 0
    col: 8
    width: 8
    height: 6
  filters:
  - name: Created Date
    title: Created Date
    type: field_filter
    default_value: 6 day
    allow_multiple_values: true
    required: false
    ui_config:
      type: relative_timeframes
      display: inline
      options: []
    model: ryo_test
    explore: order_items
    listens_to_filters: []
    field: order_items.created_date
