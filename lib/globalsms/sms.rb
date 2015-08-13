module GlobalSMS
  class SMS
    def initialize(api_key, api_secret)
      @api_key = api_key
      @api_secret = api_secret
      @default_args = {
        time: 'now',
        turkish_character: '0'
      }
    end

    def single_send(message)
      message = @default_args.merge(message)
      post_to_api('single', message)
    end

    def multi_send(messages)
      messages = messages.map { |message| @default_args.merge(message) }
      post_to_api('multi', messages)
    end

    private

    def post_to_api(uri, data)
      client = HTTPClient.new
      data = "data=#{data.to_json.to_s}"
      uri = "#{API_BASE_URL}/sms/send/#{to}?key=#{@api_key}&secret=#{@api_secret}"
      response = client.post(uri, data)
      JSON.parse(response.body)
    end
  end
end
