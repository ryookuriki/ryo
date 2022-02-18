# Define the database connection to be used for this model.
connection: "snowflakelooker"

# include all the views
# include: "/views/**/*.view"
# import all explores from ryo_test project
include: "//ryo_test/explores/explores.lkml"


# Datagroups define a caching policy for an Explore. To learn more,
# use the Quick Help panel on the right to see documentation.

datagroup: ryo_test2_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: ryo_test2_default_datagroup

explore: +distribution_centers {
  label: "extended distribution centers"
  fields: [distribution_centers.id, distribution_centers.latitude, distribution_centers.longitude]
}
