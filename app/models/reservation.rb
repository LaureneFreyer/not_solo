class Reservation < ApplicationRecord
  belongs_to :activity
  belongs_to :user

  has_many :chatrooms
  has_many :ratings

  # enum status: [ :pending, :confirmed, :rejected]

  # def notify_host(force = true)
  #   @host = User.find(self.activity[:user_id])

  #   if @host.pending_reservations.length > 1 or !force
  #     return
  #   else
  #     message = "Vous avez une demande de #{self.name} pour participer à l'événement #{self.activity.title}. Répondez [accepter] ou [refuser]."
  #     @host.send_message(message)
  #   end
  # end

  # def confirm!
  #   self.status = "confirmed"
  #   self.save!
  # end

  # def reject!
  #   self.status = "rejected"
  #   self.save!
  # end

  # def notify_guest
  #   @guest = User.find_by(nickname: self.nickname)

  #   if self.status_changed? && (self.status == "confirmed") || self.status == "rejected"
  #     message = "Votre demande de participation pour l'activité #{self.activity.title} le #{self.activity.start_date} a été #{self.status}."
  #     @guest.send_message(message)
  #   end
  # end
end
