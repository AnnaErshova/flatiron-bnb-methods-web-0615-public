class Listing < ActiveRecord::Base

  belongs_to :neighborhood
  belongs_to :host, :class_name => "User", :foreign_key => :host_id

  has_many :reservations
  has_many :reviews, :through => :reservations
  has_many :guests, :class_name => "User", :through => :reservations

  # validations : all the details need to be present
  validates :address, :title, :description, :price, :neighborhood, :listing_type, presence: true

  # callbacks
  after_create :change_host_status_to_true 
  before_destroy :change_host_status_to_false, if: :only_listing 
  # if this is the listing the host has, 
  # we don't want them to be the host anymore after it gets destroyed

  # callback method for after_create
  def change_host_status_to_true 
    host.update(host: true)
  end 

  # callback method for before_destroy
  def change_host_status_to_false
    host.update(host: false)
  end 

  # callback method for before_destroy
  def only_listing
    host.listings.count == 1
  end

  # instance method
  def average_review_rating
    sum_reviews/count_reviews
  end

    # helper method for average_review_rating
    def sum_reviews
      find_reviews.inject(:+).to_f
    end

      # nested helper method for sum_of_reviews
      def find_reviews
        reviews.pluck(:rating)
      end

    # helper method for average_review_rating
    def count_reviews
      reviews.count
    end

end # end class
