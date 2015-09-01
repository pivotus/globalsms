module GlobalSMS
  class SMS
    TIME = 'now'
    TURKISH_CHARACTER = "0"
    SELECTED = [:time, :turkish_character, :originator]

    attr_reader :api_key, :api_secret, :time, :turkish_character, :originator

    def initialize(args)
      @api_key = args[:api_key]
      @api_secret = args[:api_secret]
      @default_args = {
        time: TIME,
        turkish_character: TURKISH_CHARACTER
      }
      @default_args.merge!(args.select { |key, value| SELECTED.include?(key) })
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

    def post_to_api(to, data)
      client = HTTPClient.new
      data = "data=#{data.to_json.to_s}"
      uri = "#{API_BASE_URL}/sms/send/#{to}?key=#{@api_key}&secret=#{@api_secret}"
      response = client.post(uri, data)
      JSON.parse(response.body)
    end
  end
end
