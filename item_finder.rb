# frozen_string_literal: true

class ItemFinder
  def find_profitable_item
    profitable_item = nil
    end_while       = false

    while end_while == false
      last_50_sales.each do |item_hash|
        if all_conditions_fulfilled?(item_hash)
          end_while = true
          break
        end

        profitable_item = item_hash
      end
    end

    profitable_item
  end

  private
  
  def last_50_sales
    Connection.send_request(Constant::LAST_50_SALES_URL)
  end
  
  def all_conditions_fulfilled?(item_hash)
    if item_validator.price_interval_is_valid?(item_hash) &&
       # order.order_not_exists?(item_hash) &&
       item_validator.item_profitable?(item_hash)         &&
       price.curr_price_of_sell(item_hash)              != 0    # исключаем те, которых нет в продаже

      true
    end
  end

  def item_validator
    @item_validator ||= ItemValidator.new
  end

  def price
    @price ||= Price.new
  end
end
