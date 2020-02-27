class OrderItem
  def self.from(product, product_count, product_cost)
    OrderItem.new(
      product_id: product.id,
      product_uid: product.uid,
      count: product_count,
      cost: product_cost
    )
  end
end
