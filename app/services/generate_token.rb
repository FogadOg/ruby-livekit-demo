require 'jwt'

module LiveKitToken
  def self.generate(api_key, api_secret, room_name, participant_identity, ttl = 600)
    payload = {
      "iss" => api_key,
      "sub" => participant_identity,
      "room" => room_name,
      "exp" => Time.now.to_i + ttl,
      "video" => true,
      "audio" => true
    }
    JWT.encode(payload, api_secret, 'HS256')
  end
end
