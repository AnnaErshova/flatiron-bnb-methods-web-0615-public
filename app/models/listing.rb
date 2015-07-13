class Listing < ActiveRecord::Base

  belongs_to :neighborhood
  belongs_to :host, :class_name => "User", :foreign_key => :host_id

  has_many :reservations
  has_many :reviews, :through => :reservations
  has_many :guests, :class_name => "User", :through => :reservations

  validates :address, :title, :description, :price, :neighborhood, :listing_type, presence: true

  # callbacks
  after_create :change_host_status_to_true 
  before_destroy :change_host_status_to_false, if: :only_listing 
  # if this is the listing the host has, 
  # we don't want them to be the host anymore after it gets destroyed

  # callback method
  def change_host_status_to_true
    host.update(host: true)
  end 

  # callback method
  def change_host_status_to_false
    host.update(host: false)
  end 

  # callback method
  def only_listing
    host.listings.count == 1
  end

  # instance method
  def average_review_rating
    sum_of_reviews/count_of_reviews
  end

  # helper method 
  def sum_of_reviews
    reviews.pluck(:rating).inject(:+).to_f
  end

  # helper method
  def count_of_reviews
    reviews.count
  end

end # end class
