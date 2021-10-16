class User < ApplicationRecord
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }

  has_many :visits, class_name: "Ahoy::Visit"

  def token_valid?
    token.present? && token_expires_at > Time.zone.now
  end
  
  def generate_token
    update! token: SecureRandom.base58, token_expires_at: Time.zone.now + 7.days
  end

  def self.authenticate_with_token(token)
    find_by_token(token)&.authenticate(token)
  end

  def authenticate(token)
    if token_valid? && self.token == token
      update! token: nil, token_expires_at: nil,
        last_signed_in_at: Time.zone.now,
        sign_in_count: sign_in_count.to_i + 1
      self
    end
  end
end
