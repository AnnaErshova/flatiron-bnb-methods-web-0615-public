require 'pry'

class City < ActiveRecord::Base
  has_many :neighborhoods
  has_many :listings, :through => :neighborhoods
  has_many :reservations, :through => :listings


  # City instance methods knows about all the available listings given a date range
  def city_openings(start_range, end_range)
    #binding.pry
    # reservations are a giant nested hash, and we will use each_with_ibject to get into it
    reservations.each_with_object([]) do |outer_key, value|
      booked_range = outer_key.checkin..outer_key.checkout
      booked_range === start_range || booked_range === end_range unless value << outer_key.listing
    end
    # listings
    #  .joins(:reservations)
    #    .where('(checkin NOT BETWEEN ? AND ?) AND (checkin NOT BETWEEN ? AND ?)', start_date, end_date, start_date, end_date)
    # question marks are read consecutively
  end

  # knows the city with the highest ratio of reservations to listings (FAILED - 1)
  # doesn't hardcode the city with the highest ratio of reservations to listings (FAILED - 2)
=begin
  def self.highest_ratio_res_to_listings # so they mean in the database

    self.all.each do |city|
      booking_ratio = (city.reservations.count / city.listings.count).to_f
      booking_hash = Hash.new
      booking_hash[city] = booking_ratio
      big_hash = Hash.new
      # binding.pry
      big_hash << booking_hash
    end
  end
=end

  def ratio_res_to_listings # instance method because asking individual city
    reservations.count / listings.count
  end

  def self.highest_ratio_res_to_listings
    all.max_by {|city| city.ratio_res_to_listings}
  end
 
  # knows the city with the most reservations (FAILED - 3)
  # knows the city with the most reservations (FAILED - 4)
  def self.most_res
    all.max_by {|city| city.reservations.count}
  end

end

