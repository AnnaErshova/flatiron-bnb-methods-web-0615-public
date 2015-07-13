class User < ActiveRecord::Base

  has_many :listings, :foreign_key => 'host_id'

  has_many :reservations, :through => :listings
  has_many :trips, :foreign_key => 'guest_id', :class_name => "Reservation"

  has_many :guests, :through => :reservations, :foreign_key => 'guest_id'
  has_many :hosts, :source => :listings, :foreign_key => 'guest_id'

  has_many :places, through: :trips, :source => :listing
  has_many :hosts, through: :places

  has_many :reviews, :foreign_key => 'guest_id'
  has_many :host_reviews, through: :reservations, source: :review

end # end class

# => guests => trips => listings => hosts