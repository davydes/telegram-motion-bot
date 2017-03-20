require './lib/reply_markup_formatter'
require './lib/app_configurator'

class VideoSender
  attr_reader :bot
  attr_reader :video
  attr_reader :chat
  attr_reader :answers
  attr_reader :logger

  def initialize(options)
    @bot = options[:bot]
    @video = options[:video]
    @chat = options[:chat]
    @answers = options[:answers]
    @logger = AppConfigurator.new.get_logger
  end

  def send
    options = {
      chat_id: chat.id,
      video: Faraday::UploadIO.new(video, 'video/avi')
    }

    oprions.merge! reply_markup: reply_markup if reply_markup

    bot.api.send_video(options)

    logger.debug "sending '#{video}' to #{chat.username}"
  end

  private

  def reply_markup
    if answers
      ReplyMarkupFormatter.new(answers).get_markup
    end
  end
end
