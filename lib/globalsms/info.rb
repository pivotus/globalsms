module GlobalSMS
  class INFO
    def initialize(api_key, api_secret)
      @api_key = api_key
      @api_secret = api_secret
    end

    def originator_list
      uri = "/originator/list?key=#{@api_key}&secret=#{@api_secret}"
      get_to_api(uri)
    end

    def user_info
      uri = "/user/info?key=#{@api_key}&secret=#{@api_secret}"
      get_to_api(uri)
    end

    private

    def get_to_api(uri)
      client = HTTPClient.new
      response = client.get("#{API_BASE_URL}#{uri}")
      JSON.parse(response.body)
    end
  end
end
