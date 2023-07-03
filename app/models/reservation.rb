class Reservation < ApplicationRecord
  before_validation :set_status
  belongs_to :activity
  belongs_to :user

  has_many :chatrooms
  enum status: { pending: "en attente", accepted: "confirmée", rejected: "refusée" }

  private

  def set_status
    self.status = "en attente" if self.status.nil?
  end
end
