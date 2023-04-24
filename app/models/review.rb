class Review < ApplicationRecord
  belongs_to :user
  belongs_to :movie
  self.per_page = 5
end
