class User < ApplicationRecord
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }

  def token_valid?
    token.present? && token_expires_at < Time.zone.now
  end
  
  def generate_token
    update token: SecureRandom.base58, token_expires_at: Time.zone.now + 7.days
  end

  def self.sign_in_with_token(token)
    user = where(token: token).take
    return unless user && user.token_valid?
    user.update last_signed_in_at: Time.zone.now, sign_in_count: user.sign_in_count.to_i + 1
    user
  end
end
