class UsersController < ApplicationController
   # load_and_authorize_resource
  before_filter :authenticate_user!, :except => [ :auth_token ]
end
