class User < ActiveRecord::Base

  has_many :listings, :foreign_key => 'host_id'

  has_many :reservations, :through => :listings
  
  has_many :trips, :foreign_key => 'guest_id', :class_name => "Reservation"

  has_many :guests, :through => :reservations #, :foreign_key => 'guest_id' # because a guest belongs to a reservation
  has_many :hosts, :source => :listings, :foreign_key => 'guest_id'

  has_many :guest_listings, :through => :trips, :source => :listing # guest_listings are listings of a reservation, which we have called a trip
  has_many :hosts, :through => :guest_listings
  # => guests => trips/reservation => listings => hosts

  has_many :reviews, :foreign_key => 'guest_id'
  has_many :host_reviews, :through => :reservations, :source => :review

end # end class