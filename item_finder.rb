# frozen_string_literal: true

class ItemFinder
  def find_actuall_items
    last_50_sales.each do |item_hash|
      order.create_order_in_db(item_hash) if all_conditions_fulfilled?(item_hash)
    end
  end

  private
  
  def last_50_sales
    Connection.send_request(Constant::LAST_50_SALES_URL)
  end
  
  def all_conditions_fulfilled?(item_hash)
    if item_validator.price_interval_is_valid?(item_hash) &&
       order.order_not_exists?(item_hash) &&
       item_validator.item_profitable?(item_hash)
      true
    end
  end

  def order
    @order ||= Order.new
  end

  def item_validator
    @item_validator ||= ItemValidator.new
  end
end
