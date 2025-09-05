class TicketsController < ApplicationController
  # Load @ticket for member actions that need it
  before_action :set_ticket, only: [:show, :edit, :update, :destroy, :update_stage]

  # GET /tickets
  def index
    @tickets = Ticket.order(created_at: :desc)

    # Optional filters
    if params[:priority].present?
      @tickets = @tickets.where(priority: params[:priority])
    end

    if params[:stage].present?
      @tickets = @tickets.where(stage: params[:stage])
    end

    unless params[:under_warranty].to_s.blank?
      bool = ActiveModel::Type::Boolean.new.cast(params[:under_warranty])
      @tickets = @tickets.where(under_warranty: bool)
    end

    if params[:assigned_to].present?
      @tickets = @tickets.where(assigned_to: params[:assigned_to])
    end
  end

  # GET /tickets/board
  def board
    # Ensure tickets with nil stage still appear
    @tickets_by_stage = Ticket.all.group_by { |t| t.stage.presence || "not_scheduled" }
  end

  # GET /tickets/1
  def show
  end

  # GET /tickets/new
  def new
    @ticket = Ticket.new
  end

  # POST /tickets
  def create
    @ticket = Ticket.new(ticket_params)

    respond_to do |format|
      if @ticket.save
        format.html { redirect_to @ticket, notice: "Ticket was successfully created.", status: :see_other }
        format.json { render :show, status: :created, location: @ticket }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /tickets/1/edit
  def edit
  end

  # PATCH/PUT /tickets/1
  def update
    respond_to do |format|
      if @ticket.update(ticket_params)
        format.html { redirect_to @ticket, notice: "Ticket was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @ticket }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1
  def destroy
    @ticket.destroy
    respond_to do |format|
      format.html { redirect_to tickets_path, notice: "Ticket was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  # PATCH /tickets/:id/stage
  def update_stage
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