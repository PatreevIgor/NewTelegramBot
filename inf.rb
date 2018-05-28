    # # Отправка сообщений по коммандам

    # Telegram::Bot::Client.run(ENV['HIDE_TOKEN']) do |bot|
    #   bot.listen do |message|
    #     case message.text
    #     when '/start'
    #       bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}")
    #     when '/stop'
    #       bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}")
    #     end
    #   end
    # end


  # # Выбор кнопки для ответа

  # Telegram::Bot::Client.run(ENV['HIDE_TOKEN']) do |bot|
  #   bot.listen do |message|
  #     case message.text
  #     when '/start'
  #       question = 'London is a capital of which country?'
  #       # See more: https://core.telegram.org/bots/api#replykeyboardmarkup
  #       answers =
  #         Telegram::Bot::Types::ReplyKeyboardMarkup
  #         .new(keyboard: [%w(A B), %w(C D)], one_time_keyboard: true)
  #       bot.api.send_message(chat_id: message.chat.id, text: question, reply_markup: answers)
  #     when '/stop'
  #       # See more: https://core.telegram.org/bots/api#replykeyboardremove
  #       kb = Telegram::Bot::Types::ReplyKeyboardRemove.new(remove_keyboard: true)
  #       bot.api.send_message(chat_id: message.chat.id, text: 'Sorry to see you go :(', reply_markup: kb)
  #     end
  #   end
  # end


# Получить геокординаты и номер телефона


# Telegram::Bot::Client.run(ENV['HIDE_TOKEN']) do |bot|
#     bot.listen do |message|
#       kb = [
#         Telegram::Bot::Types::KeyboardButton.new(text: 'Give me your phone number', request_contact: true),
#         Telegram::Bot::Types::KeyboardButton.new(text: 'Show me your location', request_location: true)
#       ]
#       markup = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: kb)
#       bot.api.send_message(chat_id: message.chat.id, text: 'Hey!', reply_markup: markup)
#     end
#   end


# Кнопки 

# Telegram::Bot::Client.run(ENV['HIDE_TOKEN']) do |bot|
#   bot.listen do |message|
#     case message
#     when Telegram::Bot::Types::CallbackQuery
#       # Here you can handle your callbacks from inline buttons
#       if message.data == 'touch'
#         bot.api.send_message(chat_id: message.from.id, text: "Don't touch me!")
#       end
#     when Telegram::Bot::Types::Message
#       kb = [
#         Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Go to Google', url: 'https://google.com'),
#         Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Touch me', callback_data: 'touch'),
#         Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Switch to inline', switch_inline_query: 'some text')
#       ]
#       markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
#       bot.api.send_message(chat_id: message.chat.id, text: 'Make a choice', reply_markup: markup)
#     end
#   end
# end



# Свернутая панель с кнопками

# Telegram::Bot::Client.run(ENV['HIDE_TOKEN']) do |bot|

#   bot.listen do |message|
#     case message
#     when Telegram::Bot::Types::InlineQuery
#       results = [
#         [1, 'First article', 'Very interesting text goes here.'],
#         [2, 'Second article', 'Another interesting text here.']
#       ].map do |arr|
#         Telegram::Bot::Types::InlineQueryResultArticle.new(
#           id: arr[0],
#           title: arr[1],
#           input_message_content: Telegram::Bot::Types::InputTextMessageContent.new(message_text: arr[2])
#         )
#       end

#       bot.api.answer_inline_query(inline_query_id: message.id, results: results)
#     when Telegram::Bot::Types::Message
#       bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}!")
#     end
#   end

# end


 # Отправка картинок пользователю

# Telegram::Bot::Client.run(ENV['HIDE_TOKEN']) do |bot|
#   bot.listen do |message|
#     case message.text
#     when '/photo'
#       bot.api.send_photo(chat_id: message.chat.id, photo: Faraday::UploadIO.new('/home/patron/Projects/new_telegram_bot/image.jpg', 'image/jpeg'))
#     end
#   end
# end
