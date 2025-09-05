class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :edit, :update, :destroy, :update_stage]
  before_action :set_users, only: [:new, :edit, :create, :update]

  # GET /tickets
  def index
    @tickets = Ticket.order(created_at: :desc)

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
    # Order by position (NULLS LAST), then created_at as a fallback
    ordered = Ticket.order(Arel.sql("position IS NULL, position ASC"), :created_at)
    @tickets_by_stage = ordered.group_by { |t| t.stage.presence || "not_scheduled" }
  end

  # GET /tickets/1
  def show
    render layout: false if params[:modal].present?
  end

  # GET /tickets/new
  def new
    @ticket = Ticket.new
  end

  # POST /tickets
  def create
    @ticket = Ticket.new(ticket_params)
    if @ticket.save
      redirect_to @ticket, notice: "Ticket was successfully created.", status: :see_other
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /tickets/1/edit
  def edit
    render layout: false if params[:modal].present?
  end

  # PATCH/PUT /tickets/1
  def update
    if @ticket.update(ticket_params)
      if params[:modal].present?
        # After modal edit, show the updated ticket in the modal
        render :show, layout: false, status: :ok
      else
        redirect_to @ticket, notice: "Ticket was successfully updated.", status: :see_other
      end
    else
      if params[:modal].present?
        render :edit, layout: false, status: :unprocessable_entity
      else
        render :edit, status: :unprocessable_entity
      end
    end
  end

  # DELETE /tickets/1
  def destroy
    @ticket.destroy
    redirect_to tickets_path, notice: "Ticket was successfully destroyed.", status: :see_other
  end

  # PATCH /tickets/:id/stage
  def update_stage
    old_stage = @ticket.stage
    new_stage = params.require(:stage)
    position  = params[:position].presence&.to_i

    unless Ticket.stages.key?(new_stage)
      return respond_to do |format|
        format.json { render json: { error: "Invalid stage" }, status: :unprocessable_entity }
        format.html { redirect_to board_tickets_path, alert: "Invalid stage" }
      end
    end

    Ticket.transaction do
      @ticket.update!(stage: new_stage, position: position)
      normalize_stage_positions!(new_stage)
      normalize_stage_positions!(old_stage) if old_stage != new_stage
    end

    respond_to do |format|
      format.json { render json: { ok: true } }
      format.html { redirect_to board_tickets_path, notice: "Stage updated." }
    end
  rescue ActiveRecord::RecordInvalid => e
    respond_to do |format|
      format.json { render json: { error: e.record.errors.full_messages.to_sentence }, status: :unprocessable_entity }
      format.html { redirect_to board_tickets_path, alert: e.record.errors.full_messages.to_sentence }
    end
  end

  private

  def set_ticket
    @ticket = Ticket.find(params[:id])
  end

  def set_users
    @users = User.order(:username, :id)
  end

  def normalize_stage_positions!(stage)
    return if stage.blank?
    list = Ticket.where(stage: stage).order(Arel.sql("position IS NULL, position ASC"), :updated_at, :created_at)
    list.each_with_index do |t, idx|
      new_pos = idx + 1
      t.update_column(:position, new_pos) if t.position != new_pos
    end
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
      :stage,
      :position
    )
  end
end