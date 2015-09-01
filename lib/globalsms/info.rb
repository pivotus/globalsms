module GlobalSMS
  class INFO
    def initialize(args)
      @api_key = args[:api_key]
      @api_secret = args[:api_secret]
    end

    def originator_list
      uri = "/originator/list?key=#{@api_key}&secret=#{@api_secret}"
      get_request(uri)
    end

    def user_info
      uri = "/user/info?key=#{@api_key}&secret=#{@api_secret}"
      get_request(uri)
    end

    private

    def get_request(uri)
      client = HTTPClient.new
      response = client.get("#{API_BASE_URL}#{uri}")
      JSON.parse(response.body)
    end
  end
end
