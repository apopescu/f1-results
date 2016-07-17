class Admin::RacesController < ApplicationController
  	before_action :authenticate_user!

	def create
		event = Event.find_by(id: race_params[:eventInfo][:id])
		results = race_params[:results]
		if Race.add_new_results(event, results)
	      render json: 'New race created successuflly'.to_json, status: :ok
	    else
	      render json: 'An error occured with race creation'.to_json, status: :internal_server_error
	    end
	end

	def show
		races = Event.all.where("id IN (SELECT event_id FROM races GROUP BY event_id)").order(round: :asc)
		render json: races, status: :ok
	end

	def getDetails
		races = Event.find_by(id: params[:id]).races
		render json: races, include: :driver
	end

	def update
		event = Event.find_by(id: race_params[:eventInfo])
		results = race_params[:results]
		if Race.update_race(event, results)
			render json: 'Race was updated successuflly'.to_json, status: :ok
		else
			render json: 'An error occured with race update'.to_json, status: :internal_server_error
		end
	end

	def destroy
		event = Event.find_by(id: params[:id])
		if event.races.destroy_all
			render json: 'Race was successuflly deleted'.to_json, status: :ok
		else
			render json: 'An error occured with race deletion'.to_json, status: :internal_server_error
		end
	end
	
	private
	def race_params
		params.require(:race).permit!
	end
end
