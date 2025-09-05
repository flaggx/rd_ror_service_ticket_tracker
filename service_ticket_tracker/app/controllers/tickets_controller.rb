class TicketsController < ApplicationController
  # ... existing code ...
  # Load the ticket only for member routes (those that have :id)
  before_action :set_ticket, if: -> { params[:id].present? }
  # ... existing code ...

  # Ensure index assigns @tickets for the list page
  def index
    @tickets = Ticket.order(created_at: :desc)
  end

  # Kanban board view
  def board
    @tickets_by_stage = Ticket.all.group_by(&:stage)
  end

  # Update stage via drag-and-drop
  def update_stage
    # @ticket is set by before_action
    new_stage = params.require(:stage)

    unless Ticket.stages.key?(new_stage)
      return respond_to do |format|
        format.json { render json: { error: "Invalid stage" }, status: :unprocessable_entity }
        format.html { redirect_to board_tickets_path, alert: "Invalid stage" }
      end
    end

    if @ticket.update(stage: new_stage)
      respond_to do |format|
        format.json { render json: { ok: true } }
        format.html { redirect_to board_tickets_path, notice: "Stage updated." }
      end
    else
      respond_to do |format|
        format.json { render json: { error: @ticket.errors.full_messages.to_sentence }, status: :unprocessable_entity }
        format.html { redirect_to board_tickets_path, alert: @ticket.errors.full_messages.to_sentence }
      end
    end
  end

  # ... existing code ...

  private

  def set_ticket
    @ticket = Ticket.find(params[:id])
  end

  def ticket_params
    params.require(:ticket).permit(
      :account_name,
      :city,
      :contact_person,
      :contact_info,
      :priority,
      :work_type,
      :lease,
      :under_warranty,
      :machine_model_or_type,
      :issue_description,
      :requesting_tech_name,
      :assigned_to,
      :stage
    )
  end
end