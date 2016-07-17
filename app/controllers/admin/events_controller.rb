class Admin::EventsController < ApplicationController
  before_action :authenticate_user!

  def index
    events = Event.all.order(round: :asc)
  end

  def show
    events = Event.all.order(round: :asc)
    render json: { total: events.size, eventList: events }
  end

  def create
    event = Event.new(event_params)
    if event.save
      render json: 'New event created successuflly'.to_json, status: :ok
    else
      render json: 'An error occured with event creation'.to_json, status: :internal_server_error
    end
  end

  def destroy
    event = Event.find_by(id: params[:id])
    if event.destroy
      render json: 'Event successuflly deleted'.to_json, status: :ok
    else
      render json: 'An error occured with delete'.to_json, status: :internal_server_error
    end
  end

  def update
    event = Event.find_by(id: event_params[:id])
    if event.update_attributes(event_params)
      render json: 'Event successuflly updated'.to_json, status: :ok
    else
      render json: 'An error occured with the update'.to_json, status: :internal_server_error
    end
  end

  private
  def event_params
    params.require(:eventInfo).permit!
  end
end
