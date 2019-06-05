#set a tag to initiate discount
discount_tag = "tag"

#defining one_cent for comparison
one_cent = Money.new(cents:1).cents/100

Input.cart.line_items.each do |line_item|
  product = line_item.variant.product
  price = line_item.variant.price
  diff = (price.cents/100).ceil - (price.cents/100)
  next if product.gift_card?
  next unless product.tags.include?(discount_tag) && diff == one_cent && price.cents < Money.new(cents:5500).cents
  line_item.change_line_price(line_item.line_price * 0.90, message: "My Sale")
end

Output.cart = Input.cart
