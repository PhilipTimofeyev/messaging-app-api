class GroupsController < ApplicationController
  skip_before_action :verify_authenticity_token, raise: false
  before_action :authenticate_devise_api_token!, :set_current_user
  before_action :set_group, only: %i[ show update destroy ]

  # GET /groups
  def index
    # Returns groups that contain the current and selected user
    #
    @groups = @current_user.groups

    render json: @groups
  end

  # GET /groups/1
  def show
    group_messages = @group.get_group_messages_with_images

    # Returns group, users, and messages of group
    render json: { group: @group, users: @group.users, messages: group_messages }
  end

  # POST /groups
  def create
    @group = Group.new(title: group_params[:title])

    user_ids = group_params[:users]
    message_id = JSON.parse(group_params[:message_id])

    @group.add_users(user_ids)
    @group.add_message(message_id)
    @group.users << @current_user

    group_messages = @group.get_group_messages_with_images

    if @group.save
      render json:  { group: @group, users: @group.users, messages: group_messages }, status: :created, location: @group
    else
      render json: @group.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /groups/1
  def update
    if @group.add_message(group_params[:message_id])
        group_messages = @group.get_group_messages_with_images
      render json: { group: @group, users: @group.users, messages: group_messages }
    else
      render json: @group.errors, status: :unprocessable_entity
    end
  end

  # DELETE /groups/1
  def destroy
    @group.destroy!
  end

  private
    def set_group
      @group = Group.find(params[:id])
    end

    def group_params
      params.require(:group).permit(:title, :message_id, users: {})
    end

    def set_current_user
      current_user_id = current_devise_api_token[:resource_owner_id]
      @current_user = User.find(current_user_id)
    end
end
