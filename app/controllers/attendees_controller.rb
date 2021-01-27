class AttendeesController < ApplicationController

  # GET /attendees
  # GET /attendees.json
  def index
    @attendees = Attendee.all
  end

  # GET /attendees/1
  # GET /attendees/1.json
  def show; end

  # GET /attendees/new
  def new
    @attendee = Attendee.new
  end

  # GET /attendees/1/edit
  def edit; end

  # POST /attendees
  # POST /attendees.json
  def create
    @attendee = Attendee.create!(attendee_params)

      if @attendee.save
        redirect_to events_path
      end
  end

  def destroy
    @attendee.destroy
    respond_to do |format|
      format.html { redirect_to attendees_url, notice: 'Attendee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def attendee_params
    puts params
    params.require(:attendee).permit(:user_id, :event_id)
  end
end