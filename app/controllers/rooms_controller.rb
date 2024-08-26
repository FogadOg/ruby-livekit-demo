require 'livekit'
class RoomsController < ApplicationController
    def show

      if params[:id].blank? || params[:room_name].blank?
        render json: { error: 'id and room_name are required' }, status: 402
        return
      end

      token = LiveKit::AccessToken.new(api_key: 'devkey', api_secret: 'secret')
      token.identity = params[:id]
      token.add_grant(roomJoin: true, room: params[:room_name])

      # render json: {token: token.to_jwt, identity: params[:participant_identity], roomName: params[:room_name]}
      @token = token.to_jwt
    end
  end
  