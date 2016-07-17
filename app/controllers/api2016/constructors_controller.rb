class Api2016::ConstructorsController < ApplicationController
	# get all the information about a specific constructor,
	# or the constructor standing.
	

	# GET /constructors/:constructorId
	def constructor_info
		constructor = Constructor.find_by(constructorId: params[:constructorId])
		races = constructor.races

		events = []
		info_per_race = races.group(:event_id).sum(:points)
		info_per_race.each do |key, value|
			mEvent = Event.find_by(id: key)
			mEvent.total_points = value
			events.push(mEvent)
		end
		events.sort_by{|e| e[:round]}

		races.each do |race|
			race.round = race.event.round
		end

		render json:
		{  	constructor: constructor,
			actual_drivers: constructor.drivers,
			races: races,
			total_points_per_race: events
		}, methods: [:total_points, :round], except: [:created_at, :updated_at, :id, :driver_id, :constructor_id, :active, :event_id]
	end

	# GET /constructors
	def constructor_standing
		constructors = Constructor.all.order(position: :asc)
	    render json: {
	      total: constructors.size,
	      constructors: constructors
	    }, except: [:created_at, :updated_at, :id]
	end
end
