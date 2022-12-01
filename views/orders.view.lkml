view: orders {
  sql_table_name: `looker-private-demo.thelook.orders`
    ;;
  drill_fields: [order_id]

  dimension: order_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: delivered {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.delivered_at ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: num_of_item {
    type: number
    sql: ${TABLE}.num_of_item ;;
  }

  measure: avg_order_size {
    type: average
    sql: ${num_of_item} ;;
  }

  dimension_group: returned {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.returned_at ;;
  }

  dimension_group: shipped {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.shipped_at ;;
  }

  dimension: status {
    case: {
      when: {
        sql: ${TABLE}.status = 0 ;;
        label: "pending"
      }
      when: {
        sql: ${TABLE}.status = 1 ;;
        label: "complete"
      }
      when: {
        sql: ${TABLE}.status = 2 ;;
        label: "pending"
      }
      else: "unknown"
    }
  }

  dimension: is_order_fulfilled {
    type: yesno
    sql: ${status} = 'complete' ;;
    drill_fields: [order_id, users.last_name, users.id, users.first_name, order_items.count]
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
    drill_fields: [order_id, users.last_name, users.id, users.first_name, order_items.count]
  }

  measure: count {
    type: count
    drill_fields: [order_id, users.last_name, users.id, users.first_name, order_items.count]
  }
}
