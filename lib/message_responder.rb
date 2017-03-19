require './models/user'
require './models/subscribe'
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
    unless user.trusted
      answer_with_message('You is not trusted user.')
      return
    end

    on(/^\/shot/) do
      photo = MotionService.new.snapshot

      if photo
        answer_with_photo(photo)
      else
        answer_with_message('Can\'t take picture')
      end
    end

    on(/^\/subscribe/) do
      subscribe = Subscribe.find_or_create_by(cid: message.chat.id)
      result_message(subscribe.persisted?)
    end

    on(/^\/unsubscribe/) do
      subscribe = Subscribe.find_by(cid: message.chat.id)

      if subscribe
        subscribe.destroy
        result_message(subscribe.destroyed?)
      else
        answer_with_message('Subscribe not found')
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

  def answer_with_message(text)
    MessageSender.new(bot: bot, chat: message.chat, text: text).send
  end

  def answer_with_photo(filename)
    PhotoSender.new(bot: bot, chat: message.chat, photo: filename).send
  end

  def result_message(condition)
    answer_with_message(condition ? 'Success' : 'Fail')
  end
end
