module Overrides
  class RegistrationsController < DeviseTokenAuth::RegistrationsController

    # Put here your logic for admin registration. Other users shouldn't be allowed
    # to register. Personally i prefer register 2 users, then i reject other registration
    # requests. This is just a precautionary system that prevents a malicious user 
    # to register and take control of your API.
    def create
      countUsers = User.all.size
      if countUsers < 2
        super
      else 
        render json: 'You cannot register on this website', status: 403
      end
    end
  end
end