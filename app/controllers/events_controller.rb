class EventsController < ApplicationController
  # GET /events
  # GET /events.json
  def index
    @coming_events = Event.coming_events
    @prev_events = Event.old_events
    @attendance = Attendee.new
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])
    @attendance = Attendee.new
  end

  # GET /events/new
  def new
    @event = current_user.events.build
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.json
  def create
    @event = current_user.events.build(event_params)
    # redirect_to events_path if @event.save

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'User was successfully created.' }
        format.json { render :index, status: :created, location: @event }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    @event = Event.find(params[:id])
    redirect_to events_path if @event.update(event_params)
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def event_params
    params.require(:event).permit(:title, :date, :cover, :content)
  end
end
