- dashboard: gender_dash_udd
  title: Gender dash UDD
  layout: newspaper
  preferred_viewer: dashboards-next
  elements:
  - title: Gender dash UDD
    name: Gender dash UDD
    model: ryo_model1
    explore: users
    type: table
    fields: [users.gender, users.average_age]
    sorts: [users.average_age desc]
    limit: 500
    query_timezone: America/Los_Angeles
    listen: {}
    row:
    col:
    width:
    height:
