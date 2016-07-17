class Api2016::EventsController < ApplicationController

	def event_info
		event = Event.find_by(round: params[:round])

		render json: {
			event: event
		}, except: [:created_at, :updated_at, :id]
	end
end
