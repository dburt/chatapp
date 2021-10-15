class SessionsController < ApplicationController
  def new
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
        session[:user_id] = user.id
      end
      redirect_to :messages
    end
  end
end
