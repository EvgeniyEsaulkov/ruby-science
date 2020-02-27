class Basket
  def order_items
    products.map do |product|
      OrderItem.from(product, product_count(product), product_cost(product))
    end
  end

  def remove_order_items(order)
    order.order_items.each { |i| remove_product_id(i.product_id) }
  end
end
