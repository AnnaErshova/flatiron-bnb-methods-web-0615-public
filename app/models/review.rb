class Review < ActiveRecord::Base

  belongs_to :reservation
  belongs_to :guest, :class_name => "User"

  validates :rating, presence: true
  validates :description, presence: true

  validate :has_valid_reservation
  def has_valid_reservation # strict validation is either with unless
    unless reservation && reservation.status == "accepted" && reservation.checkout < Date.today
      errors.add(:review, "You can only review a valid reservation")
    end
  end

end # end class
