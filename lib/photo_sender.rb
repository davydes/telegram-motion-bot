require './lib/reply_markup_formatter'
require './lib/app_configurator'

class PhotoSender
  attr_reader :bot
  attr_reader :photo
  attr_reader :chat
  attr_reader :answers
  attr_reader :logger

  def initialize(options)
    @bot = options[:bot]
    @photo = options[:photo]
    @chat = options[:chat]
    @answers = options[:answers]
    @logger = AppConfigurator.new.get_logger
  end

  def send
    options = {
      chat_id: chat.id,
      photo: Faraday::UploadIO.new(photo, 'image/jpeg')
    }

    oprions.merge! reply_markup: reply_markup if reply_markup

    bot.api.send_photo(options)

    logger.debug "sending '#{photo}' to #{chat.username}"
  end

  private

  def reply_markup
    if answers
      ReplyMarkupFormatter.new(answers).get_markup
    end
  end
end
