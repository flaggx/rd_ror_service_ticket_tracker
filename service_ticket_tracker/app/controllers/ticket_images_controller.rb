class TicketImagesController < ApplicationController
  before_action :set_ticket_image, only: %i[ show edit update destroy ]

  # GET /ticket_images or /ticket_images.json
  def index
    @ticket_images = TicketImage.all
  end

  # GET /ticket_images/1 or /ticket_images/1.json
  def show
  end

  # GET /ticket_images/new
  def new
    @ticket_image = TicketImage.new
  end

  # GET /ticket_images/1/edit
  def edit
  end

  # POST /ticket_images or /ticket_images.json
  def create
    @ticket_image = TicketImage.new(ticket_image_params)

    respond_to do |format|
      if @ticket_image.save
        format.html { redirect_to @ticket_image, notice: "Ticket image was successfully created." }
        format.json { render :show, status: :created, location: @ticket_image }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ticket_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ticket_images/1 or /ticket_images/1.json
  def update
    respond_to do |format|
      if @ticket_image.update(ticket_image_params)
        format.html { redirect_to @ticket_image, notice: "Ticket image was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @ticket_image }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ticket_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ticket_images/1 or /ticket_images/1.json
  def destroy
    @ticket_image.destroy!

    respond_to do |format|
      format.html { redirect_to ticket_images_path, notice: "Ticket image was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket_image
      @ticket_image = TicketImage.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def ticket_image_params
      params.expect(ticket_image: [ :url, :ticket_id ])
    end
end
