class Listing < ActiveRecord::Base
  belongs_to :neighborhood
  belongs_to :host, :class_name => "User", :foreign_key => :host_id

  has_many :reservations
  #has_many :reservations, through: :guests, :class_name => "User"
  has_many :reviews, :through => :reservations
  has_many :guests, :class_name => "User", :through => :reservations

  validates :address, presence: true
  validates :title, presence: true
  validates :description, presence: true  
  validates :price, presence: true  
  validates :neighborhood, presence: true  
  validates :listing_type, presence: true  # or chain them together

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
    # binding.pry
    self.reviews.pluck(:rating).inject(:+).to_f/self.reviews.count
  #  reviews.pluck(:rating).inject(:+)/
  #Listing#average_review_rating knows its average ratings from its reviews
  end

end # end class
