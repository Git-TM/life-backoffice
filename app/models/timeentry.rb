class Timeentry < ApplicationRecord
  belongs_to :categorytime
  has_one :timsubcategory, through: :categorytimes
end
