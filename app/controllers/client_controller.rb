class ClientController < ApplicationController
before_action :authenticate_user! 
protect_from_forgery with: :null_session
	
  def index
    @tickets = Ticket.where(user_id: current_user.id)
  end
end
