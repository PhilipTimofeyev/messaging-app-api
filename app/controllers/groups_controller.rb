class GroupsController < ApplicationController
  skip_before_action :verify_authenticity_token, raise: false
  before_action :authenticate_devise_api_token!, :set_current_user
  before_action :set_selected_user, only: %i[ index ]
  before_action :set_group, only: %i[ show update destroy ]

  # GET /groups
  def index
    # Returns groups that contain the current and selected user
    @groups = @current_user.groups.joins(:users).where(users: { id: @selected_user.id })

    render json: @groups
  end

  # GET /groups/1
  def show
    # Returns group, users, and messages of group
    render json: { group: @group, users: @group.users, messages: @group.messages }
  end

  # POST /groups
  def create
    @group = Group.new(group_params)

    if @group.save
      render json: @group, status: :created, location: @group
    else
      render json: @group.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /groups/1
  def update
    if @group.update(group_params)
      render json: @group
    else
      render json: @group.errors, status: :unprocessable_entity
    end
  end

  # DELETE /groups/1
  def destroy
    @group.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def group_params
      params.require(:group).permit(:title, :selected_user_id)
    end

    def set_selected_user
      selected_user_id = group_params[:selected_user_id]
      @selected_user = User.find(selected_user_id)
    end

    def set_current_user
      current_user_id = current_devise_api_token[:resource_owner_id]
      @current_user = User.find(current_user_id)
    end
end
