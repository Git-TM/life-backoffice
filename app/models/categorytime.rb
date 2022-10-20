class Categorytime < ApplicationRecord
  has_many :timesubcategories
  has_many :timeentries
end
