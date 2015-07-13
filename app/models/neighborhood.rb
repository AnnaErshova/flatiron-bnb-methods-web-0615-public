class Neighborhood < ActiveRecord::Base

  belongs_to :city

  has_many :listings
  has_many :reservations, through: :listings

  def neighborhood_openings(start_range, end_range)
    listings
      .joins(:reservations)
        .where('(checkin NOT BETWEEN ? AND ?) AND (checkin NOT BETWEEN ? AND ?)', start_range, end_range, start_range, end_range)
  end

  def self.highest_ratio_res_to_listings
    all.max_by {|n| n.ratio_res_to_listings}
  end

  def ratio_res_to_listings
    count_listings != 0 ? calculate_ratio : 0
  end

  # helper method
  def calculate_ratio
    count_reservations / count_listings
  end

  def self.most_res
    all.max_by {|n| n.count_reservations}
  end

  # helper method
  def count_reservations
    reservations.count
  end

  # helper method
  def count_listings
    listings.count
  end

end