class Review < ActiveRecord::Base

  belongs_to :reservation
  belongs_to :guest, :class_name => "User"

  validates_presence_of :rating, :description

  validate :has_valid_reservation
  def has_valid_reservation # strict validation is easier with unless
    unless reservation && (reservation.status == "accepted")
      errors.add(:review, "You can only review a valid reservation.")
    end
  end

  # breaking into two methods to give a user a more detailed error message
  validate :checkout_has_happened
  def checkout_has_happened
    unless reservation && (reservation.checkout < Date.today)
      errors.add(:review, "You can only review your stay after you have checked out.")
    end
  end

end # end class