include: "/models/ryo_model1.model"                # include all views in the views/ folder in this project

explore: +distribution_centers {
  label: "extended distribution centers"
  fields: [distribution_centers.id, distribution_centers.latitude, distribution_centers.longitude]
}
