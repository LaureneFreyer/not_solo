class Reservation < ApplicationRecord
  before_validation :set_status
  belongs_to :activity
  belongs_to :user

  has_many :chatrooms
  has_many :ratings

  enum status: { pending: "pending", accepted: "accepted", rejected: "rejected" }

  private

  def set_status
    self.status = "pending" if self.status.nil?
  end
end
