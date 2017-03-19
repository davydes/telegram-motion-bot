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
    on(/^\/shot/) do
      unless user.trusted
        answer_with_message('You is not trusted user.')
        return
      end

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

  def answer_with_message(text)
    MessageSender.new(bot: bot, chat: message.chat, text: text).send
  end

  def answer_with_photo(filename)
    PhotoSender.new(bot: bot, chat: message.chat, photo: filename).send
  end
end
