class MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token, raise: false
  before_action :authenticate_devise_api_token!, :set_current_user
  before_action :set_message, only: %i[ show update destroy ]

  # GET /messages
  def index
    @messages = Message.all

    render json: @messages
  end

  # GET /messages/1
  def show
    render json: @message
  end

  # POST /messages
  def create
    @message = @current_user.messages.build(content: message_params[:content])
    @message.image.attach(message_params[:image]) unless message_params[:image] == "undefined"

    if @message.save
      render json: @message, status: :created, location: @message
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /messages/1
  def update
    if @message.update(message_params)
      render json: @message
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  # DELETE /messages/1
  def destroy
    @message.destroy!
  end

  private
    def set_message
      @message = Message.find(params[:id])
    end

    def set_current_user
      current_user_id = current_devise_api_token[:resource_owner_id]
      @current_user = User.find(current_user_id)
    end

    def message_params
      params.require(:message).permit(:content, :image)
    end
end
