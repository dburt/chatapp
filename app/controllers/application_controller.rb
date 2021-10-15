class ApplicationController < ActionController::Base
  before_action :login_required

  helper_method :signed_in?, :current_user

  protected

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def current_user=(user)
    session[:user_id] = user&.id
    @current_user = User.find_by_id(session[:user_id])
  end

  def signed_in?
    current_user.present?
  end

  def login_required
    redirect_to :root, notice: "You have to sign in before you can go there" unless signed_in?
  end
end
