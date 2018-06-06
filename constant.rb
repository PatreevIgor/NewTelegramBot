# frozen_string_literal: true

class Constant
  # ------------------------------------------------- URLS -------------------------------------------------------------
  ITEM_HISTORY_URL     = 'https://market.dota2.net/api/ItemHistory/%<class_id>s_%<instance_id>s/?key=%<your_secret_key>s'
  BEST_BUY_OFFER_URL   = 'https://market.dota2.net/api/BestBuyOffer/'\
                         '%<class_id>s_%<instance_id>s/?key=%<your_secret_key>s'
  BEST_SELL_OFFER_URL  = 'https://market.dota2.net/api/BestSellOffer/'\
                         '%<class_id>s_%<instance_id>s/?key=%<your_secret_key>s'
  ITEM_LINK_URL        = 'https://market.dota2.net/item/'\
                         '%<class_id>s-%<instance_id>s-%<i_market_hash_name>s/'
  DELETE_ORDERS_URL    = 'https://market.dota2.net/api/DeleteOrders/?key=%<your_secret_key>s'
  REMOVE_ALL_URL       = 'https://market.dota2.net/api/RemoveAll/?key=%<your_secret_key>s'
  LAST_50_SALES_URL    = 'https://market.dota2.net/history/json/'
  CREATE_ORDER_URL     = 'https://market.dota2.net/api/ProcessOrder/'\
                         '%<class_id>s/%<instance_id>s/%<price>s/?key=%<your_secret_key>s'
  NOT_SALE_ITEMS_URL   = 'https://market.dota2.net/api/GetInv/?key=%<your_secret_key>s'
  SALE_ITEMS_URL       = 'https://market.dota2.net/api/GetMySellOffers/?key=%<your_secret_key>s'
  ITEM_INFORMATION_URL = 'https://market.dota2.net/api/ItemInfo/'\
                         '%<class_id>s_%<instance_id>s/ru/?key=%<your_secret_key>s'
  GET_ORDERS_LOG_URL   = 'https://market.dota2.net/api/GetOrdersLog/?key=%<your_secret_key>s'
  UPDATE_ORDER_URL     = 'https://market.dota2.net/api/UpdateOrder/'\
                         '%<class_id>s/%<instance_id>s/%<price>s/?key=%<your_secret_key>s'
  SET_PRICE_URL        = 'https://market.dota2.net/api/SetPrice/%<ui_id>s/%<price>s/?key=%<your_secret_key>s'
  UPDATE_INVENTARY_URL = 'https://market.dota2.net/api/UpdateInventory/?key=%<your_secret_key>s'
  
  MASS_INFO_URL        = 'https://market.dota2.net/api/MassInfo/%<sell>s/%<buy>s/%<history>s/%<info>s?key=%<your_secret_key>s'
                       # %<sell>s — Может принимать значения 0,1,2
                       #   0 - Не получать предложения о продаже
                       #   1 - Получать топ 50 дешевых предложений + свой
                       #   2 - Получать только 1 самый дешевый оффер о продаже
                       # %<buy>s — Может принимать значения 0,1,2
                       #   0 - Не получать запросы на покупку (ордера)
                       #   1 - Получать топ 50 самых высоких запросов на покупку (ордеров) + свой
                       #   2 - Получать только 1 самый высокий запрос на покупку
                       # %<history>s — Может принимать значения 0,1,2
                       #   0 - Не получать история торгов по предмету
                       #   1 - Получить информацию о последних 100 продажах
                       #   2 - Получить информацию о последних 10 продажах
                       # %<info> — Может принимать значения 0,1,2,3
                       #   0 - Не получать информацию о предмете
                       #   1 - Получить базовую информацию (название, тип)
                       #   2 - Получить дополнительно хэш для покупки, ссылку на картинку
                       #   3 - Получать дополнительно описание предмета и теги из Steam

  # ----------- HASH KEYS ------------------
  HASH_MIN_KEY                 = 'min'
  HASH_MAX_KEY                 = 'max'
  HASH_AVERAGE_KEY             = 'average'
  HASH_BEST_OFFER_KEY          = 'best_offer'
  ITEM_HASH_CLASS_ID_KEY       = 'classid'
  ITEM_HASH_INSTANCE_ID_KEY    = 'instanceid'
  ITEM_HASH_PRICE_KEY          = 'price'
  ITEM_HASH_HASH_NAME_KEY      = 'hash_name'
  ITEM_INFO_HASH_MIN_PRICE_KEY = 'min_price'
  ITEM_HASH_BEST_OFFER_KEY     = 'best_offer'
  TIME_OF_SAIL_KEY             = 'l_time'
  HISTORY_KEY                  = 'history'
    
  # ------------ ORDER STATUSES ----------------------
  NOT_ACTUALIZED_ORDER_STATUS = 'not_actualized_order'
  CREATED_ORDER_STATUS        = 'created_order'
  UNPROFITABLE_ORDER_STATUS   = 'unprofitable_order'
  PROFITABLE_ORDER_STATUS     = 'profitable_order'

  # ----------- ITEM STATUSES -------------
  ON_SALE_ITEM_STATUS      = 'on_sale'
  IN_INVENTARY_ITEM_STATUS = 'in_inventory'

  # --------------------------- TEXTS -----------------------------------
  TEXT_MESSAGE_CREATE_BUY_ORDER    = 'Order create on the website!'
  COUNT_FOUND_ITEMS_TEXT       = 'Found %<count_item>s new items!'
  ITEM_CREATED_TEXT            = 'Item created!'
  REMOVED_ALL_TRADES_TEXT      = 'Removed all trades!'
  WAIT_15_SEK_TEXT             = 'Wait 15 sec!'
  NOT_SALE_ITEMS_UPDATED_TEXT  = 'Items (not sale) in my db updated!'
  FINISHED_FILLING_TEXT        = 'Finished filling price_of_buy fields!'
  PUT_UP_ALL_BOUGHT_ITEMS_TEXT = 'Put up all bought items!'
  PROFITABLE_ITEM_TEXT         = 'coef_prof=%<coef_prof>s / coef_cur_st=%<coef_cur_st>s / coef_fr_purch=%<coef_fr_purch>s'
  UNPROFITABLE_ITEM_TEXT       = ''
end
