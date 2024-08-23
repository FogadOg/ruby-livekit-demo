class RoomsController < ApplicationController
    def create
      room_name = params[:room_name]
      livekit_service = LiveKitService.new(ENV['LIVEKIT_API_KEY'], ENV['LIVEKIT_API_SECRET'], ENV['LIVEKIT_SERVER_URL'])
      @room = livekit_service.create_room(room_name)
      render json: @room
    end

    def generate_token(api_key, api_secret, room_name, participant_identity, ttl = 600)
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
  
    def show
      room_name = params[:room_name]
      participant_identity = params[:participant_identity]
      livekit_service = LiveKitService.new(ENV['LIVEKIT_API_KEY'], ENV['LIVEKIT_API_SECRET'], ENV['LIVEKIT_SERVER_URL'])
      @token = livekit_service.join_room(room_name, participant_identity)
      render json: @token
    end
  end
  