class TicketUpdatesController < ApplicationController
  def create
    ticket = Ticket.find(params[:ticket_id])
    update = ticket.ticket_updates.build(ticket_update_params)
    if update.save
      redirect_to ticket_path(ticket), notice: "Update added.", status: :see_other
    else
      redirect_to ticket_path(ticket), alert: update.errors.full_messages.to_sentence, status: :see_other
    end
  end

  def destroy
    update = TicketUpdate.find(params[:id])
    ticket = update.ticket
    update.destroy
    redirect_to ticket_path(ticket), notice: "Update removed.", status: :see_other
  end

  private

  def ticket_update_params
    # Accept nested params (preferred) or fallback to flat params
    if params[:ticket_update].present?
      params.require(:ticket_update).permit(:user_name, :content)
    else
      params.permit(:user_name, :content)
    end
  end
end