class Movie < ApplicationRecord
  self.per_page = 6
  has_many :reviews, dependent: :destroy
  has_one_attached :image
  scope :order_by_max, -> { left_outer_joins(:reviews)
                              .group(:id)
                              .select('movies.*, avg(reviews.rating) as avg_rating')
                              .order(avg_rating: :desc)
  }

  scope :search, ->(query) { where("title LIKE ?", "%#{query}%") if query.present? }
  scope :released_on, ->(date) { where(release_date: date.to_date) if date.present? }
  def avg_rating
    if reviews.blank?
      0
    else
      reviews.average(:rating).round(2)
    end
  end
end
