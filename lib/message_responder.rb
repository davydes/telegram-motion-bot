require './models/user'
require './lib/message_sender'
require './lib/photo_sender'
require './lib/services/motion_service'

class MessageResponder
  attr_reader :message
  attr_reader :bot
  attr_reader :user

  def initialize(options)
    @bot = options[:bot]
    @message = options[:message]
    @user = User.find_or_create_by(uid: message.from.id)
  end

  def respond
    on(/^\/start/) do
      answer_with_greeting_message
    end

    on(/^\/stop/) do
      answer_with_farewell_message
    end

    on(/^\/shot/) do
      photo = MotionService.new.snapshot

      if photo
        answer_with_photo(photo)
      else
        answer_with_message('Can\'t take picture')
      end
    end
  end

  private

  def on regex, &block
    regex =~ message.text

    if $~
      case block.arity
      when 0
        yield
      when 1
        yield $1
      when 2
        yield $1, $2
      end
    end
  end

  def answer_with_greeting_message
    answer_with_message I18n.t('greeting_message')
  end

  def answer_with_farewell_message
    answer_with_message I18n.t('farewell_message')
  end

  def answer_with_message(text)
    MessageSender.new(bot: bot, chat: message.chat, text: text).send
  end

  def answer_with_photo(filename)
    PhotoSender.new(bot: bot, chat: message.chat, photo: filename).send
  end
end
