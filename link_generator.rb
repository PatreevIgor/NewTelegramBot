# frozen_string_literal: true

class LinkGenerator
  def generate_link(item_hash)
    format(Constant::ITEM_LINK_URL, class_id:           item_hash[Constant::ITEM_HASH_CLASS_ID_KEY],
                                    instance_id:        item_hash[Constant::ITEM_HASH_INSTANCE_ID_KEY],
                                    i_market_hash_name: item_hash[Constant::ITEM_HASH_HASH_NAME_KEY].gsub(' ','+'))
  end
end
