# frozen_string_literal: true

class Price
  
  # ------------------------------------------ for creating orders -------------------------------------------
  def price_of_buy_for_order(order)
    other_buy_orders_exist?(order) ? (max_price_of_buy_orders(order) + 1) : 50
  end
  
  def other_buy_orders_exist?(order)
    url = format(Constant::MASS_INFO_URL, sell: 0, buy: 2, history: 0, info: 0,
                                          your_secret_key: Rails.application.secrets.your_secret_key)
    response = Connection.send_post_request(url, order)

    response["results"].first["buy_offers"].nil? ? false : true
  end

  def max_price_of_buy_orders(order)
    # этот запрос необходимо отправить пост запросом и передать в него Параметры запроса (POST данные): list — classid_instanceid,classid_instanceid,classid_instanceid,classid_instanceid,...
    url = format(Constant::MASS_INFO_URL, sell: 0,
                                          buy: 2,
                                          history: 0,
                                          info: 0,
                                          your_secret_key: Rails.application.secrets.your_secret_key)
    response = Connection.send_post_request(url, order)
    response["results"].first["buy_offers"]["best_offer"]
  end
  
  
  # ------------------------------------------ for creating items -------------------------------------------
  
  def price_of_sell_for_item(item) # цена при выставлении купленной вещи
    if item_never_sold?(item_info_hash(item))
      price_of_never_sold_item(item_info_hash(item))
    elsif order_other_user_not_exist?(item_info_hash(item))
      max_price_of_sales_from_history(item_info_hash(item))
    else
      appropriate_price(item_info_hash(item))
    end
  end
  
  def item_never_sold?(item_hash)
    if min_price_of_sales_from_history(item_hash) == 1 &&
       max_price_of_sales_from_history(item_hash) == 2
      true
    else
      false
    end
  end
  
  def price_of_never_sold_item(item_hash)
    curr_price_of_buy(item_hash) / 100 * 110 + 3000
  end
    
  def order_other_user_not_exist?(item_hash)
    if (item_informations(item_hash[Constant::ITEM_HASH_CLASS_ID_KEY], item_hash[Constant::ITEM_HASH_INSTANCE_ID_KEY])[Constant::ITEM_INFO_HASH_MIN_PRICE_KEY] == -1)
      true
    else
      false
    end
  end
  
  def min_price_of_sales_from_history(params)
    min_middle_max_prices = get_hash_min_middle_max_prices(params)

    min_price = min_middle_max_prices[Constant::HASH_MIN_KEY].to_f
  end
  
  def max_price_of_sales_from_history(params)
    min_middle_max_prices = get_hash_min_middle_max_prices(params)
    
    max_price = min_middle_max_prices[Constant::HASH_MAX_KEY].to_f
  end
  
  def get_hash_min_middle_max_prices(params)
    url = format(Constant::ITEM_HISTORY_URL, class_id:        params[:class_id].to_s,
                                             instance_id:     params[:instance_id].to_s,
                                             your_secret_key: Rails.application.secrets.your_secret_key)
    response = Connection.send_request(url)
    create_hash_min_middle_max_prices(response)
  end
  
  def create_hash_min_middle_max_prices(response) # в будущем передаелать метод с обработкой ошибок
    min_middle_max_prices = {}

    response[Constant::HASH_MIN_KEY] ?
    (min_middle_max_prices[Constant::HASH_MIN_KEY] = response[Constant::HASH_MIN_KEY]/100) :
    (min_middle_max_prices[Constant::HASH_MIN_KEY] = 100/100)

    response[Constant::HASH_MAX_KEY] ?
    (min_middle_max_prices[Constant::HASH_MAX_KEY] = response[Constant::HASH_MAX_KEY]/100) :
    (min_middle_max_prices[Constant::HASH_MAX_KEY] = 200/100)

    response[Constant::HASH_AVERAGE_KEY] ?
    (min_middle_max_prices[Constant::HASH_AVERAGE_KEY] = response[Constant::HASH_AVERAGE_KEY]/100) :
    (min_middle_max_prices[Constant::HASH_MAX_KEY]     = 150/100)

    min_middle_max_prices
  end
  
  def appropriate_price(item_hash)
    if min_price_of_orders_to_buy(item_hash[Constant::ITEM_HASH_CLASS_ID_KEY], item_hash[Constant::ITEM_HASH_INSTANCE_ID_KEY]) < min_favorable_price(item_hash)
      min_favorable_price(item_hash)
    else
      min_price_of_orders_to_buy(item_hash[Constant::ITEM_HASH_CLASS_ID_KEY], item_hash[Constant::ITEM_HASH_INSTANCE_ID_KEY])
    end
  end
  
  def min_price_of_orders_to_buy(class_id, instance_id)
    item_informations(class_id, instance_id)[Constant::ITEM_INFO_HASH_MIN_PRICE_KEY].to_f - 0001
  end
  
  def min_favorable_price(item_hash)
    sprintf("%.0f", (curr_price_of_buy(item_hash) / 100 * 110 + 1000)).to_f
  end
  
  def item_informations(class_id, instance_id)
    Connection.send_request(format(Constant::ITEM_INFORMATION_URL, class_id:        class_id, 
                                                                   instance_id:     instance_id, 
                                                                   your_secret_key: Rails.application.secrets.your_secret_key))
  end
    
  
  # ------------------------------------ for count coefficients --------------------------------------------
  
  def curr_max_price(item_hash) # максимальная цена, используется для расчета коэффициентов
    item_history(item_hash)[Constant::HASH_MAX_KEY]
  end

  def curr_middle_price(item_hash) # средняя цена, используется для расчета коэффициентов
    item_history(item_hash)[Constant::HASH_AVERAGE_KEY]
  end

  def curr_min_price(item_hash) # минимальная цена, используется для расчета коэффициентов
    item_history(item_hash)[Constant::HASH_MIN_KEY]
  end

  def curr_price_of_buy(item_hash) # текущая цена покупки
    url = format(Constant::BEST_BUY_OFFER_URL, class_id:        item_hash[Constant::ITEM_HASH_CLASS_ID_KEY],
                                               instance_id:     item_hash[Constant::ITEM_HASH_INSTANCE_ID_KEY],
                                               your_secret_key: Rails.application.secrets.your_secret_key)
    price(url)
  end

  def curr_price_of_sell(item_hash) # текущая цена продажи
    url = format(Constant::BEST_SELL_OFFER_URL, class_id:        item_hash[Constant::ITEM_HASH_CLASS_ID_KEY],
                                                instance_id:     item_hash[Constant::ITEM_HASH_INSTANCE_ID_KEY],
                                                your_secret_key: Rails.application.secrets.your_secret_key)
    price(url)
  end

  def diff_curr_middle_and_curr_min(item_hash) # разница между средней и минимальной ценой
    curr_middle_price(item_hash) - curr_min_price(item_hash)
  end

  def diff_curr_price_of_sell_and_curr_min(item_hash) # разница между ценой продажи и минимальной ценой
    curr_price_of_sell(item_hash) - curr_min_price(item_hash)
  end

  private

  def item_info_hash(item)
    { Constant::ITEM_HASH_CLASS_ID_KEY => item.class_id, Constant::ITEM_HASH_INSTANCE_ID_KEY => item.instance_id }
  end

  def item_history(item_hash)
    url = format(Constant::ITEM_HISTORY_URL, class_id:        item_hash[:class_id].to_s,
                                             instance_id:     item_hash[:instance_id].to_s,
                                             your_secret_key: Rails.application.secrets.your_secret_key)

    Connection.send_request(url)
  end

  def price(url)
    response = Connection.send_request(url)

    response[Constant::ITEM_HASH_BEST_OFFER_KEY].to_i
  end
end
