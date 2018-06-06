# frozen_string_literal: true

class Connection
  def self.send_request(url)
    uri           = URI.parse(url)
    response_json = Net::HTTP.get_response(uri)

    JSON.parse(response_json.body)
  end
  
  def self.send_post_request(url, order)
    params   = { list: "#{order.class_id}_#{order.instance_id}" }
    response = Net::HTTP.post_form(URI.parse(url), params).body

    JSON.parse(response)
  end
end
