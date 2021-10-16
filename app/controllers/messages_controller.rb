class MessagesController < ApplicationController
  before_action :set_message, only: %i[ show edit update ]

  # GET /messages or /messages.json
  def index
    @messages = Message.order(id: :desc).limit(5).reverse
  end

  # POST /messages or /messages.json
  def create
    @message = Message.new(message_params.merge(user: current_user))

    respond_to do |format|
      if @message.save
        format.html { redirect_to root_url }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { redirect_to root_url, status: :unprocessable_entity }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    return head :unauthorized unless current_user.can?(:update, @message)
  end

  # PATCH/PUT /messages/1 or /messages/1.json
  def update
    return head :unauthorized unless current_user.can?(:update, @message)
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to root_url }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { redirect_to root_url, status: :unprocessable_entity }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1 or /messages/1.json
  def destroy
    @message = Message.find(params[:message_id])
    return head :unauthorized unless current_user.can?(:destroy, @message)
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def message_params
      params.require(:message).permit(:body)
    end
end
