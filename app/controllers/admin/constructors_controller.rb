class Admin::ConstructorsController < ApplicationController
  before_action :authenticate_user!

  def show
    constructors = Constructor.all.order(position: :asc)
    render json: { total: constructors.size, constructorList: constructors }, include: [ :drivers ]
  end

  def create
    constructor = Constructor.new(constructor_params[:constructor])
    driver1 = constructor_params[:drivers][:driver1]
    driver2 = constructor_params[:drivers][:driver2]
    if Constructor.add_new_constructor(constructor, driver1, driver2)
      render json: 'New constructor created successuflly'.to_json, status: :ok
    else
      render json: 'An error occured with constructor creation'.to_json, status: :internal_server_error
    end
  end

  def destroy
    constructor = Constructor.find_by(id: params[:id])
    if constructor.destroy
      render json: 'constructor successuflly deleted'.to_json, status: :ok
    else
      render json: 'An error occured with delete'.to_json, status: :internal_server_error
    end
  end

  def update
    constructor = constructor_params[:constructor]


    if constructor_params[:drivers][:driver1].present?
      driver1 = constructor_params[:drivers][:driver1]
    else
      driver1 = nil
    end


    if constructor_params[:drivers][:driver2].present?
      driver2 = constructor_params[:drivers][:driver2]
    else
      driver2 = nil
    end


    if Constructor.update_c(constructor, driver1, driver2)
      render json: 'constructor successuflly updated'.to_json, status: :ok
    else
      render json: 'An error occured with the update'.to_json, status: :internal_server_error
    end
  end

  private
  def constructor_params
    # params should not be a problem because only the admin can send them
    params.require(:constructorInfo).permit!
  end
end
