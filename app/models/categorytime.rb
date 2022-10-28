class Categorytime < ApplicationRecord
  has_many :timesubcategories
  has_many :timeentries, through: :timeentries
end
