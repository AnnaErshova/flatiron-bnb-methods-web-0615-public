class Listing < ActiveRecord::Base
  
  belongs_to :neighborhood
  belongs_to :host, :class_name => "User", :foreign_key => :host_id

  has_many :reservations
  has_many :reviews, :through => :reservations
  has_many :guests, :class_name => "User", :through => :reservations

  validates :address, :title, :description, :price, :neighborhood, :listing_type, presence: true

  after_create :change_host_status_to_true # callback
  before_destroy :change_host_status_to_false, if: :only_listing # if this is the listing the host has, we don't want them to be the host anymore after it gets destroyed

  def change_host_status_to_true
    host.update(host: true)
  end 

  def change_host_status_to_false
    host.update(host: false)
  end 

  def only_listing
    host.listings.count == 1
  end

  def average_review_rating
    reviews.pluck(:rating).inject(:+).to_f/reviews.count
  end

end # end class
