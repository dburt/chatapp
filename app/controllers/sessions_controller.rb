class SessionsController < ApplicationController
  skip_before_action :login_required

  def new
    redirect_to :messages if signed_in?
  end

  def create
    if params[:email]
      user = User.find_or_create_by!(email: params[:email])
      if user.persisted?
        user.generate_token unless user.token_valid?
        link = session_url(user.token)
        NotificationsMailer.sign_in(user: user, link: link).deliver_later
      end
    end
  end

  def show
    token = params[:id]
    if token
      user = User.sign_in_with_token(token)
      if user
        self.current_user = user
        redirect_to :messages
      else
        redirect_to :root, notice: "That sign in link doesn't work"
      end
    end
  end

  def destroy
    self.current_user = nil
    redirect_to :root, notice: "You are signed out"
  end
end
