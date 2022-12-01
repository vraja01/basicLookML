connection: "looker-private-demo"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
# include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

datagroup: varunikas_DG {
  max_cache_age: "24 hours"
  #sql_trigger: SELECT max(id) FROM my_tablename ;;
  interval_trigger: "4 hours"
  label: "varunika_basiclookML_cache"
  description: "An explore that is cached for 4 hours"
}

 explore: products {
  always_filter: {
    filters: [products.category: "Swim, Accessories, Active, Jeans, Underwear, Pants"]
  }
   join: inventory_items {
     relationship: one_to_many
     sql_on: ${products.id} = ${inventory_items.product_id} ;;
    type: inner
   }
 }

explore: users {
  #sql_always_where: ${orders.created_date} >= '2012-01-01' ;;
  join: order_items {
    view_label: "Customer Purchases"
    relationship: one_to_many
    sql_on: ${users.id} = ${order_items.user_id} ;;
  }
}

explore: distribution_centers {
  persist_with: varunikas_DG
  join: inventory_items {
    type: left_outer
    relationship: many_to_one
    sql_on: ${distribution_centers.id} = ${inventory_items.product_distribution_center_id}  ;;
    }
}
