class Reservation < ActiveRecord::Base
  
  belongs_to :listing
  belongs_to :guest, :class_name => "User", :foreign_key => :guest_id

  has_one :review

  delegate :host, to: :listing

  validates :checkin, :checkout, presence: true

  validate :not_same_checkin_checkout
  def not_same_checkin_checkout
    if self.checkin == self.checkout
      errors.add(:reservation, "Checkin cannot be same as checkout")
    end
  end

  validate :valid_checkin_checkout
  def valid_checkin_checkout
    if (self.checkin && self.checkout) && (self.checkin > self.checkout)
      errors.add(:reservation, "Checkin must be before checkout")
    end
  end

  validate :guest_is_not_host
  def guest_is_not_host
    if guest == host
      errors.add(:reservation, "You cannot reserve your own listing")
    end
  end

  validate :reservation_available
  def reservation_available
    if self.status == "pending"
      errors.add(:reservation, "This reservation is not available")
    end
  end

  def duration
    self.checkout-self.checkin # (should it be + 1 to accommodate for the extra day?)
  end

  def total_price
    duration*self.listing.price
  end

end # end class

