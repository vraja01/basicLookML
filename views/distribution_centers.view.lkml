view: distribution_centers {
  label: "Distribution Centers with Inventory insight"
  sql_table_name: `looker-private-demo.thelook.distribution_centers`
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: latitude {
    type: number
    sql: ${TABLE}.latitude ;;
  }

  dimension: longitude {
    type: number
    sql: ${TABLE}.longitude ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  measure: count {
    type: count
    label: "Number of Centers"
    drill_fields: [id, name, products.count]
  }

  # measure: total_item_count {
  #   type: count
  #   sql: ${inventory_items} ;;
  #   label: "Count of total inventory items in center"
  #   drill_fields: [id, name, products.count]
  # }
}
