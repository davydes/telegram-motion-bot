require 'net/http'

module Motion
  class Webcontrol
    def initialize(options = {})
      @url    = options[:url] || 'http://localhost:8080'
      @thread = options[:thread] || 0
    end

    def snapshot
      command('action/snapshot')
    end

    private

    def command(name)
      uri = URI.join(@url, @thread, name)
      res = Net::HTTP::get_response(uri)
      return res.is_a?(Net::HTTPSuccess)
    end
  end
end
