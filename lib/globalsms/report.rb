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

    def bulk_report(argv)
      res = {}
      argv.each do |message_id|
        body = JSON.parse(HTTPClient.new.get("#{@api_base_url}/sms/report/#{message_id}?key=#{@api_key}&secret=#{@api_secret}").body)
        res[message_id] = body
      end
      return res
    end

    def report_last(argv=1)
      uri = "#{@api_base_url}/sms/report/sent?limit=#{argv}&key=#{@api_key}&secret=#{@api_secret}"
      c = HTTPClient.new
      return JSON.parse(c.get(uri).body)
    end

    def report_between()
    end
    
    def originator_list
      uri = "#{@api_base_url}/originator/list?key=#{@api_key}&secret=#{@api_secret}"
      c = HTTPClient.new
      return JSON.parse(c.get(uri).body)
    end

    def user_info
      uri = "#{@api_base_url}/user/info?key=#{@api_key}&secret=#{@api_secret}"
      c = HTTPClient.new
      return JSON.parse(c.get(uri).body)
    end
  end
end