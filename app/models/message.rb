class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chatroom

  def read?
    read
  end
end
