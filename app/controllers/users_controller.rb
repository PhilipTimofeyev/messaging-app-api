class UsersController < ApplicationController
  before_action :authenticate_devise_api_token!, :set_current_user
  def index
    @users = User.where.not(id: @current_user.id)

    render json: @users
  end
end



  private

  def set_current_user
    current_user_id = current_devise_api_token[:resource_owner_id]
    @current_user = User.find(current_user_id)
  end
