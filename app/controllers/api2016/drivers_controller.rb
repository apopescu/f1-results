class Api2016::DriversController < ApplicationController
  respond_to :json
  # get all the information about a specific constructor,
  # or the constructor standing.

  
  # GET /drivers/:driverId
  def driver_info
    driver = Driver.find_by(driverId: params[:driverId])
    render json: {
      driver: driver
    },
    include: [
              { constructor: {except: [:id, :created_at, :updated_at]} },
              { races: {include: {event: {except: [:id, :created_at, :updated_at, :p_winner, :tyres, :constructor_id]}},
                        except: [:id, :created_at, :updated_at, :driver_id, :event_id, :constructor_id]} },
              { qualis: {include: {event: {except: [:id, :created_at, :updated_at, :p_winner, :tyres, :constructor_id]}},
                        except: [:id, :created_at, :updated_at, :driver_id, :event_id, :constructor_id]} }
              ],
              except: [:created_at, :updated_at, :id, :active, :constructor_id]
  end

  # GET /drivers
  def driver_standing
    drivers = Driver.all.order(position: :asc)
    render json: {
      total: drivers.size,
      drivers: drivers
    }, except: [:created_at, :updated_at, :id, :active, :constructor_id]
  end
end
