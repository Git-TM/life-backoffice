class Peopletype < ApplicationRecord
  has_many :people
  # scope :category_best, -> { joins(:people).where("name LIKE ?", = "best")}
end
