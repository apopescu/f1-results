class Api2016::RacesController < ApplicationController

	# GET /races/:round
	def race_results
		event = Event.find_by(round: params[:round])

        if event
            name = event.name
            round = event.round
            races = event.races.sort_by { |a| (a.position.to_i) }
            count = races.size
        else
            name = ""
            round = ""
            races = []
            count = 0
        end

    	render json: {
            event: name,
            round: round,
            total: count,
    		results: races
    		},
    		include: {driver: {except: [:id, :created_at, :updated_at, :role, :active, :constructor_id]}},
    		except: [:created_at, :updated_at, :id, :driver_id, :event_id, :raceId, :constructor_id]
	end
end
