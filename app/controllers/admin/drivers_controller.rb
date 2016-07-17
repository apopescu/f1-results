class Admin::DriversController < ApplicationController
  respond_to :json
  before_filter :authenticate_user!
  
  def show_active_drivers
    if params[:constructorId].present?
      constructor = Constructor.find_by(constructorId: params[:constructorId])
      drivers = constructor.drivers.where(active: true)
    else
      drivers = Driver.all.where(active: true)
    end

    render json: { total: drivers.size, driverList: drivers }, include: :constructor
  end

  def show_all_drivers
    drivers = Driver.all.order(active: :desc, position: :asc);
    render json: { total: drivers.size, driverList: drivers }, include: :constructor
  end

  def create
    driver = Driver.new(driver_params)
    if driver.save
      render json: 'New driver created successuflly'.to_json, status: :ok
    else
      render json: 'An error occured with driver creation'.to_json, status: :internal_server_error
    end
  end

  def destroy
    driver = Driver.find_by(id: params[:id])
    if driver.destroy
      render json: 'Driver successuflly deleted'.to_json, status: :ok
    else
      render json: 'An error occured with delete'.to_json, status: :internal_server_error
    end
  end

  def update
    driver = Driver.find_by(id: driver_params[:id])

    if driver.update_attributes(driver_params)
      render json: 'Driver successuflly updated'.to_json, status: :ok
    else
      render json: 'An error occured with the update'.to_json, status: :internal_server_error
    end
  end

  private
  def driver_params
    params.require(:driver).permit(:id, :driverId, :role, :familyName, :givenName, :number, :dob, :nationality, :active, :n_champion, :position)
  end
end
