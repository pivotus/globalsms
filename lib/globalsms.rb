require "globalsms/version"
require 'httpclient'
require 'json/ext'

module GlobalSMS
  class GlobalSMS
    def initialize(api_key, api_secret)
      @api_base_url = "http://api.globalhaberlesme.com"
      @api_key = api_key
      @api_secret = api_secret
    end
    
    def single_send(argv)
      argv = {
        time: "now",
        turkish_character: "1"
      }.merge(argv)

      [:originator, :numbers, :text].each { |arg| puts "ERROR: #{arg} expecting" and return unless argv[arg] }

      body = "data=#{argv.to_json.to_s}"
      uri = "#{api_base_url}/sms/send/single?key=#{api_key}&secret=#{api_secret}"

      c = HTTPClient.new
      c.post(uri, body)
    end

    def bulk_send(argv)
      argv = {
        time: "now",
        turkish_character: "1"
      }.merge(argv)

      [:originator, :numbers, :text].each { |arg| puts "ERROR: #{arg} expecting" and return unless argv[arg] }

      body = "data=#{argv.to_json.to_s}"
      uri = "#{api_base_url}/sms/send/single?key=#{api_key}&secret=#{api_secret}"

      c = HTTPClient.new
      c.post(uri, body)
    end

    def multi_send(argv)
      argv = {
        time: "now",
        turkish_character: "1"
      }.merge(argv)

      [:originator, :numbers, :text].each { |arg| puts "ERROR: #{arg} expecting" and return unless argv[arg] }

      body = "data=#{argv.to_json.to_s}"
      uri = "#{api_base_url}/sms/send/single?key=#{api_key}&secret=#{api_secret}"

      c = HTTPClient.new
      c.post(uri, body)
    end
  end
end
