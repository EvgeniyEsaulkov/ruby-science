class CarwashesController < ApplicationController
  expose :ticket, :fetch_ticket

  def summary
    code = params[:code]


    if ticket.activate(params[:code])
      redirect_to summary_carwash_path
    else
      redirect_to confirm_step_carwash_path, alert: "Код подтверждения неправильный"
    end
  end

  private

  def fetch_ticket
    Ticket.find(session[:userdata][:ticket_id])
  end
end
