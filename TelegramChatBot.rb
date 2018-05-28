require 'telegram/bot'
require 'dotenv'
require 'net/http'
require 'uri'
require 'json'
require 'dotenv'
# require './service_control_time_trading'
# require './service_information_about_orders'
# require './service_information_about_sales'
# require './service_organizer'
Dotenv.load

class TelegramChatBot
  # include Control_time_trading
  # include Information_about_sales
  # include Information_about_orders
  # include Organizer

  def run
    Telegram::Bot::Client.run(ENV['HIDE_TOKEN']) do |bot|
      bot.listen do |message|
        case message
        when Telegram::Bot::Types::Message
          bot.api.send_message(chat_id: message.chat.id, text: 'Make a choice', reply_markup: markup1)
        when Telegram::Bot::Types::CallbackQuery
          if message.data == 'touch'
            bot.api.send_message(chat_id: message.from.id, text: "Don't touch me!")
            bot.api.send_message(chat_id: message.from.id, text: 'Make a choice2', reply_markup: markup2)

          elsif message.data == 'touch2'
            bot.api.send_message(chat_id: message.from.id, text: "Don't touch me!2")
          elsif message.data == 'touch3'
            bot.api.send_message(chat_id: message.from.id, text: "Don't touch me!3")
          end
        end
      end
    end
  end

  private

  def buttons1
    [Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Touch me', callback_data: 'touch'),
     Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Touch me2', callback_data: 'touch2')]
  end

  def buttons2
    [Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Touch me3', callback_data: 'touch3'),
     Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Touch me4', callback_data: 'touch4')]
  end

  def markup1
    Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: buttons1)
  end

  def markup2
    Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: buttons2)
  end
end

TelegramChatBot.new.run
