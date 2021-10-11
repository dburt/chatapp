class Message < ApplicationRecord
    validates :body, presence: true
    after_create_commit { broadcast_append_to "messages" }
end
