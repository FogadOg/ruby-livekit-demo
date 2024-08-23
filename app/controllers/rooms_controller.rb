class RoomsController < ApplicationController
    def create
      room_name = params[:room_name]
      livekit_service = LiveKitService.new(ENV['LIVEKIT_API_KEY'], ENV['LIVEKIT_API_SECRET'], ENV['LIVEKIT_SERVER_URL'])
      @room = livekit_service.create_room(room_name)
      render json: @room
    end
  
    def join
      room_name = params[:room_name]
      participant_identity = params[:participant_identity]
      livekit_service = LiveKitService.new(ENV['LIVEKIT_API_KEY'], ENV['LIVEKIT_API_SECRET'], ENV['LIVEKIT_SERVER_URL'])
      @token = livekit_service.join_room(room_name, participant_identity)
      render json: @token
    end
  end
  