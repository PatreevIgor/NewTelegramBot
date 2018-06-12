# frozen_string_literal: true

class ItemFinder
  def find_profitable_item  # Метод возвращает одну (последнюю выгодную шмотку) В буд можно пределать, что бы возвращал все из 50-ти
    profitable_item = nil
    end_while       = false

    while end_while == false
      puts last_50_sales
      last_50_sales.each do |item_hash|
      # binding.pry

        if all_conditions_fulfilled?(item_hash) == true
          end_while = true
          profitable_item = item_hash
        end
      end

      break if end_while
    end
    # puts profitable_item
    # puts "all_conditions_fulfilled? =" + all_conditions_fulfilled?(profitable_item).to_s
    # puts "end_while? =" + end_while.to_s
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
    else
      false
    end
  end

  def item_validator
    @item_validator ||= ItemValidator.new
  end

  def price
    @price ||= Price.new
  end
end
