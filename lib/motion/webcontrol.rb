require './lib/app_configurator'
require 'net/http'

module Motion
  class Webcontrol
    attr_accessor :logger

    def initialize(options = {})
      @url    = options[:url] || 'http://localhost:8080'
      @thread = options[:thread] || 0
      @logger = AppConfigurator.new.get_logger
    end

    def snapshot
      command('action/snapshot')
    end

    private

    def command(name)
      uri = URI.parse([@url, @thread, name].join('/'))
      res = Net::HTTP::get_response(uri)
      res.is_a?(Net::HTTPSuccess)
    rescue => e
      logger.debug e.message
      false
    end
  end
end
