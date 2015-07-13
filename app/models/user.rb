class User < ActiveRecord::Base
  has_many :listings, :foreign_key => 'host_id'
  has_many :reservations, :through => :listings
  has_many :trips, :foreign_key => 'guest_id', :class_name => "Reservation"
  has_many :reviews, :foreign_key => 'guest_id'
  
  # has_many :users, :foreign_key => 'guest_id'
end
  #  as a host, knows about the guests its had (FAILED - 24)
  # User associations as a host, knows about the guests its had
  #  as a guest, knows about the hosts its had (FAILED - 25)
  #  as a host, knows about its reviews from guests (FAILED - 26)

  # as a host has many reservations through their listing