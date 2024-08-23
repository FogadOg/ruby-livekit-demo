require 'livekit'
class RoomsController < ApplicationController

    def show
      token = LiveKit::AccessToken.new(api_key: 'devkey', api_secret: 'secret')
      token.identity = params[:participant_identity]
      token.add_grant(roomJoin: true, room: params[:room_name])

      render json: {token: token.to_jwt, identity: params[:participant_identity], roomName: params[:room_name]}
    end
  end
  