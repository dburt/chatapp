class NotificationsMailer < ApplicationMailer
  default from: "dave+chatapp@burt.id.au"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifications_mailer.sign_in.subject
  #
  def sign_in(user:, link:)
    @user = user
    @link = link

    mail to: user.email, subject: "Sign in to chat app"
  end
end
