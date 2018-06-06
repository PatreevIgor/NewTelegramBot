# frozen_string_literal: true

class ItemValidator
  def item_profitable?(item_hash)
    coef_profit = coefficient_calculator.coefficient_profit(item_hash)
    coef_cur_st = coefficient_calculator.coefficient_current_state(item_hash)
    coef_fr_pur = coefficient_calculator.coefficient_frequency_purchase(item_hash)

    puts 'coef-profit = ' + coef_profit.to_s
    puts 'coef-cur_st = ' + coef_cur_st.to_s
    puts 'coef-fr_pur = ' + coef_fr_pur.to_s

binding.pry
    if coef_profit > 80 &&
       coef_cur_st > 80 &&
       coef_fr_pur > 1
       # (price.curr_price_of_buy(item_hash) + 0) < price.curr_middle_price(item_hash)
      true
    else
      false
    end
  end

  def price_interval_is_valid?(item_hash)
    item_hash['price'] >= 10 and item_hash['price'] <= 150 ? true : false # цены вынети в конфигурационный файл
  end
  
  private

  def coefficient_calculator
    @coefficient_calculator ||= CoefficientCalculator.new
  end

  def price
    @price ||= Price.new
  end
end
