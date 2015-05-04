require "globalsms/version"
require 'httpclient'
require 'json'

module GlobalSMS
  class REPORT
    def initialize(api_key, api_secret)
      @api_base_url = "http://api.globalhaberlesme.com"
      @api_key = api_key
      @api_secret = api_secret
    end

    def single_report(argv)
      uri = "#{@api_base_url}/sms/report/#{argv}?key=#{@api_key}&secret=#{@api_secret}"
      c = HTTPClient.new
      return JSON.parse(c.get(uri).body)
    end

    def bulk_report
    end
  end
end