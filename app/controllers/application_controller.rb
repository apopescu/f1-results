class ApplicationController < ActionController::API

  # necessary for admin authentication
  include DeviseTokenAuth::Concerns::SetUserByToken
end
