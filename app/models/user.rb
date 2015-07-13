class User < ActiveRecord::Base

  has_many :listings, :foreign_key => 'host_id'
  has_many :reviews, :foreign_key => 'guest_id'

  has_many :reservations, :through => :listings
  has_many :trips, :foreign_key => 'guest_id', :class_name => "Reservation"

  has_many :guests, :through => :reservations, :foreign_key => 'guest_id'

  has_many :hosts, :source => :listings, :foreign_key => 'guest_id'
  # has_many :rooms,

end # end class

  #  as a guest, knows about the hosts its had 
  #  as a host, knows about its reviews from guests 
