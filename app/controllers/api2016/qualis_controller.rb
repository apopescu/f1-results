class Api2016::QualisController < ApplicationController
    
    # GET /qualis/:round
    def quali_results
        event = Event.find_by(round: params[:round])

        if event
            name = event.name
            round = event.round
            qualis = event.qualis.sort_by { |a| (a.position.to_i) }
            count = qualis.size
        else 
            name = ""
            round = ""
            qualis = []
            count = 0
        end

        render json: {
            event: name,
            round: round,
            total: count,
            results: qualis
            },
            include: {driver: {except: [:id, :created_at, :updated_at, :role, :active, :constructor_id]}},
            except: [:created_at, :updated_at, :id, :driver_id, :event_id, :qualiId, :constructor_id]
    end
end
