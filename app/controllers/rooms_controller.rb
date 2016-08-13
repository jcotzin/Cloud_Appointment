class RoomsController < ApplicationController
  def index
    @rooms = Room.where(:public => true).order("created_at DESC")
    @new_room = Room.new
  end

  def create
    session = opentok.create_session
    @new_room = Room.new(room_params)
    @new_room.sessionId = session.session_id
    respond_to do |format|
      if @new_room.save
        format.html { redirect_to("/party/"+@new_room.id.to_s) }
      else
        format.html { render :controller => 'rooms', :action => "index" }
      end
    end
  end

  def party
    @room = Room.find(params[:id])
    @tok_token = opentok.generate_token @room.sessionId
  end

  private

  def opentok
    @opentok ||= OpenTok::OpenTok.new ENV["TOKAPI"], ENV["TOKSECRET"]
  end

  def room_params
    params.require(:room).permit(:name)
  end
end
