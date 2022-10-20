class Timeentry < ApplicationRecord
  belongs_to :timesubcategory
  has_one :categorytime, through: :timesubcategories
end
