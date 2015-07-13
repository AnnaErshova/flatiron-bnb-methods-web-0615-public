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
    if listings.count != 0 
      reservations.count / listings.count
    else 
      0
    end
  end

  def self.most_res
    all.max_by {|n| n.reservations.count}
  end

end