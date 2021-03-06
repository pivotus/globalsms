module GlobalSMS
  class REPORT
    def initialize(args)
      @api_key = args[:api_key]
      @api_secret = args[:api_secret]
    end

    def message(message_id, limit=250)
      uri = "/sms/report/#{message_id}?key=#{@api_key}&secret=#{@api_secret}&limit=#{limit}"
      get_request(uri)
    end

    def last_n(limit=1)
      uri = "/sms/report/sent?limit=#{limit}&key=#{@api_key}&secret=#{@api_secret}"
      get_request(uri)
    end

    def between(argv)
      argv = {
        start_time: '00:00:00',
        end_time: '23:59:59',
        limit: '200',
        start: '0'
      }.merge(argv)

      uri = "/sms/report/sent?between_start=#{argv[:start_date]} #{argv[:start_time]}&between_end=#{argv[:end_date]} #{argv[:end_time]}&limit=#{argv[:limit]}&start=#{argv[:start]}&key=#{@api_key}&secret=#{@api_secret}"
      safe_uri = URI.parse(URI.encode(uri))
      get_request(safe_uri)
    end

    private

    def get_request(uri)
      client = HTTPClient.new
      response = client.get("#{API_BASE_URL}#{uri}")
      JSON.parse(response.body)
    end
  end
end
