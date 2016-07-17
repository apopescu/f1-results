class Admin::QualisController < ApplicationController
  	before_action :authenticate_user!

	def create
		event = Event.find_by(id: quali_params[:eventInfo][:id])
		results = quali_params[:results]
		if Quali.add_new_results(event, results)
	      render json: 'New quali created successuflly'.to_json, status: :ok
	    else
	      render json: 'An error occured with quali creation'.to_json, status: :internal_server_error
	    end
	end

	def show
		qualis = Event.all.where("id IN (SELECT event_id FROM qualis GROUP BY event_id)")
		render json: qualis, status: :ok
	end

	def getDetails
		quali = Event.find_by(id: params[:id]).qualis
		render json: quali, include: :driver
	end

	def update
		event = Event.find_by(id: quali_params[:eventInfo])
		results = quali_params[:results]
		if Quali.update_quali(event, results)
			render json: 'Quali was updated successuflly'.to_json, status: :ok
		else
			render json: 'An error occured with quali update'.to_json, status: :internal_server_error
		end
	end

	def destroy
		event = Event.find_by(id: params[:id])
		if event.qualis.destroy_all
			render json: 'Quali was successuflly deleted'.to_json, status: :ok
		else
			render json: 'An error occured with quali deletion'.to_json, status: :internal_server_error
		end
	end

	private
	def quali_params
		params.require(:qualifying).permit!
	end
end
