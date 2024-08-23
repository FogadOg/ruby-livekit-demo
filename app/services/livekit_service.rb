class LiveKitService
    def initialize(api_key, api_secret, server_url)
      @api_key = api_key
      @api_secret = api_secret
      @server_url = server_url
      @conn = Faraday.new(url: server_url)
    end
  
    def create_room(room_name)
      token = LiveKitToken.generate(@api_key, @api_secret, room_name, "server")
      response = @conn.post("/v1/rooms", { name: room_name }.to_json, { 'Authorization' => "Bearer #{token}" })
      JSON.parse(response.body)
    end
  
    def join_room(room_name, participant_identity)
      token = LiveKitToken.generate(@api_key, @api_secret, room_name, participant_identity)
      { token: token }
    end
  end
  