module GlobalSMS
  class SMS
    TIME = 'now'
    ENGLISH = 'O'
    TURKISH = '1'
    SELECTED = [:time, :turkish_character, :originator]

    attr_reader :api_key, :api_secret, :time, :turkish_character, :originator

    def initialize(args)
      @api_key = args[:api_key]
      @api_secret = args[:api_secret]
      @default_args = {
        time: TIME,
        turkish_character: ENGLISH
      }
      @default_args.merge!(args.select { |key, value| SELECTED.include?(key) })
    end

    def single_send(message)
      message = @default_args.merge(message)
      post_request('single', message)
    end

    def multi_send(messages)
      messages = messages.map { |message| @default_args.merge(message) }
      post_request('multi', messages)
    end

    def cancel(*args)
      args.each do |message_id|
        uri = "/sms/cancel/#{message_id}?key=#{@api_key}&secret=#{@api_secret}"
        get_request(uri)
      end
    end

    private

    def post_request(to, data)
      client = HTTPClient.new
      data = "data=#{data.to_json.to_s}"
      uri = "#{API_BASE_URL}/sms/send/#{to}?key=#{@api_key}&secret=#{@api_secret}"
      response = client.post(uri, data)
      JSON.parse(response.body)
    end

    def get_request(uri)
      client = HTTPClient.new
      response = client.get("#{API_BASE_URL}#{uri}")
      JSON.parse(response.body)
    end
  end
end
