- dashboard: gender_dash_udd
  title: Gender dash UDDS
  layout: newspaper
  preferred_viewer: dashboards-next
  elements:
  - title: Gender dash UDDS
    name: Gender dash UDDS
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
