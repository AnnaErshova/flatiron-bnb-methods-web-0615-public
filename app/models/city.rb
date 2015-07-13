class City < ActiveRecord::Base
  
  has_many :neighborhoods
  has_many :listings, :through => :neighborhoods
  has_many :reservations, :through => :listings

  def city_openings(start_range, end_range)
    # reservations are a giant nested hash, and we will use each_with_object 
    # to get into it
    reservations.each_with_object([]) do |outer_key, value|
      booked_range = outer_key.checkin..outer_key.checkout
      booked_range === start_range || booked_range === end_range unless value << outer_key.listing
    end
    # listings
    #  .joins(:reservations)
    #    .where('(checkin NOT BETWEEN ? AND ?) AND (checkin NOT BETWEEN ? AND ?)', start_date, end_date, start_date, end_date)
    ### question marks are read consecutively
  end

  def ratio_res_to_listings # instance method because asking individual city
    reservations.count / listings.count
  end

  def self.highest_ratio_res_to_listings
    all.max_by {|city| city.ratio_res_to_listings}
  end

  def self.most_res
    all.max_by {|city| city.reservations.count}
  end

end # end class

